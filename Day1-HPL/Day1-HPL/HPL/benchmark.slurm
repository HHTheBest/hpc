#!/bin/bash
#SBATCH -J WuK_hpl # 任务名
#SBATCH -N 2 # 申请 2 个节点
#SBATCH --ntasks-per-node=4 # 每个节点开 4 个进程
#SBATCH --exclusive
HPL_DIR=`pwd`

#-------------------module load-------------------------------------
module load MPI/openmpi/1.10.7-icc-14.0.2-dynamic
#module load MPI/openmpi/1.10.7-gcc-4.8.5-dynamic
#module load opt/cuda/10.1
#module load opt/openmpi/openmpi3-x86_64
#module load nvme/openmpi/3.1.3-gcc4.8.5
#module load opt/intelcompilers/2016.4-compilers
module list

#-------------------------------------------------------------------
export HOSTNAME=`hostname`
echo "HOSTNAME=$HOSTNAME"

DATETIME=`hostname`.`date +"%m%d.%H%M%S"`

echo "Results in ./results/xhpl_8_gpu-$DATETIME-output.txt"

#-------------------------------------------------------------------

nvidia-smi

MPI_WHERE=`which mpirun`
echo "FINDMPI=$MPI_WHERE"

$MPI_WHERE --version

#--------------------run openmpi------------------------------------

export I_MPI_FAVRICS=shm:ofa
export CUDA_VISIBLE_DEVICES="0,1,2,3"
##HOSTFILE
#$MPI_WHERE -np 4 --hostfile ./hostfiles/host2_4 -bind-to none -x LD_LIBRARY_PATH ./run_linpack_GPU_2xv100 | tee ./results/xhpl_4_gpu-$DATETIME-output.txt

##RANKFILE
#$MPI_WHERE -np 8 -bind-to none -x LD_LIBRARY_PATH ./run_linpack_GPU_2xv100 | tee ./results/xhpl_4_gpu-$DATETIME-output.txt
$MPI_WHERE -np 8 -bind-to none -x LD_LIBRARY_PATH --mca btl_tcp_if_include ib0  ./run_linpack_GPU_4xgpu | tee ./results/xhpl_8_gpu-$DATETIME-output.txt
#$MPI_WHERE -np 8 -bind-to none -x LD_LIBRARY_PATH ./xhpl_GPU_cuda90103_static_mkl_2016_static_ompi_1.10.2_sm35_sm60_sm70 | tee ./results/xhpl_8_gpu-$DATETIME-output.txt