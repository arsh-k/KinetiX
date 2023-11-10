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
#include <iostream>

using namespace Cantera;

int main(int argc, char **argv) {

  MPI_Init(&argc, &argv);
  int rank, size;

  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  printf("size: %d\n", size);

  int err = 0;
  int n_states = 100000;
  int n_rep = 20;
  std::string mech;

  while (1) {
    static struct option long_options[] = {
        {"n-states", required_argument, 0, 's'},
        {"n-repetitions", required_argument, 0, 'r'},
        {"mechanism", required_argument, 0, 'm'},
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

    default:
      err++;
    }
  }

  if (mech.size() < 1)
    err++;

  if (err > 0) {
    if (rank == 0)
      printf("Usage: ./cantera_test  [--n-states n] [--n-repetitions n] "
             "[--mechanism f] \n");
    exit(EXIT_FAILURE);
  }

  int Nstates = n_states / size;
  int Nrep = n_rep;

  // Initialize reaction mechanism
  auto sol = newSolution(mech);
  auto gas = sol->thermo();
  double T = 1000.0;
  double p = 1e5;
  int nSpecies = gas->nSpecies();
  double Y[nSpecies];
  for (int i = 0; i < nSpecies; i++) {
    Y[i] = 1.0 / nSpecies;
  }
  gas->setState_TPY(T, p, Y);
  printf("T: %.1f K \n", T);
  printf("p: %.1f Pa \n", p);
  for (int i = 0; i < nSpecies; i++) {
    if (i == nSpecies - 1)
      printf("%s = %.5f \n", gas->speciesName(i).c_str(), Y[i]);
    else
      printf("%s = %.5f, ", gas->speciesName(i).c_str(), Y[i]);
  }

  // Initialize reaction kinetics
  auto kin = sol->kinetics();

  // Initialize states vector
  int offset = nSpecies + 1;
  double *ydot = (double *)(_mm_malloc(Nstates * offset * sizeof(double), 64));
  double wdot[nSpecies];
  double h_RT[nSpecies];

  /*** Throughput ***/
  for (int i = 0; i < Nrep; i++) {

    MPI_Barrier(MPI_COMM_WORLD);
    const auto startTime = MPI_Wtime();

    for (int n = 0; n < Nstates; n++) {
      kin->getNetProductionRates(wdot);
      for (int k = 0; k < nSpecies; k++)
        ydot[n + (k + 1) * Nstates] = wdot[k] * gas->molecularWeight(k);

      gas->getEnthalpy_RT(h_RT);
      double sum_h_RT = 0;
      for (int k = 0; k < nSpecies; k++)
        sum_h_RT += wdot[k] * h_RT[k];
      double ratesFactorEnergy = -GasConstant * T;
      ydot[n] = ratesFactorEnergy * sum_h_RT;
    }

    MPI_Barrier(MPI_COMM_WORLD);
    const auto elapsedTime = (MPI_Wtime() - startTime);

    printf("avg aggregated throughput: %.3f GDOF/s (Nstates = %d)\n",
           (size * (double)(Nstates * offset)) / elapsedTime / 1e9,
           size * Nstates);
  }

#if 0
  for (int i = 0; i < Nstates * offset; i++)
    printf("rates[%d]: %.8f \n", i, ydot[i]);
#endif

  MPI_Finalize();
  exit(EXIT_SUCCESS);
}