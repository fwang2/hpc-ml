
- [Basics](#basics)
  - [Training Boilerplate](#training-boilerplate)
  - [Optimizer](#optimizer)
  - [Standardization](#standardization)
  - [Checkpoint](#checkpoint)
  - [Logits, Logistic Regression, Classification](#logits-logistic-regression-classification)
  - [Metrics: TPR/recall, precision, accuracy, ROC](#metrics-tprrecall-precision-accuracy-roc)
- [Vision](#vision)
- [NLP](#nlp)

# Basics

## Training Boilerplate

First step is to build a **model**:
* define features or parameters (for example, $b$ and $w$)
* define loss function
* define optimizer

With a model at hand, there are 3 main steps to be iterated:

* **forward**: calculating predicted output
* **backward**: compute the gradient using loss function (partial derivative to the feature)
* **update parameters**: use gradient to update parameters to minimize the loss. This is the role an **optimizer** performs.


## Optimizer

An optimizer takes the input of features/parameters, learning rate, and other hyper-parameters, and do the **update** through `optimizer.step()` function.

Essentially, different optimizer will give you a different path to traverse to the optimal point on the loss surface.


If manually provisioning the parameters:
```
optimizer = optim.SGD([b,w],lr=lr)
```

For models using `nn.Parameter()`, we can:
```
optimizer = optim.SGD(model.parameters(), lr=lr)
```

## Standardization

* Based on loss function, each feature has a loss curve
* Each feature, based on the loss curve, has **very different** optimal learning rates
* However, learning rate is global (apply to all features)
* therefore, it makes sense to _try_ to make all features loss curve similar - but not always possible.
* Standardization (`StandardScalar` in sklearn) is one such technique that could make loss curve(s) more uniform (?), thus converge better (reaching optimal point) and faster.

## Checkpoint

The following states to be defined as a dictionary, that is to be saved:

* `model.state_dict()`
* `optimizer.state_dict()`
* `loss`: training loss and validation loss
* `epoch`

We use `torch.save()` and `torch.load()` for this purpose; And we also need to take care that once we reload the model, we need to set the model in the training mode: `model.train()` 


## Logits, Logistic Regression, Classification


* A **logit**, $z$, is a linear regression without that error term:
$z = b + w_1 x_1 + w_2 x_2$ for example.

* For classification problem, we transform the value of logit, $z$, through some function, say, sigmoid, `torch.sigmoid()` or `nn.Sigmoid()`,then we have a probabilistic output. This **non-linear** sigmoid function plays a **fundamental role** in neural network - without it, NN (no matter how many layers) is equivalent to linear regression.

* Given certain probabilistic threshold, e.g., 0.5, we can classify the result being either positive or negative.

* The loss function for binary classification is defined by **binary cross-entropy (BCE)**, also known as **log loss**: `loss_fn = nn.BCELoss(reduction='mean')`.

## Metrics: TPR/recall, precision, accuracy, ROC

* The first letter is T, says model got it right: TP is true positive, TN is true negative; Vice versa, if the first letter is F, says model got it wrong: FP is false positive, FN is false negative.

* When **false negative** is really bad? Airport security, **positive means existence of a threat** where false positive is okay, but false negative, means model fails to detect an actual threat, is **really bad**. In this case, **improving TPR** is needed.
  
* When **false positive** is really bad? Investment, **positive** means a good/profitable investment. false negative means model missed a profitable investment opportunity, but it didn't lose money; where a **false positive**  you choose invest, but lost the money.

* Accuracy: $(TP+TN) / (TP+TN+FP+FN)$. The problem with this **common** metric is when you have an **imbalanced dataset**: say you have 990 negative points out of 1000; so a model predicts only negative outcome will have 99% accuracy, but never got any positive right.

* ROC: TBD

# Vision


# NLP