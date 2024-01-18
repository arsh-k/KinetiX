#include "mpi.h"
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstring>
#include <getopt.h>
#include <sstream>
#include <string>

#include "cantera/base/global.h" // provides Cantera::writelog
#include "cantera/core.h"
#include "cantera/kinetics/Reaction.h"
#include "cantera/thermo/ThermoFactory.h"
#include "cantera/thermo/ThermoPhase.h"
#include "cantera/thermo/IdealGasPhase.h"
#include "cantera/transport/MixTransport.h"
#include <iostream>

using namespace Cantera;

int main(int argc, char **argv) {

  MPI_Init(&argc, &argv);
  int rank, size;

  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  if (rank == 0)
    printf("size: %d\n", size);
  int err = 0;
  int n_states = 100000;
  int n_rep = 20;
  bool transport = false;
  bool debug = false;
  std::string mech;

  while (1) {
    static struct option long_options[] = {
        {"n-states", required_argument, 0, 's'},
        {"n-repetitions", required_argument, 0, 'r'},
        {"mechanism", required_argument, 0, 'm'},
        {"transport", no_argument, 0, 't'},
        {"debug", no_argument, 0, 'd'},
    };

    int option_index = 0;
    int args = getopt_long(argc, argv, "s:", long_options, &option_index);

    if (args == -1)
      break;

    switch (args) {
    case 's':
      n_states = std::stoi(optarg);
      break;
    case 'r':
      n_rep = std::stoi(optarg);
      break;
    case 'm':
      mech.assign(optarg);
      break;
    case 't':
      transport = true;
      break;
    case 'd':
      debug = true;
      break;

    default:
      err++;
    }
  }

  if (mech.size() < 1)
    err++;

  if (err > 0) {
    if (rank == 0)
      printf("Usage: ./cantera_test  --n-states n --n-repetitions n --mechanism f "
             "[--transport] [--debug] \n");
    exit(EXIT_FAILURE);
  }

  int nStates = n_states / size;
  int nRep = n_rep;

  // Initialize reaction mechanism
  auto sol = newSolution(mech);
  auto gas = sol->thermo();
  auto trans = sol->transport();
  double T = 1000.0;
  double p = 1e5;
  int nSpecies = gas->nSpecies();
  double Y[nSpecies];
  for (int k = 0; k < nSpecies; k++) {
    Y[k] = 1.0 / nSpecies;
  }
  gas->setState_TPY(T, p, Y);
  if (rank == 0){
    printf("T: %.1f K \n", T);
    printf("p: %.1f Pa \n", p);
    for (int k = 0; k < nSpecies; k++) {
      if (k == nSpecies - 1)
        printf("%s = %.5f \n", gas->speciesName(k).c_str(), Y[k]);
      else
        printf("%s = %.5f, ", gas->speciesName(k).c_str(), Y[k]);
    }
  }

  // Initialize reaction kinetics
  auto kin = sol->kinetics();

  // Initialize states vector
  int offset = nSpecies + 1;

  /*** Throughput ***/
  { //Chemistry
    double *ydot = (double *)(_mm_malloc(nStates * offset * sizeof(double), 64));
    
    MPI_Barrier(MPI_COMM_WORLD);
    const auto startTime = MPI_Wtime();

    for (int i = 0; i < nRep; i++) {
      for (int n = 0; n < nStates; n++) {
        double wdot[nSpecies];
        double h_RT[nSpecies];
        gas->setState_TPY(T, p, Y);

        kin->getNetProductionRates(wdot);
        for (int k = 0; k < nSpecies; k++)
          ydot[n + (k + 1) * nStates] = wdot[k] * gas->molecularWeight(k);

        gas->getEnthalpy_RT(h_RT);
        double sum_h_RT = 0;
        for (int k = 0; k < nSpecies; k++)
          sum_h_RT += wdot[k] * h_RT[k];
        double ratesFactorEnergy = -GasConstant * T;
        ydot[n] = ratesFactorEnergy * sum_h_RT;
      }
    }

    MPI_Barrier(MPI_COMM_WORLD);
    const auto elapsedTime = (MPI_Wtime() - startTime);

    if (rank == 0){
      printf("--- Chemistry ---\n");
      printf("avg elapsed time: %.5f s\n", elapsedTime);
      printf("avg aggregated throughput: %.3f GDOF/s (nStates = %d)\n",
             (size * (double)(nStates * offset) * nRep) / elapsedTime / 1e9,
             size * nStates);
    }

    if (debug) {
      for (int i = 0; i < nStates * offset; i++)
        printf("rates[%d]: %.8f \n", i, ydot[i]);
    }
  }

  if (transport) { //Transport
    double *cond = (double *)(_mm_malloc(nStates * sizeof(double), 64));
    double *visc = (double *)(_mm_malloc(nStates * sizeof(double), 64));
    double *rhoD = (double *)(_mm_malloc(nStates * nSpecies * sizeof(double), 64));

    MPI_Barrier(MPI_COMM_WORLD);
    const auto startTime = MPI_Wtime();

    for (int i = 0; i < nRep; i++) {
      for (int n = 0; n < nStates; n++) {
        gas->setState_TPY(T, p, Y);

        visc[n] = trans->viscosity();;
        cond[n] = trans->thermalConductivity();
	double *rhoD_i = rhoD + n*nSpecies;
        trans->getMixDiffCoeffs(rhoD_i);
      }
    }

    MPI_Barrier(MPI_COMM_WORLD);
    const auto elapsedTime = (MPI_Wtime() - startTime);

    if (rank == 0){
      printf("--- Transport properties ---\n");
      printf("avg elapsed time: %.5f s\n", elapsedTime); printf("avg aggregated throughput: %.3f GDOF/s (nStates = %d)\n",
             (size * (double)(nStates * offset) * nRep) / elapsedTime / 1e9,
             size * nStates);
    }
    
    if (debug){
      for (int i = 0; i < nStates; i++){
        printf("cond[%d]: %.8f \n", i, cond[i]);
        printf("visc[%d]: %.8f \n", i, visc[i]);
      }
      for (int i = 0; i < nStates * nSpecies; i++)
        printf("rhoD[%d]: %.8f \n", i, rhoD[i]);
    }
  }

  MPI_Finalize();
  exit(EXIT_SUCCESS);
}
