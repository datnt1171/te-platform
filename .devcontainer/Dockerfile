FROM python:3.12

# Install common packages and tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    # PostgreSQL client (matches postgres:15)
    postgresql-client \
    # Tools
    git \
    curl \
    wget \
    vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (to match your 20.19.3 version)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Create workspace directory
RUN mkdir -p /workspace

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Configure Git for dev container usage (handle line endings properly)
RUN git config --system core.autocrlf input && \
    git config --system core.fileMode false && \
    git config --system core.eol lf