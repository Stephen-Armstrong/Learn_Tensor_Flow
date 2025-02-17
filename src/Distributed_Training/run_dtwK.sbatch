#!/bin/bash
#
#SBATCH --time=4:00:00                  # Job run time (hh:mm:ss)
#SBATCH --nodes=2                        # Number of nodes
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2               # Number of compute threads per proc
##SBATCH --mem-per-cpu=15G
#SBATCH --gpus-per-task=1 			#Number of GPUs per task
#SBATCH --job-name=dtwK        # Name of batch job
#SBATCH --partition=secondary    # Partition (queue)
#SBATCH --account=dcurreli-npre-eng
#SBATCH --output=/u/sda3/Learn_Tensor_Flow/src/Distributed_Training/Outputs/%x_%j_output.o               # Name of batch job output file
#SBATCH --error=/u/sda3/Learn_Tensor_Flow/src/Distributed_Training/Outputs/%x_%j_error.e                # Name of batch job error file
##SBATCH --mail-user=sda3@illinois.edu  # Send email notifications
##SBATCH --mail-type=BEGIN,END           # Type of email notifications to send
###############################################################################

# OpenMP will complain if these options aren't set.
export OMP_PLACES=cores 
export OMP_PROC_BIND=spread
export OMPI_MCA_mpi_warn_on_fork=0 # Need this cause OpenMP will complain, but only for python/mpi4py not hPIC2
export PYTHONUNBUFFERED=1

#export EXE='python3 -u'
export DECK='/u/sda3/Learn_Tensor_Flow/src/Distributed_Training/Distributed_Training_with_Keras.py'

mpirun -np 2 --mca btl_tcp_if_include hsn0 python3  ${DECK}
