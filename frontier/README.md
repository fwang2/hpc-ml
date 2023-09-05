

- [Single node](#single-node)
  - [Verify](#verify)


# Single node

Max allowed wall time on Frontier: 120 minutes:

```
salloc -A stf008 -N 1 -t 2:00:00 
```

Current environment:

```
ssh allocate_frontier_node
module load craype-x86-trento craype-network-ofi perftools-base xpmem cray-pmi PrgEnv-cray DefApps
cd rocm551-py310
source ./torch5_rocm5.rc
```

## Verify 

```
python -c "import torch; print(torch.cuda.device_count())"
8
```
Also, `ds_report` should give you detailed report on DS build
