# Set the base image to PYTHON
FROM python:3

# File Author / Maintainer
LABEL maintainer="Arthur Costa da Silva <root.arthur@gmail.com>"

# Install global fdependence
RUN apt-get -y update && \
  apt-get install -y --fix-missing \
  build-essential \
  cmake \
  gfortran \
  git \
  wget \
  curl \
  graphicsmagick \
  libgraphicsmagick1-dev \
  libavcodec-dev \
  libavformat-dev \
  libboost-all-dev \
  libgtk2.0-dev \
  libjpeg-dev \
  liblapack-dev \
  libswscale-dev \
  pkg-config \
  python3-dev \
  python3-numpy \
  software-properties-common \
  zip \
  && apt-get clean && rm -rf /tmp/* /var/tmp/*

# Install BLIB
RUN cd ~ && \
  mkdir -p dlib && \
  git clone -b 'v19.7' --single-branch https://github.com/davisking/dlib.git dlib/ && \
  cd  dlib/ && \
  python3 setup.py install --yes USE_AVX_INSTRUCTIONS

# Define working directory
WORKDIR /usr/src/app

# Copy requirements
COPY requirements.txt ./

# Install requirements
RUN pip install --no-cache-dir -r requirements.txt

# Copy directory
COPY . .

# RUN app using nodemon
CMD [ "python", "./script.py" ]