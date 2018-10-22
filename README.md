# lambda-native-package-builder
Automates building python packages [specifically C based] for AWS - lambda in native amazon-linux environment


# Lambda Package Builder :
  
  *** build specifically for python 3.6 Lambda Functions
  *** doesnt add Lambda function code
  *** only for python packages

# Requirements :
    -> Docker


# Steps to build deployment package :
1] make changes to requirements.txt [ include all the required python packages  ]

2] convert builder.sh to executable [chmod +x builder.sh]

3] Run the builder script [./builder.sh]

4] Use the deployment_package.zip that appears in the current directory to create the lambda deployment package 
