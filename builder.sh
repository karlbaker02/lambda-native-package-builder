#!/bin/bash
# Author : sudhay

function build_package_builder_base {

    docker build --no-cache=true -t package_builder_base:latest $working_dir/base_image
    BASE=$(docker images package_builder_base:latest -q)
}

function build_lambda_package_builder {

    docker build --no-cache=true -t lambda_package_builder:latest $working_dir
    APP_BASE=$(docker images lambda_package_builder:latest -q)
}

function create_deployment_package {


    CONTAINER_ID=$(docker run -t -d lambda_package_builder:latest)
    # CONTAINER_ID = $(docker ps --no-trunc -aqf "ancestor=lambda_package_builder")
    echo $CONTAINER_ID
    docker cp $CONTAINER_ID:/package/deployment_package.zip .
    docker stop $CONTAINER_ID
    docker rm $CONTAINER_ID

}



working_dir=$(pwd)

BASE=$(docker images package_builder_base:latest -q)
if [ -z $BASE ]; then
    echo "Package Builder BASE doesn't exist - creating Base Image"
    build_package_builder_base
    echo "Package Builder Base Image Build Complete"
else
    echo "Using Base image: $BASE"
fi

BUILDER=$(docker images lambda_package_builder:latest -q)

if [ -z $BUILDER ]; then
    build_lambda_package_builder
    echo "Package Builder Image Build Complete"
    create_deployment_package
    echo "#################################################################################"
    echo "Deployment package created : check for ## Archive.zip ## in the current directory"
    echo "#################################################################################"
else
    docker rmi -f lambda_package_builder
    build_lambda_package_builder
    echo "Package Builder Image Build Complete"
    create_deployment_package
    echo "#################################################################################"
    echo "Deployment package created : check for ## Archive.zip ## in the current directory"
    echo "#################################################################################"
fi