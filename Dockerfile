FROM jupyter/all-spark-notebook

USER jovyan

## Installing jupyter-vim-binding
## https://github.com/lambdalisue/jupyter-vim-binding
RUN mkdir -p $(jupyter --data-dir)/nbextensions && \
    cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding.git vim_binding

# RUN conda install -n python2 psycopg2
RUN conda install -n python2 SQLAlchemy

## Run this command after starting the container.
# jupyter nbextension enable vim_binding/vim_binding
