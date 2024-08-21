

- [Install Note (2024)](#install-note-2024)
  - [apex](#apex)
- [Build from source (2023)](#build-from-source-2023)
  - [prep Frontier modules](#prep-frontier-modules)
  - [module output on Frontier](#module-output-on-frontier)
  - [setup miniconda3](#setup-miniconda3)
  - [build pytorch](#build-pytorch)
    - [Build options: see `setup.py`](#build-options-see-setuppy)
    - [regenerate CMAKE build files](#regenerate-cmake-build-files)
    - [Kineto and roctracer.h problem](#kineto-and-roctracerh-problem)
  - [Build DeepSpeed](#build-deepspeed)
  - [Install GPTNeoX](#install-gptneox)



# Install Note (2024)

conda is available at `/sw/aaims/frontier/miniconda3`.
make sure this is on your path.



```
conda create -n torch25 python=3.12
source activate torch25
pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/rocm6.0
```

## apex

git clone https://github.com/ROCm/apex
cd apex
pip install -r requirement.txt



# Build from source (2023)



## prep Frontier modules

```
module load PrgEnv-gnu
module load gcc/10.3.0
module load rocm/5.1.0
module load craype-x86-trento
export HCC_AMDGPU_TARGET=gfx90a
export PYTORCH_ROCM_ARCH=gfx90a
export ROCM_SOURCE_DIR=/opt/rocm-5.1.0
export CRAY_CPU_TARGET=x86_64 # just to remove warning noise
```
## module output on Frontier

```
Currently Loaded Modules:
  1) libfabric/1.15.2.0   4) cray-dsmml/0.2.2        7) gcc/10.3.0             10) DefApps/default    13) craype-accel-amd-gfx90a
  2) craype-network-ofi   5) cray-libsci/22.12.1.1   8) darshan-runtime/3.4.0  11) cray-mpich/8.1.23  14) craype-x86-trento
  3) craype/2.7.19        6) PrgEnv-gnu/8.3.3        9) hsi/default            12) rocm/5.1.0
```

Note: One of the module between `craype-x86-trento` and `craype-accel-amd-gfx90a` fixed a linking problem. My guess is the former. 

## setup miniconda3

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ./Miniconda3-latest-Linux-x86_64.sh -b -p miniconda
conda create -n pytorch python=3.8
conda active pytorch
pip install -r requirements.txt
```

## build pytorch

```
git clone --recursive -b IFU-master-2022-11-22 https://github.com/ROCmSoftwarePlatform/pytorch
python tools/amd_build/build_amd.py
USE_KINETO=0 USE_ROCM=1 MAX_JOBS=4 python setup.py bdist_wheel 2>&1 | tee output
```

### Build options: see `setup.py`

```
USE_KINETO=0 # disable profiler, ask for roctracer.h
```
### regenerate CMAKE build files

This will trigger a rebuild for the changed configuration.

```
cd pytorch/build
rm CMakeCache.txt
```
To remove previous build as well:

```
python setup.py clean
```
### Kineto and roctracer.h problem

Kineto requires roctracer, which fails in rocm 5.1.0

```
if (NOT ROCM_SOURCE_DIR)
    set(ROCM_SOURCE_DIR "$ENV{ROCM_SOURCE_DIR}")
    message(INFO " ROCM_SOURCE_DIR = ${ROCM_SOURCE_DIR}")
endif()
```

For reason unknown at this point, the `ROCM_SOURCE_DIR` is still set as `/opt/rocm` instead of `/opt/rocm-5.1.0` even though the environment variable is set.

So the easy workaround is:

```
set(ROCM_SOURCE_DIR /opt/rocm-5.1.0)
```

## Build DeepSpeed

```
git clone https://github.com/microsoft/DeepSpeed
DS_BUILD_FUSED_LAMB=1 DS_BUILD_FUSED_ADAM=1 DS_BUILD_TRANSFORMER=1 DS_BUILD_STOCHASTIC_TRANSFORMER=1  DS_BUILD_UTILS=1 python setup.py bdist_wheel
python setup.py install
```

## Install GPTNeoX

```
pip install shortuuid # missed from
git clone https://github.com/EleutherAI/gpt-neox.git
pip install -r requirements/requirements.txt
pip install -r requirements/requirements-wandb.txt
pip install -r requirements/requirements-tensorboard.txt
```


