

# Working with OLCF Jupyter

The simplest method of cloning doesn't work:

    conda create -p /ccs/proj/gen150/fwang2/deep --clone base

Here, the `base` is the cuda11 environment if I am not mistaken.



## Here is what worked:

```bash
conda create -p /ccs/proj/gen150/fwang2/deep-py38 python=3.8
source activate /ccs/proj/gen150/fwang2/deep-py38
conda install cudatoolkit=11.1 cudnn -c nvidia -c conda-forge -c defaults
conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch-lts -c nvidia
conda install graphviz jupyterlab -c conda-forge -c defaults
pip install torchviz
conda install tensorboard jupyterlab_widgets jupyter_telemetry jupyterhub-base jupyter-server-proxy jupyterhub jupyter_bokeh
conda install scikit-learn pandas matplotlib
python -m ipykernel install --user --name deep-py38 --display-name deep-py38
```



After activating, to make your created environment visible in JupyterLab, run 

    python -m ipykernel install --user --name deep --display-name deep 
    
A kernelspec is created in your /ccs/home/<YOUR_UID>/.local/share/jupyter directory which JupyterLab reads to see which custom environments are available for it to use.


When you refresh the page and look at the Launcher, you will see buttons labelled "deep". Clicking it will start a Notebook or Console running in your "deep" environment.


To delete your environment, you will need to delete it from the path where the environment was created, as well as delete the corresponding directory from `~/.local/share/jupyter/kernels`.


## PATH fix

Apparently, the conda environment was not properly activated, here is the fix I need to do in my notebook:

```python
import os
os.environ["PATH"]+= os.pathsep + "/ccs/proj/gen150/fwang2/deep-py38/bin"
```
