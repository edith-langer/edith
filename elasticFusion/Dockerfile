
ARG CUDA_VERSION=10.2
FROM nvidia/cudagl:$CUDA_VERSION-devel-ubuntu18.04
LABEL maintainer "yuma.hiramatsu <yuma.hiramatsu@gmail.com>"
SHELL ["/bin/bash", "-c"]

RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
   || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
 && add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo bionic main" -u \
 && apt-get update && apt-get install -y --no-install-recommends \
    cmake \
    freeglut3-dev \
    git \
    libeigen3-dev \
    libjpeg-dev \
    libgl1-mesa-dev \
    libglew-dev \
    librealsense2-dev \
    librealsense2-dkms \
    librealsense2-utils \
    libsuitesparse-dev \
    libudev-dev \
    libusb-1.0-0-dev \
    libxkbcommon-x11-dev \
    openjdk-8-jdk \
    wget\
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

# upgrade cmake
RUN apt-get update
RUN apt-get install -y python3-pip
RUN pip3 install cmake --upgrade

WORKDIR /opt

RUN apt-get install -y cmake-qt-gui git build-essential libusb-1.0-0-dev libudev-dev freeglut3-dev libglew-dev libsuitesparse-dev libeigen3-dev zlib1g-dev libjpeg-dev

RUN git clone --branch v0.6 https://github.com/stevenlovegrove/Pangolin.git \
   && cd Pangolin \
   && mkdir build && cd build \
   && cmake .. -DAVFORMAT_INCLUDE_DIR="" \
   && cmake --build . \
   && ctest

RUN git clone https://github.com/occipital/OpenNI2.git \
   && cd OpenNI2 \
   && make -j8

ENV CMAKE_PREFIX_PATH=/opt/Pangulin/build

RUN ln -sf /usr/include/eigen3/Eigen /usr/include/Eigen \
   && ln -sf /usr/include/eigen3/unsupported /usr/include/unsupported

#RUN git clone https://github.com/Daichou/ElasticFusion.git \
RUN git clone https://github.com/edith-langer/ElasticFusion.git 
RUN sed -i 's/set(CUDA_ARCH_BIN/#set(CUDA_ARCH_BIN/' ElasticFusion/Core/src/CMakeLists.txt \
 && export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}/opt/Pangulin/build \
 && cd ElasticFusion/Core \
 && mkdir build && cd build \
 && cmake ../src \
 && make -j8 \
 && cd ../../GUI \
 && mkdir build && cd build \
 && cmake -DWITH_REALSENSE=OFF ../src \
 && make -j8

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# ROS
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
      python3-rosinstall \
      python3-rosinstall-generator \
      python3-wstool \
      python3-rosdep \
      python3-vcstools \
      && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
    rosdep update

# catkin tools
RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
     python3-catkin-tools \
     && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
      ros-melodic-ros-base ros-melodic-actionlib\
      && rm -rf /var/lib/apt/lists/*

WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/markusltnr/elastic_fusion_ros.git
WORKDIR /root/catkin_ws/
RUN . /opt/ros/melodic/setup.bash; catkin build

ENV PATH $PATH:/opt/ElasticFusion/GUI/build/

WORKDIR /workspace
