# Summit Notes

- [Summit Notes](#summit-notes)
  - [Request a single interactive node](#request-a-single-interactive-node)
  - [Making connections](#making-connections)
    - [step 1: to login node](#step-1-to-login-node)
    - [step 2: to batch node (after node request granted)](#step-2-to-batch-node-after-node-request-granted)
    - [step 3: launch jupyter notebook jobs](#step-3-launch-jupyter-notebook-jobs)
    - [step 4: tunnel it back:](#step-4-tunnel-it-back)
    - [More](#more)


## Request a single interactive node

The batch-hm queues allows a max of 24 hours, must longer than debug queue.

```
bsub -P STF008 -nnodes 1 -q batch-hm   -W 24:00 -Is $SHELL
```





## Making connections

### step 1: to login node

My Mac setup allows me to use secureID card and PIN to login. You might need something different, for example RSA token issued by OLCF.

```sh
ssh -X -I /usr/local/lib/opensc-pkcs11.so fwang2@summit.olcf.ornl.gov
```

### step 2: to batch node (after node request granted)

To experiment, let's use an interactive shell and ask for 120 minutes time of it:

```sh
cd summit-ml/jupyterlab
bsub -P STF008 -nnodes 1 -W 120 -alloc_flags nvme -Is /bin/bash
```

If successful, now you should be taken to batch node such as:

```sh
<<Waiting for dispatch ...>>
<<Starting on batch5>>
```

### step 3: launch jupyter notebook jobs

From batch node, you can interactively launch this job, and you want this to be in the background actually:

```sh
jsrun -n1 -a1 -c42 -g6 -r1 start-jupyter.sh 8887 &
```

The most important information after this is:

```sh
The Jupyter Notebook is running at
http://h36n04:8887/
```

### step 4: tunnel it back:

```sh
ssh  -L9999:localhost:8000 -X -I /usr/local/lib/opensc-pkcs11.so fwang2@summit.olcf.ornl.gov
ssh -L 8000:localhost:8887 h36n04
```

### More

* you don't have connect to the same login node
* you tunnel from login node directly into compute node

All above steps are largely manual - it is adapted from: [Araki, Shuto](https://code.ornl.gov/25a/distributed_deep_learning_on_summit)' work.  Due to the changing environment on Summit, the scripts provided there is probably out of date.
