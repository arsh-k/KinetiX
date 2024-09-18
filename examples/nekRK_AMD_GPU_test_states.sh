#!/bin/bash
#SBATCH -A project_465000567 
#SBATCH -J nekRK
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH -t 08:00:00
#SBATCH -N 1
#SBATCH -p standard-g
#SBATCH --ntasks-per-node=2
#SBATCH --gpus-per-node=2

# -------
# 2560 GPU compute nodes
# 4× AMD MI250x GPUs
# -------

#module purge
#module load PrgEnv-gnu rocm craype-accel-amd-gfx90a craype-x86-trento cray-python
#module unload cray-libsci
#module list

ulimit -s unlimited
##############

###LiDryer
# 200K
rm -rf .cache/
srun ../bin/nekrk_bk --backend HIP --n-states 20000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 20000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 20000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 500K
srun ../bin/nekrk_bk --backend HIP --n-states 50000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 50000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 50000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 1M
srun ../bin/nekrk_bk --backend HIP --n-states 100000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 100000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 ---fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 100000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 2M 
srun ../bin/nekrk_bk --backend HIP --n-states 200000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 200000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 200000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 5M 
srun ../bin/nekrk_bk --backend HIP --n-states 500000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 500000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 500000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 10M 
srun ../bin/nekrk_bk --backend HIP --n-states 1000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 1000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 1000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 20M 
srun ../bin/nekrk_bk --backend HIP --n-states 2000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 2000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 2000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 50M 
srun ../bin/nekrk_bk --backend HIP --n-states 5000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 5000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 5000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 100M 
srun ../bin/nekrk_bk --backend HIP --n-states 10000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 10000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 10000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 200M 
srun ../bin/nekrk_bk --backend HIP --n-states 20000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 20000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 20000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 500M 
srun ../bin/nekrk_bk --backend HIP --n-states 50000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 50000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 50000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele
# 1B 
srun ../bin/nekrk_bk --backend HIP --n-states 100000000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 1 --loop-gibbsexp
srun ../bin/nekrk_bk --backend HIP --n-states 100000000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/LiDryer.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --grop-vis
srun ../bin/nekrk_bk --backend HIP --n-states 100000000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/LiDryer.yaml --tool Pele

###gri30
# 200K
rm -rf .cache/
srun ../bin/nekrk_bk --backend HIP --n-states 3703 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 3703 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 3703 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 500K
srun ../bin/nekrk_bk --backend HIP --n-states 9259 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 9259 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 9259 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 1M
srun ../bin/nekrk_bk --backend HIP --n-states 18518 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 18518 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 18518 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele 
# 5M
srun ../bin/nekrk_bk --backend HIP --n-states 92590 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 92590 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 92590 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 10M
srun ../bin/nekrk_bk --backend HIP --n-states 185180 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 185180 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 185180 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 20M
srun ../bin/nekrk_bk --backend HIP --n-states 370360 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 370360 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 370360 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 50M
srun ../bin/nekrk_bk --backend HIP --n-states 925900 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 925900 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 925900 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 100M
srun ../bin/nekrk_bk --backend HIP --n-states 1851800 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 1851800 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 1851800 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 200M
srun ../bin/nekrk_bk --backend HIP --n-states 3703600 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 3703600 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 3703600 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 500M
srun ../bin/nekrk_bk --backend HIP --n-states 9259000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 9259000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 9259000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele
# 1B
srun ../bin/nekrk_bk --backend HIP --n-states 18518000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 1 --loop-gibbsexp --group-rxnUnroll
srun ../bin/nekrk_bk --backend HIP --n-states 18518000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/gri30.yaml --unroll-loops 0 --fit-rcpDiffCoeffs --nonsymDij
srun ../bin/nekrk_bk --backend HIP --n-states 18518000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/gri30.yaml --tool Pele


###Konnov 
rm -rf .cache/
srun ../bin/nekrk_bk --backend HIP --n-states 1538 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 1538 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 1538 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 500K
srun ../bin/nekrk_bk --backend HIP --n-states 3846 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 3846 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 3856 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 1M
srun ../bin/nekrk_bk --backend HIP --n-states 7692 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 7692 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 7692 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 2M
srun ../bin/nekrk_bk --backend HIP --n-states 15384 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 15384 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 15384 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 5M
srun ../bin/nekrk_bk --backend HIP --n-states 38460 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 38460 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 38460 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 10M
srun ../bin/nekrk_bk --backend HIP --n-states 76920 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 76920 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs
srun ../bin/nekrk_bk --backend HIP --n-states 76920 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 20M
srun ../bin/nekrk_bk --backend HIP --n-states 153840 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 153840 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 153840 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 50M
srun ../bin/nekrk_bk --backend HIP --n-states 384600 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 384600 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 384600 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 100M
srun ../bin/nekrk_bk --backend HIP --n-states 769200 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 769200 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 769200 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 200M
srun ../bin/nekrk_bk --backend HIP --n-states 1538400 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 1538400 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs
srun ../bin/nekrk_bk --backend HIP --n-states 1538400 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 500M
srun ../bin/nekrk_bk --backend HIP --n-states 3846000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1
srun ../bin/nekrk_bk --backend HIP --n-states 3846000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 3846000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
# 1B
srun ../bin/nekrk_bk --backend HIP --n-states 7692000 --repetitions 100 --mode 1 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 1 
srun ../bin/nekrk_bk --backend HIP --n-states 7692000 --repetitions 100 --mode 2 --yaml-file ../mechanisms/Konnov.yaml --unroll-loops 0 --fit-rcpDiffCoeffs 
srun ../bin/nekrk_bk --backend HIP --n-states 7692000 --repetitions 100 --mode 0 --yaml-file ../mechanisms/Konnov.yaml --tool Pele
