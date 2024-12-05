FROM devopsdarshan7.jfrog.io/darshu-docker-local/debian:bullseyedev

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-venv python3-pip \
    dh-make debhelper build-essential fakeroot curl && \
    apt-get clean

# Set the workspace directory
WORKDIR /workspace

# Default command
CMD ["bash"]