# Project - Create a dockerfile  for todo application 

## Description
Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.

## Some of the commands used in Dockerfile

1. `FROM` - This command is used to set the base image for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction. The image can be any valid image – it is especially easy to start by pulling an image from the Public Repositories. Rest of the commands in the dockerfile will be executed on node container.
   
2. `RUN` - This command will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.
3. `WORKDIR` - This command is used to set the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
4. `RUN` - This command will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.
5. `EXPOSE` - This command informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
6. `CMD` - This command provides defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.

Note: There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.

NOTE: The main difference between CMD and RUN is that RUN actually executes the command and commits the result, while CMD does not execute anything at build time, but specifies the intended command for the image.


## Run this dockerfile
1. `docker build -t todo-app .` This will create a docker image with name `todo-app`
   
2. `docker run -p 8080:8080 todo-app` this will start  the application on port 8080.