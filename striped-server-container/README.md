# striped-server-container

Description: docker container providing a striped server analysis environment

* jupyter
* vega
* histbook (git clone https://github.com/scikit-hep/histbook.git)
* striped server (git clone http://cdcvs.fnal.gov/projects/nosql-ldrd striped)

## Get the striped-server-container image

The container is based on CentOS 7, so first pull the latest CentOS image

```
docker pull centos
```

Clone this repository and create the striped-server-container image in the repository clone's directory with

```
docker build -t oguatworld/striped-server .
```

This uses the [Dockerfile](https://github.com/gutsche/docker-containers/raw/master/striped-server-container/Dockerfile) file from this repository.

Archive the image (if you want to transfer it to another machine) with

```
docker save oguatworld/striped-server | gzip -9c > striped-server.tgz
```

and play it back on another machine with

```
gunzip -c striped-server.tgz | docker load
```

## Run the striped-server-container image

The image uses a non-root user account named `PlayerOne` for the working environment. I start a container from the image with

```
docker run -it --rm -v $HOME/Dropbox/Work/Code:/home/PlayerOne/Code -v $HOME/Dropbox/Work/Data:/home/PlayerOne/Data -p 8888:8888 oguatworld/striped-server
```

which includes:

* forwarding port 8888 to the local machine to use a jupyter notebook started in the container on your local machine
* mounting two directories from your local machine in the `PlayerOne`'s home directory in the container
    * One for code that I am working on (checked out from GitHub  or local)
        * I always do all GitHub interactions from my local machine
    * One for data files to test and develop

## Working in the striped-server-container

Starting the container puts you in the context of the `PlayerOne` user. The user uses the zsh shell and [oh my zsh](https://github.com/robbyrussell/oh-my-zsh) and the container comes with tmux and vi.

Remember when you shut down the container, you loose everything you did in the container itself.

## Starting a jupyter notebook

An alias is available called `striped_notebook` which starts a notebook with

```
jupyter notebook --ip 0.0.0.0
```

Which provides you with a link to the notebook.

Good luck!
