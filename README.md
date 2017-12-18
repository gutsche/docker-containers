# spark-container

Description: docker container providing a Jupyter/Spark/ROOT analysis environment

* Jupyter 1.0.0
* Apache Toree 0.2.0.dev1
* Scala 2.11.8
* Spark 2.2.1
* ROOT 6.10.08

## Get the spark-container image

The container is based on CentOS 7, so first pull the latest CentOS image

```
docker pull centos
```

Clone this repository and create the spark-container image in the repository clone's directory with

```
docker build -t oguatworld/spark .
```

Archive the image (if you want to transfer it to another machine) with

```
docker save oguatworld/spark | gzip -9c > spark.tgz
```

and play it back on another machine with

```
gunzip -c spark.tgz | docker load
```

I am also keeping a recent image [on my DropBox](http://tinyurl.com/y9pmdqog). You can try to download it before attempting to build it.

## Run the spark-container image

The image uses a non-root user account named `PlayerOne` for the working environment. I start a container from the image with

```
docker run -it --rm -v $HOME/Dropbox/Work/Code:/home/PlayerOne/Code -v $HOME/Dropbox/Work/Data:/home/PlayerOne/Data -p 8888:8888 oguatworld/spark
```

which includes:

* forwarding port 8888 to the local machine to use a jupyter notebook started in the container on your local machine
* mounting two directories from your local machine in the `PlayerOne`'s home directory in the container
    * One for code that I am working on (checked out from GitHub  or local) 
        * I always do all GitHub interactions from my local machine
    * One for data files to test and develop

## Working in the spark-container

Starting the container puts you in the context of the `PlayerOne` user. The user uses the zsh shell and [oh my zsh](https://github.com/robbyrussell/oh-my-zsh) and the container comes with tmux and vi. 

Remember when you shut down the container, you loose everything you did in the container itself.

## Starting a jupyter notebook

The container uses Apache Toree which was configures both with pyspark and scala access to Spark. An alias is available called `toree_notebook` which starts a notebook with

```
SPARK_OPTS='--packages org.diana-hep:spark-root_2.11:0.1.15,org.diana-hep:histogrammar-sparksql_2.11:1.0.3' jupyter notebook --ip 0.0.0.0
```

Which loads the libraries for spark-root and histogrammar and then provides you with a link to the notebook. 

```
PlayerOne@68ed6db980a1 -> ~ -> toree_notebook
[I 15:25:48.726 NotebookApp] Serving notebooks from local directory: /home/PlayerOne
[I 15:25:48.726 NotebookApp] 0 active kernels
[I 15:25:48.726 NotebookApp] The Jupyter Notebook is running at:
[I 15:25:48.726 NotebookApp] http://0.0.0.0:8888/?token=5373e63bc383c9bf009583e683c48985d5aee52003152a29
[I 15:25:48.726 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 15:25:48.727 NotebookApp] No web browser found: could not locate runnable browser.
[C 15:25:48.728 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://0.0.0.0:8888/?token=5373e63bc383c9bf009583e683c48985d5aee52003152a29
```

Copy the link and paste it into your browser to access the notebook:

<p align="center">
  <img src="http://tinyurl.com/yagqxmuv" alt="Notebook Screenshot">
</p>

There is also an attempt to start `pyspark` through the alias `pyspark_jupyter` which executes

```
pyspark --packages org.diana-hep:spark-root_2.11:0.1.15,org.diana-hep:histogrammar-sparksql_2.11:1.0.3
```

and relies on the two environment variables be set in the `.zshrc`:

```
export PYSPARK_DRIVER_PYTHON=/bin/jupyter-notebook
export PYSPARK_DRIVER_PYTHON_OPTS="--ip=0.0.0.0"
```

Good luck!