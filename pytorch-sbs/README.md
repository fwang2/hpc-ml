# Study Notes


## Standardization

* Based on loss function, each feature has a loss curve
* Each feature, based on the loss curve, has **very different** optimal learning rates
* However, learning rate is global (apply to all features)
* therefore, it makes sense to _try_ to make all features loss curve similar - but not always possible.
* Standardization (`StandardScalar` in sklearn) is one such technique that could make loss curve(s) more uniform (?), thus converge better (reaching optimal point) and faster.

