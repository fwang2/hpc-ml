
The note describes the steps to build pytorch from source on Crusher/Frontier.


- [Anaconda3 base install](#anaconda3-base-install)
- [Module](#module)
- [set up more dependencies required for pytorch](#set-up-more-dependencies-required-for-pytorch)
- [clone and setup pytorch source](#clone-and-setup-pytorch-source)


## Anaconda3 base install

```
wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
bash Anaconda3-2022.05-Linux-x86_64.sh
```

install path: `/sw/aaims/crusher/anaconda3`


    You have chosen to not have conda modify your shell scripts at all.
    To activate conda's base environment in your current shell session:

    eval "$(/sw/aaims/crusher/anaconda3/bin/conda shell.YOUR_SHELL_NAME hook)"

    To install conda's shell functions for easier access, first activate, then:

    conda init

    If you'd prefer that conda's base environment not be activated on startup,
    set the auto_activate_base parameter to false:

    conda config --set auto_activate_base false



## Module

Assume we set up a module under `/sw/aaims/crusher/modulefiles`, first, we need to set the search path:

    module use /sw/aaims/crusher/modulefiles

Next, create a directory and write the lua module description file:

    mkdir /sw/aaims/crusher/modulefiles/anaconda3
    touch 2022.05.lua 

Now, the rough sketch of this file is:

```lua
local root_dir = "/sw/aaims/crusher/anaconda3"
local prefix = root_dir

help([[
Description - Anaconda 3 - ver 2022.05
]])

-- Required for "module display ..."
whatis("Deep machine learning environment.")
whatis("Description: A python anaconda environment pre-loaded with many popular machine learning frameworks")

conflict('python')

-- prepend_path("PATH", pathJoin(prefix, "bin"))

function myShell()
  local shell = os.getenv('SHELL') or '/usr/bin/sh'
  local root, fname, suffix = string.match(shell, "(.-)([^\\/]-%.?([^%.\\/]*))$")
  return fname
end

if mode() == 'load' then
  local my_shell = myShell()
  if my_shell == "zsh" then
    -- Overload the zsh 'type' builtin (equal to 'whence -v') be compatible
    -- with bash-style 'type -P' invocations.
    execute {cmd='function type () { if [[ "$@[1]" == "-P" ]]; then; whence -p "${@:2}"; else; whence -v "$@"; fi }', modeA={'load'}}
  elseif my_shell == "tcsh" or my_shell == "csh" then
    LmodMessage(myModuleUsrName() .. ":")
    LmodMessage("    Only bash/sh shells are officially supported.")
    LmodMessage("    The conda environment may not be fully initialized.")
  end
end

execute {cmd="source /sw/aaims/crusher/anaconda3/etc/profile.d/conda.sh && conda activate",modeA={"load"}}
execute {cmd="source /sw/aaims/crusher/anaconda3/etc/profile.d/conda.sh && conda deactivate",modeA={"unload"}}
```

Now we are at a point:

    module load anaconda3
    module unload anaconda3

## set up more dependencies required for pytorch

First, we create a pristine environment from the scratch 

```

```

## clone and setup pytorch source



```
module load PrgEnv-gnu
module load gcc/10.3.0
module load rocm/5.1.0
export HCC_AMDGPU_TARGET=gfx90a
export PYTORCH_ROCM_ARCH=gfx90a
export CC=cc
export CXX=CC

git clone --recursive -b IFU-master-2022-06-03 https://github.com/ROCmSoftwarePlatform/pytorch pytorch

pushd pytorch
sed -i '1946s/\/rocm/\/rocm-5.1.0/' cmake/Dependencies.cmake
git submodule init
git submodule update
python tools/amd_build/build_amd.py
CC=cc CXX=CC USE_ROCM=1 MAX_JOBS=4 python3 setup.py bdist_wheel
pip install dist/*.whl
popd pytorch
```

This should build the wheel for us. Now on to torch vision:

```
git clone --recursive https://github.com/ROCmSoftwarePlatform/vision
cd vision
python setup.py bdist_wheel
```

There is no more customization on this step. It should go without a hitch.


