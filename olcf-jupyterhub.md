
This is to create a Conda environment `deep-py38` for use on OLCF jupyterhub. It is located at `/ccs/proj/gen150/fwang2/deep-py38`.

- [Create new Conda environment](#create-new-conda-environment)
- [Make new environment visible via Jupyterhub](#make-new-environment-visible-via-jupyterhub)
- [PATH fix](#path-fix)




## Create new Conda environment

Start a terminal within Jupyter session on through OLCF jupyterhub.

```
conda create -p /ccs/proj/gen150/fwang2/pt-cuda11 --clone base
source activate /ccs/proj/gen150/fwang2/pt-cuda11
pip install transformers
python -m ipykernel install --user --name pt-cuda11 --display-name pt-cuda11
```

The default `base` is CUDA11 environment.


