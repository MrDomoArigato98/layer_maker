# layer_maker
Basic bash script to make an AWS Lambda layer for Python runtimes, zip it, and upload it to AWS Lambda

Usage
./create_layer.sh <package-name> <python-version> <layer-name>

./create_layer.sh requests python3.11 requests_python3.11
