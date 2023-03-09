# CMake on Frontier








## CUDA or HIP

`cmake/share/Modules/CMakeAddNewLanguage.txt` has some notes on what is going on with add new language support. The recommended way to enable CUDA or HIP is like the following:

    enable_language({HIP|CUDA})

### bypass compiler check

Sometimes, the HIP compiler check script got issues, we have a way to bypass it:

    cd build
    cmake -DCMAKE_HIP_COMPILER_FORCED=True ..

