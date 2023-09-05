#!/usr/bin/bash -i

target_dir=$PWD
miniconda_dir=$target_dir/miniconda
conda_dst_dir=$target_dir/rocm_env

target_python_ver=3.10

source_file_name=torch_rocm5.rc
rocm_version=5.5.1

target_amd_gpu=gfx90a

module load PrgEnv-gnu
module swap gcc gcc/11.2.0
module load rocm/$rocm_version

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $miniconda_dir

echo "#!/usr/bin/bash -i" >& $source_file_name

echo "module load PrgEnv-gnu" >> $source_file_name
echo "module load rocm/"$rocm_version >> $source_file_name
echo "module list" >> $source_file_name

echo "export PATH="$miniconda_dir"/bin:\$PATH"  >> $source_file_name
echo "eval ""\"\$($miniconda_dir/bin/conda shell.bash hook)\"" >> $source_file_name

export PATH=$miniconda_dir/bin:$PATH
eval "$(/$miniconda_dir/bin/conda shell.bash hook)"


which conda
conda create -y --prefix=$conda_dst_dir python=$target_python_ver


echo "conda activate  $conda_dst_dir" >> $source_file_name
conda activate $conda_dst_dir
conda update -y -n base -c defaults conda
conda install -y pyyaml
conda install -y numpy

pip install typing_extensions

conda install -y bazel
conda install -y -c conda-forge keras-preprocessing

pip install pytest
pip install ninja


# The following is required only when using Conda
conda install -y -c conda-forge libssh

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.4.2

pip install accelerate==0.18.0
pip install datasets==2.12.0
pip install deepspeed==0.9.1
pip install huggingface-hub==0.14.1
pip install Pillow==9.4.0
# tokenizers==0.11.4 does not work because Rust compiler issue
pip install tokenizers==0.11.5
pip install transformers==4.24.0
pip install webdataset==0.2.48

pip install ./mpi4py-3.1.3-cp310-cp310-linux_x86_64.whl


