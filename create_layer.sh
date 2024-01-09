#!/bin/bash

# Function to install pip package, package it as a zip, and upload directly to AWS Lambda
create_layer() {
    PACKAGE_NAME=$1
    PYTHON_VERSION=$2
    LAYER_NAME=$3
    LAYER_DIR="python"

    # Check if all required arguments are provided
    if [ -z "$PACKAGE_NAME" ] || [ -z "$LAYER_NAME" ] || [ -z "$PYTHON_VERSION" ]; then
        echo "Usage: $0 <package-name> [python-version] <layer-name>"
        exit 1
    fi

    # Install package
    echo "Installing $PACKAGE_NAME..."
    pip install $PACKAGE_NAME -t $LAYER_DIR

    # Package into a zip file
    ZIP_FILE="${PACKAGE_NAME}_lambda_layer.zip"
    echo "Packaging into $ZIP_FILE..."
    zip -r ./$ZIP_FILE $LAYER_DIR
    
    sleep 5
    # Upload Lambda layer
    echo "Creating Lambda layer $LAYER_NAME..."
    aws lambda publish-layer-version --layer-name $LAYER_NAME --compatible-runtimes $PYTHON_VERSION --zip-file fileb://$ZIP_FILE

    echo "Lambda layer created and uploaded: $LAYER_NAME"
}

# Usage: ./create_layer.sh <package-name> [python-version] <layer-name>
create_layer $1 $2 $3