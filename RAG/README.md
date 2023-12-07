

# setup


## provide openapi key


using %env OPENAI_API_KEY=blablah format



## Required packages

```
pip install langchain openai faiss-cpu tiktoken docarray ipywidgets \
    sentence-transformers \
    chromadb \
```

* docarray: data representation for machine learning tasks
* faiss-cpu: similarity search and clustering for dense vectors, from facebook AI.


## Proxy error

This only applies for holly tunnel environment
this can be fixed at the startup

```
import os
del os.environ['all_proxy']
```

`all_proxy` is causing an error for "holly"



## pydantic validation error

There is a case where one can run into validation error when using RAG.
It is suggested this is version mismatch problem with langchain.

what I have working right now:

```
pydantic==1.10.10
pydantic-core==2.14.5
langchain==0.0.345
langchain-core==0.0.9
transformers==4.32.1
huggingface_hub==0.17.3
```


## embeddings

https://datasciencedojo.com/blog/embeddings-and-llm

