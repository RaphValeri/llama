#!/bin/bash -l

################# Part-1 Slurm directives ####################
## Working dir
#SBATCH -D /users/rv2018/files/MScProject/llama
## Environment variables
#SBATCH --export=ALL
## Output and Error Files
#SBATCH -o job-%j.output
#SBATCH -e job-%j.error
## Job name
#SBATCH -J captioning_inference
## Run time: "hours:minutes:seconds", "days-hours"
#SBATCH --time=3-20:00:00
## Memory limit (in megabytes). Total --mem or amount per cpu --mem-per-cpu
#SBATCH --mem-per-cpu=20000
## GPU requirements
#SBATCH --gres gpu:1
## Specify partition
#SBATCH -p gpu

################# Part-2 Shell script ####################
#===============================
#  Activate Flight Environment
#-------------------------------
source "${flight_ROOT:-/opt/flight}"/etc/setup.sh

#==============================
#  Activate Package Ecosystem
#------------------------------
# e.g.:
# Load the conda environment
flight env activate conda
conda activate torchEnv


#===========================
#  Create results directory
#---------------------------
RESULTS_DIR="$(pwd)/${SLURM_JOB_NAME}-outputs/${SLURM_JOB_ID}"
echo "Your results will be stored in: $RESULTS_DIR"
mkdir -p "$RESULTS_DIR"

#===============================
#  Application launch commands
#-------------------------------
# Customize this section to suit your needs.

echo "Executing job commands, current working directory is $(pwd)"

# REPLACE THE FOLLOWING WITH YOUR APPLICATION COMMANDS
echo "----------------------------------" >> $RESULTS_DIR/test.output
echo "INFERENCE" >> $RESULTS_DIR/test.output
echo "Temperature = 0, ..., 1.1" >> $RESULTS_DIR/test.output
echo "----------------------------------" >> $RESULTS_DIR/test.output


#torchrun --nproc_per_node 1 captioning_inference.py --model_path params_ep1_80.pt --nb_ca 1 --p_test 1.0 --temperature 0.0 --json_path res_files/test_data/1ca_ep1/eval_1ca_ep1_t0.0.json >> $RESULTS_DIR/test.output
torchrun --nproc_per_node 1 captioning_inference.py --model_path params_2ca_ep1.pt --nb_ca 2 --p_test 1.0 --temperature 0.0 --json_path res_files/test_data/2ca_ep1/eval_2ca_ep1_t0.0.json >> $RESULTS_DIR/test.output