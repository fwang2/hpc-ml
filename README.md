# hpc-ml 

my notes on ML/DL and HPC.

## Running environment (JupyterHub at OLCF)

* First login (http://jupyter.olcf.ornl.gov), and launch a terminal:

```
        # create a spec based on current BASE conda environment
        conda list --explicit > spec-file.txt

        # create a new environment, which will persist
        conda create -p /ccs/proj/gen150/fwang2/mistral --file spec-file.txt 

        # other customization if needed, then activate 
        source activate /ccs/proj/gen150/fwang2/mistral
```

* Make newly created environment visiable

```
        python -m ipykernel install --user --name mistral --display-name mistral
```

Now, when you start a new launcher, you should see the new kernel "mistral" listed.
  
## Regression

* [Linear Regression](Regression/Linear-Regression.ipynb)
* [Linear Regression using PyTorch](Regression/regressiion-pytorch.ipynb)
* [Logistic Regression using PyTorch](Regression/logistic-pytorch.ipynb)

## Dimension Reduction

* [Single Value Decomposition](PCA/SVD.ipynb)

## Clustering

* [Hierarchical Clustering](Clustering/hierarchical_clustering.ipynb)
* [K-means Clustering](Clustering/kmeans.ipynb)
* [DBSCAN](Clustering/DBSCAN.ipynb)
  
## Deep Learning
* [Gradient Descent](deep/gd-general.ipynb)
* [Compute Graph, Back Propagation](deep/autograd.ipynb)
* [Neural Network Concept](deep/ANN-basics.ipynb)
* [2-Layer Gradient Descent](deep/gd_2_layer.ipynb)
* [3-Layer Gradient Descent](deep/gd_3_layer.ipynb)
* [Regularization and dropout](deep/regularization.ipynb)
* [Activation Functions](deep/activation_functions.ipynb)
    * [Look into softmax and cross-entropy in PyTorch context](DL/softmax.ipynb)

* [CNN](DL/CNN.ipynb)
* [RNN and LSTM](DL/RNN.ipynb)
* [Transferred Learning](DL/transfer_learning.md)
* [Federated Learning](DL/federated_learning.md)

## Scalable Learning

### RNN and LSTM
* [My RNN Notes](deep/RNN.ipynb)
* [Unreasonable effectiveness of RNN](http://karpathy.github.io/2015/05/21/rnn-effectiveness/)
* [Understanding LSTM, Colah's Blog](https://colah.github.io/posts/2015-08-Understanding-LSTMs/), there is accompanying [Krish's explaination](shorturl.at/bdeTX).
* [Word embedding](shorturl.at/BIL25)
* [Running Jupyter on Summit](JupyterOnSummit.md)

## Tools

* [numpy](tools/numpy.ipynb), [matplotlib](tools/matplotlib.ipynb)
* [Customized data loader](tools/data_loader.ipynb)
* [Linear Algebra Review](Linear-Algebra-Review.ipynb)
