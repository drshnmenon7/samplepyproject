#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Define project details
PROJECT_NAME="sampleproject"
VERSION="0.1.0"
OUTPUT_DIR="build-output"

# Step 1: Build the Docker image
echo "Building Docker image..."
docker build -t python-deb-builder -f Dockerfile .

# Step 2: Run the Docker container to build the .deb package
echo "Running Docker container to build the package..."
docker run --rm -v $(pwd):/workspace python-deb-builder bash -c "
    set -e
    OUTPUT_DIR=/workspace/${OUTPUT_DIR}

    # Verify the debian directory exists and contains required files
    if [ ! -d /workspace/debian ]; then
        echo 'Error: debian directory is missing.' >&2
        exit 1
    fi
    if [ ! -f /workspace/debian/control ] || [ ! -f /workspace/debian/rules ] || [ ! -f /workspace/debian/compat ]; then
        echo 'Error: Required files (control, rules, compat) are missing in the debian directory.' >&2
        exit 1
    fi

    echo 'Building the .deb package...'
    dpkg-buildpackage -us -uc -b

    # Move .deb package to output directory
    mkdir -p \${OUTPUT_DIR}
    mv ../*.deb \${OUTPUT_DIR}/
"

echo "Build completed. Find the .deb package in the ${OUTPUT_DIR}/ directory."
