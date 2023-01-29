

## Request a GPU node for 24 hrs

```
salloc -A stf008 -p gpu -N 4 -t: 24:00:00
module load miniconda3
```

Currently, it shows 4 GPU available from the partition nodes.

## Access to external resources

This applies to all NCCS compute cluster

```
export all_proxy=socks://proxy.ccs.ornl.gov:3128/
export ftp_proxy=ftp://proxy.ccs.ornl.gov:3128/
export http_proxy=http://proxy.ccs.ornl.gov:3128/
export https_proxy=http://proxy.ccs.ornl.gov:3128/
export no_proxy='localhost,127.0.0.0/8,*.ccs.ornl.gov
```

## Fast compression

It appears to be faster than the default `z` option. Decompression is even more so. The ratio for plain text is roughly 3:1

```
 tar cvf - core-EN | lz4 > core-EN.tar.lz4
```


To unzip:

```
lz4 -dc < core-EN.tar.lz4 | tar xvf -
```
