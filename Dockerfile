FROM jupyter/all-spark-notebook

USER jovyan

## Installing jupyter-vim-binding
## https://github.com/lambdalisue/jupyter-vim-binding
RUN mkdir -p $(jupyter --data-dir)/nbextensions && \
    cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding.git vim_binding

## Python libraries to connect to SQL databases.
RUN conda install -n python2 psycopg2 SQLAlchemy

## Downloading jdbc driver for Postgres
RUN cd $HOME && \
    mkdir drivers && \ 
    cd drivers && \
    wget https://jdbc.postgresql.org/download/postgresql-9.4.1208.jre7.jar

USER root

## The following variables didn't work to load the Postgres driver with the Spark
## JVM.
# ENV SPARK_OPTS $SPARK_OPTS --driver-class-path=/home/jovyan/drivers/postgresql-9.4.1208.jre7.jar
# ENV EXTRA_CLASSPATH /home/jovyan/drivers/postgresql-9.4.1208.jre7.jar

## Although it seems to be deprecated, this was the only solution that I found for
## now.
## This official documentation uses the same variable:
## http://spark.apache.org/docs/latest/sql-programming-guide.html#jdbc-to-other-databases
ENV SPARK_CLASSPATH /home/jovyan/drivers/postgresql-9.4.1208.jre7.jar

## Increasing the available JVM memory.
ENV SPARK_OPTS --driver-java-options=-Dlog4j.logLevel=info --driver-java-options=-Xms4G --driver-java-options=-Xmx5G

USER jovyan

RUN jupyter nbextension enable vim_binding/vim_binding
