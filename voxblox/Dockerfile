# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:bionic

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-ros-core=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*


# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
      python-rosinstall \
      python-rosinstall-generator \
      python-wstool \
      python-rosdep \
      python-vcstools \
      && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
    rosdep update

# catkin tools
RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
     python-catkin-tools \
     && rm -rf /var/lib/apt/lists/*

# install python packages
RUN apt-get update
RUN apt-get install python2.7
RUN apt-get install -y python-pip 
RUN pip install --upgrade pip setuptools

# for ros environments
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# Prepare catkin build
RUN mkdir -p ~/catkin_ws/src

# Run catkin build
RUN /bin/bash -c  '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws/; catkin build'

# source the catkin workspace
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

# system dependencies
RUN apt-get install -y python-wstool python-catkin-tools ros-melodic-cmake-modules protobuf-compiler autoconf libtool ros-melodic-eigen-conversions ros-melodic-tf
RUN apt-get install -y libtool ros-melodic-eigen-conversions ros-melodic-tf ros-melodic-tf-conversions ros-melodic-rviz qt5-default
RUN apt-get update
RUN apt-get install -y ros-melodic-cv-bridge ros-melodic-pcl-conversions ros-melodic-pcl-ros

RUN git clone https://github.com/ethz-asl/voxblox.git ~/catkin_ws/src/voxblox
RUN cd ~/catkin_ws/src/ && wstool init . ./voxblox/voxblox_https.rosinstall
RUN cd ~/catkin_ws/src/ && wstool update
RUN cd ~/catkin_ws/ && catkin build eigen_catkin
RUN cd ~/catkin_ws/ && catkin build voxblox_ros

RUN cd ~/ && git clone https://markus_forks_containers:n1z-SAnmqZsxYtcaxwkq@rgit.acin.tuwien.ac.at/markus_projects/containers.git
RUN cp ~/containers/voxblox/hsrb_voxblox.launch ~/catkin_ws/src/voxblox/voxblox_ros/launch/
RUN rm -rf ~/containers

WORKDIR /root

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
