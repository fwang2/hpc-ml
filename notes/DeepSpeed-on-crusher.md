

This is work-in-progress:


Clone a copy of latest DeepSpeed, and make the following two changes:
```
git clone --recursive https://github.com/microsoft/DeepSpeed
```


### Build modification

`DeepSpeed/op_builder/builder.py` line 192: 
change to: 
```python
with open('/opt/rocm-5.1.0/.info/version-dev', 'r') as file:
```

### update python-hipify

The torch install includes a copy it, but it is outdated and can't recognize the `header_include_dirs` keywords, thus, we need to update it:

```
git clone https://github.com/ROCmSoftwarePlatform/hipify_torch

cd hipify_torch/hipify
cp * /autofs/nccs-svm1_sw/aaims/crusher/anaconda3/envs/torch/lib/python3.8/site-packages/torch/utils/hipify
```


## Build from source

We can now do `python setup.py bdist_wheel`

However, no extension will be built. 



For example:

```
export __HIP_PLATFORM_AMD__
export HCC_AMDGPU_TARGET=gfx90a
export ROCM_HOME=$ROCM_PATH
DS_BUILD_FUSED_LAMB=1 DS_BUILD_FUSED_ADAM=1 DS_BUILD_CPU_ADAM=1  DS_BUILD_TRANSFORMER=1 DS_BUILD_STOCHASTIC_TRANSFORMER=1  DS_BUILD_UTILS=1 python setup.py bdist_wheel
```

