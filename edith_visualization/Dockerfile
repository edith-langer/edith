# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM osrf/ros:melodic-desktop-full

# setup timezone
#RUN echo 'Etc/UTC' > /etc/timezone && \
#    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
#    apt-get update && \
#    apt-get install -q -y --no-install-recommends tzdata && \
#    rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic

#RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated curl lsb-release wget ca-certificates

# setup sources.list
#RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

#RUN apt-get install --no-install-recommends -y --allow-unauthenticated ros-melodic-desktop-full

# install python2.7
# RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
#       python-rosinstall \
#       python-rosinstall-generator \
#       python-wstool \
#       python-rosdep \
#       python-vcstools \
#       && rm -rf /var/lib/apt/lists/*

# install python packages
RUN apt-get update
RUN apt-get install -y python-pip 
RUN pip install --upgrade pip setuptools
RUN pip install open3d open3d_ros_helper
#RUN rosdep init && \
#    rosdep update

# catkin tools
RUN apt-get update && apt-get install --no-install-recommends -y --allow-unauthenticated \
     python-catkin-tools ros-melodic-ros-numpy \
     && rm -rf /var/lib/apt/lists/*

# for ros environments
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# Prepare catkin build
RUN mkdir -p ~/catkin_ws/src

# install git
RUN apt-get update && apt-get install git 

RUN apt-get install --no-install-recommends -y --allow-unauthenticated mongodb ros-melodic-mongodb-store

WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/markusltnr/edith_visualization.git
RUN git clone https://github.com/markusltnr/edith_msgs.git 

# Run catkin build
RUN /bin/bash -c  '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws/; catkin build'

# source the catkin workspace
#RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

#WORKDIR /root

# setup entrypoint
#COPY ./ros_entrypoint.sh /
#RUN chmod +x /ros_entrypoint.sh
#ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
