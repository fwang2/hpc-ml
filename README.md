---
layout: default
---

My notes on ML/DL and HPC: 

- [The Setup](#the-setup)
- [Regression](#regression)
- [Dimension Reduction](#dimension-reduction)
- [Clustering](#clustering)
- [Deep Learning](#deep-learning)
- [Tools](#tools)

---

## The Setup

* [pytorch on Frontier](notes/pytorch-on-crusher.md)
* [DeepSpeed on Frontier](notes/DeepSpeed-on-crusher.md)
* [DeepSpeed on Summit](notes/DeepSpeed-on-Summit.md)
* [Jupyter on Summit](JupyterOnSummit.md). The better and alternative path is to use Slate, unless you need multiple GPU setup.

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
* [Gradient Descent](DL/gd-general.ipynb)
* [Compute Graph, Back Propagation](DL/autograd.ipynb)
* [Neural Network Concept](DL/ANN-basics.ipynb)
* [2-Layer Gradient Descent](DL/gd_2_layer.ipynb)
* [3-Layer Gradient Descent](DL/gd_3_layer.ipynb)
* [Regularization and dropout](DL/regularization.ipynb)
* [Activation Functions](DL/activation_functions.ipynb)
    * [Look into softmax and cross-entropy in PyTorch context](DL/softmax.ipynb)
* [CNN](DL/CNN.ipynb)
* [RNN and LSTM](DL/RNN.ipynb)
* [Transferred Learning](DL/transfer_learning.md)
* [Federated Learning](DL/federated_learning.md)

## NLP 

* [Understanding LSTM](https://colah.github.io/posts/2015-08-Understanding-LSTMs/)

## Tools

* [numpy](tools/numpy.ipynb), [matplotlib](tools/matplotlib.ipynb)
* [Customized data loader](tools/data_loader.ipynb)
* [Linear Algebra Review](Linear-Algebra-Review.ipynb)
