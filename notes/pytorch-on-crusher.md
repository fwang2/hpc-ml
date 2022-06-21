


## Anaconda3 base install

```
wget https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh
bash Anaconda3-2022.05-Linux-x86_64.sh
```

install path: /sw/aaims/crusher/anaconda3


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

install common deps:

```
conda install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses
conda install mkl mkl-include

```

## clone and setup pytorch source

```
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
module load rocm/4.5.2
python tools/amd_build/build_amd.py
```

Next we will try to compile

```
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
echo $CMAKE_PREFIX_PATH
--> /sw/aaims/crusher/anaconda3
```

Finally show time:
```
python setup.py install
```

### Using Cray PrgEnv
```
module load PrgEnv-cray
CC=cc CXX=CC python setup.py build
```

`cc` and `CC` are both Cray compiler wrappers.


### error 1
```
[4478/6659] Building CXX object third_party/kineto/libkineto/CMakeFiles/kineto_base.dir/src/ActivityProfilerController.cpp.o
FAILED: third_party/kineto/libkineto/CMakeFiles/kineto_base.dir/src/ActivityProfilerController.cpp.o
/usr/bin/c++ -DHAVE_MALLOC_USABLE_SIZE=1 -DHAVE_MMAP=1 -DHAVE_SHM_OPEN=1 -DHAVE_SHM_UNLINK=1 -DIDEEP_USE_MKL -DMINIZ_DISABLE_ZIP_READER_CRC32_CHECKS -DNDEBUG -DONNXIFI_ENABLE_EXT=1 -DONNX_ML=1 -DONNX_NAMESPACE=onnx_torch -DROCM_VERSION=50100 -DTORCH_HIP_VERSION=404 -DUSE_EXTERNAL_MZCRC -D_FILE_OFFSET_BITS=64 -I/opt/rocm-5.1.0/miopen/include -I../cmake/../third_party/benchmark/include -I../third_party/onnx -Ithird_party/onnx -I../third_party/foxi -Ithird_party/foxi -I../third_party/kineto/libkineto/include -I../third_party/kineto/libkineto/src -I../third_party/fmt/include -I/extras/CUPTI/include -I/include -I/opt/rocm/roctracer/include -isystem third_party/gloo -isystem ../cmake/../third_party/gloo -isystem ../cmake/../third_party/googletest/googlemock/include -isystem ../cmake/../third_party/googletest/googletest/include -isystem ../third_party/protobuf/src -isystem /sw/aaims/crusher/anaconda3/include -isystem ../third_party/gemmlowp -isystem ../third_party/neon2sse -isystem ../third_party/XNNPACK/include -isystem ../cmake/../third_party/eigen -isystem /autofs/nccs-svm1_sw/aaims/crusher/anaconda3/include -isystem /opt/rocm-5.1.0/hip/include -isystem /opt/rocm-5.1.0/rocblas/include -isystem /opt/rocm-5.1.0/hipfft/include -isystem /opt/rocm-5.1.0/hipsparse/include -isystem /opt/rocm-5.1.0/hiprand/include -isystem /opt/rocm-5.1.0/rocrand/include -isystem /opt/rocm-5.1.0/include -isystem ../third_party/ideep/mkl-dnn/third_party/oneDNN/include -isystem ../third_party/ideep/include -isystem ../third_party/ideep/mkl-dnn/include -Wno-deprecated -fvisibility-inlines-hidden -DUSE_PTHREADPOOL -fopenmp -DNDEBUG -O3 -DNDEBUG -DNDEBUG -fPIC -fvisibility=hidden -DCAFFE2_USE_GLOO -DTH_HAVE_THREAD -DHAS_ROCTRACER -D__HIP_PLATFORM_HCC__ -D__HIP_PLATFORM_AMD__ -DKINETO_NAMESPACE=libkineto -DFMT_HEADER_ONLY -std=c++14 -std=c++14 -MD -MT third_party/kineto/libkineto/CMakeFiles/kineto_base.dir/src/ActivityProfilerController.cpp.o -MF third_party/kineto/libkineto/CMakeFiles/kineto_base.dir/src/ActivityProfilerController.cpp.o.d -o third_party/kineto/libkineto/CMakeFiles/kineto_base.dir/src/ActivityProfilerController.cpp.o -c ../third_party/kineto/libkineto/src/ActivityProfilerController.cpp
In file included from ../third_party/kineto/libkineto/src/ActivityProfilerController.cpp:12:0:
../third_party/kineto/libkineto/src/RoctracerActivityApi.h:16:10: fatal error: roctracer.h: No such file or directory
#include <roctracer.h>
          ^~~~~~~~~~~~~
compilation terminated.
```
