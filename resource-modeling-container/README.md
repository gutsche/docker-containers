# resource-modeling-container

Description: docker container providing a resource-modeling environment with a custom user PlayerOne

## Get the resource-modeling-container image

The container is based on CentOS 7, so first pull the latest CentOS image

```
docker pull centos
```

Clone this repository and create the resource-modeling-container image in the repository clone's directory with

```
docker build -t oguatworld/resource-modeling .
```

This uses the [Dockerfile](https://github.com/gutsche/docker-containers/blob/master/resource-modeling-container/Dockerfile) file from this repository.

Archive the image (if you want to transfer it to another machine) with

```
docker save oguatworld/resource-modeling | gzip -9c > resource-modeling.tgz
```

and play it back on another machine with

```
gunzip -c resource-modeling.tgz | docker load
```

I am also keeping a recent image [on my DropBox](http://tinyurl.com/ybh3wftc). You can try to download it before attempting to build it.

## Run the resource-modeling-container image

The image uses a non-root user account named `PlayerOne` for the working environment. I start a container from the image with

```
docker run -it --rm -v $HOME/Dropbox/Work/Code:/home/PlayerOne/Code -v $HOME/Dropbox/Work/Data:/home/PlayerOne/Data oguatworld/resource-modeling
```

which includes:

* mounting two directories from your local machine in the `PlayerOne`'s home directory in the container
    * One for code that I am working on (checked out from GitHub  or local) 
        * I always do all GitHub interactions from my local machine
    * One for data files to test and develop

## Working in the resource-modeling-container

Starting the container puts you in the context of the `PlayerOne` user. The user uses the zsh shell and [oh my zsh](https://github.com/robbyrussell/oh-my-zsh) and the container comes with tmux and vi. 

Remember when you shut down the container, you loose everything you did in the container itself.