FROM ubuntu:16.04

## Put everything in some subfolder
WORKDIR "/pngtoklg"

## Container's mount point for the host's input/output folder
VOLUME "/input-output"


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        module-init-tools build-essential \
        ca-certificates wget git cmake python-pip \
	libboost-all-dev zlib1g-dev libpng-dev \
	libjpeg-dev unzip 
RUN wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip
RUN unzip opencv-2.4.9.zip 

WORKDIR /pngtoklg/opencv-2.4.9/build
RUN cmake -D BUILD_NEW_PYTHON_SUPPORT=OFF -D WITH_OPENCL=OFF -D WITH_OPENMP=ON -D INSTALL_C_EXAMPLES=OFF -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF -D WITH_QT=OFF -D WITH_OPENGL=OFF -D WITH_VTK=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D WITH_CUDA=OFF -D BUILD_opencv_gpu=OFF ..
RUN make -j$(nproc) 
RUN make install

WORKDIR /pngtoklg
RUN git clone https://edith-docker:bLsod9BwaDEs8VCJLNm9@rgit.acin.tuwien.ac.at/edith-langer/png_to_klg.git
WORKDIR /pngtoklg/png_to_klg/build
RUN cmake ..
RUN make -j$(nproc)
RUN pip install setuptools==44.0.0 numpy==1.12.1
