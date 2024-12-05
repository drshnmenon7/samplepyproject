#!/bin/bash


set -e  # Exit immediately if a command exits with a non-zero status

cd "$(dirname "$0")/.."

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
    DEBIAN_DIR=/workspace/debian
    OUTPUT_DIR=/workspace/${OUTPUT_DIR}

    echo 'Setting up debian directory...'
    mkdir -p \${DEBIAN_DIR}

    # Create control file
    echo 'Creating control file...'
    cat > \${DEBIAN_DIR}/control <<EOF
Source: ${PROJECT_NAME}
Section: python
Priority: optional
Maintainer: Darshan <drshnmenon7@gmail.com>
Build-Depends: debhelper (>= 9), python3
Standards-Version: 4.5.1

Package: ${PROJECT_NAME}
Architecture: all
Depends: \${misc:Depends}, python3
Description: Sample Python project packaged as a .deb
 This is a sample project used to demonstrate creating .deb packages.
EOF

    # Create rules file
    echo 'Creating rules file...'
    cat > \${DEBIAN_DIR}/rules <<EOF
#!/usr/bin/make -f
%:
  \$@
EOF
    chmod +x \${DEBIAN_DIR}/rules

    # Create compat file
    echo 'Creating compat file...'
    echo '12' > \${DEBIAN_DIR}/compat

    # Create changelog file
    echo 'Creating changelog file...'
    cat > \${DEBIAN_DIR}/changelog <<EOF
${PROJECT_NAME} (${VERSION}) unstable; urgency=low

  * Initial release.

 -- Your Name <your-email@example.com>  $(date -R)
EOF

    # Build package
    echo 'Building the .deb package...'
    dpkg-buildpackage -us -uc -b

    # Move .deb package to output directory
    mkdir -p \${OUTPUT_DIR}
    mv ../*.deb \${OUTPUT_DIR}/
"

echo "Build completed. Find the .deb package in the ${OUTPUT_DIR}/ directory."
