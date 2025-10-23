FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
# Install all system dependencies required by OpenLambda
RUN apt-get update && apt-get install -y \
    ca-certificates curl wget git sudo make build-essential python3 zlib1g-dev \
    docker.io llvm-14-dev libclang-common-14-dev \
    # Clean up apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Install the specific Go version required
RUN wget -q -O /tmp/go.tar.gz https://go.dev/dl/go1.21.5.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm /tmp/go.tar.gz \
 && ln -s /usr/local/go/bin/go /usr/bin/go

WORKDIR /workspace
RUN git config --system --add safe.directory /workspace
CMD ["/bin/bash"]
