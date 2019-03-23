# CV Website  [![Build Status](https://travis-ci.org/Hairlock/cv.svg?branch=master)](https://travis-ci.org/Hairlock/cv)

### Full Build
* docker-compose up

## Frontend

Built in purescript halogen with hot reloading using parceljs

### Build commands
* npm i / yarn install
* psc-package build
* yarn serve-dev


## Backend

Build in Haskell with Servant Api served with Warp using Persistent against a postgres db

### Build commands
* stack build
* stack ghci
* :l DevelMain
* Develmain.update

## Deployment

### Travis ci 
* Travis performs Docker build and deploys ui and nginx images
* If on staging branch then trigger deploy on amazon elb (see .travis.yml)
* ELB pulls from [docker hub](https://cloud.docker.com/u/yannicksealy/repository/docker/yannicksealy/cv-ui) and updates the running environment 

The live website can be found [here](https://yannicksealy.dev)