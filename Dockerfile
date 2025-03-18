FROM ubuntu:20.04

# Copy sources.list early to leverage layer caching
COPY sources_bionic.list /etc/apt/sources.list

# Set non-interactive frontend to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages in a single step and clean up afterward
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip gcc vim libprotobuf-dev wget\
    zlib1g zlib1g-dev libsm6 libgl1 libglib2.0-0 android-tools-adb \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create symlinks for Python & Pip
RUN ln -sfn /usr/bin/idle3 /usr/bin/idle && \
    ln -sfn /usr/bin/pydoc3 /usr/bin/pydoc && \
    ln -sfn /usr/bin/python3 /usr/bin/python && \
    ln -sfn /usr/bin/python3-config /usr/bin/python-config && \
    ln -sfn /usr/bin/pip3 /usr/bin/pip

# Upgrade pip and configure mirror
RUN python -m pip install --upgrade pip && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip config set install.trusted-host pypi.tuna.tsinghua.edu.cn


# Install required Python packages in one step to optimize layer caching
RUN pip3 install torch==1.10.1

# Download and install RKNN Toolkit 2 in one step to avoid extra layers
RUN wget --no-check-certificate  \
    https://raw.githubusercontent.com/airockchip/rknn-toolkit2/master/rknn-toolkit2/packages/x86_64/rknn_toolkit2-2.3.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl && \
    pip install rknn_toolkit2-2.3.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl  && \
    rm rknn_toolkit2-2.3.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl  && \
    pip cache purge

# Verify Python & Pip versions
RUN python3 --version && pip3 --version

# docker build --pull --rm -f 'Dockerfile' .