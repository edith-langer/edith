#FROM ros:kinetic-ros-core-xenial
FROM ubuntu:16.04
SHELL ["/bin/bash", "-c"]

## Container's mount point for the host's input/output folder
VOLUME "/input-output"
#RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list



RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    module-init-tools build-essential \
    ca-certificates wget git cmake python-pip \
	libboost-all-dev zlib1g-dev libpng-dev \
	libjpeg-dev unzip curl 

WORKDIR /home/v4r/
RUN wget http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.9/opencv-2.4.9.zip
RUN unzip opencv-2.4.9.zip 

WORKDIR /home/v4r/opencv-2.4.9/build
RUN cmake -D BUILD_NEW_PYTHON_SUPPORT=OFF -D WITH_OPENCL=OFF -D WITH_OPENMP=ON -D INSTALL_C_EXAMPLES=OFF -D BUILD_DOCS=OFF -D BUILD_EXAMPLES=OFF -D WITH_QT=OFF -D WITH_OPENGL=OFF -D WITH_VTK=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D WITH_CUDA=OFF -D BUILD_opencv_gpu=OFF ..
RUN make -j$(nproc) 
RUN make install


RUN pip install setuptools==44.0.0 numpy==1.12.1

WORKDIR /home/v4r/catkin_ws/src/
RUN git clone https://gitlab+deploy-token-42:osxNPjt_5yt8HtT-YmV4@rgit.acin.tuwien.ac.at/leitnermrks/png_to_klg.git

WORKDIR /home/v4r/catkin_ws/src/png_to_klg/build
RUN cmake ..
RUN make -j$(nproc)

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && apt-get update \
    && apt-get install -y \
    ros-kinetic-ros-base python-catkin-tools\
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/v4r/catkin_ws/
RUN . /opt/ros/kinetic/setup.bash && catkin build