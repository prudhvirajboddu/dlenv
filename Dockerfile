FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu18.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
ENV SHELL /bin/zsh
ENV LANG=en_US.UTF-8
ENV ZSH_THEME agnoster

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    cmake \
    curl \
    gcc \
    git \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
    locales \
    net-tools \
    wget \
    zsh \
    && rm -rf /var/lib/apt/lists/*


RUN locale-gen en_US.UTF-8
RUN /bin/sh -c chsh -s /bin/zsh

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH
    
RUN conda --version

RUN rm -f miniconda.sh
    
RUN conda create -y -n ml python=3.9

RUN /bin/zsh -c "source activate ml && pip install tensorflow==2.10 && conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia"


# RUN /bin/zsh -c ""

# RUN /bin/zsh -c "conda install pytorch torchvision torchaudio cudatoolkit=11.1 -c pytorch -c nvidia"

# RUN curl -fsSL https://code-server.dev/install.sh | sh
# RUN mkdir -p /root/.code-server/extensions

# RUN wget https://github.com/microsoft/vscode-python/releases/download/2020.5.86806/ms-python-release.vsix
# RUN code-server --install-extension ms-python-release.vsix

# RUN mkdir -p /root/.local/share/code-server/User/
# COPY settings.json /root/.local/share/code-server/User/
