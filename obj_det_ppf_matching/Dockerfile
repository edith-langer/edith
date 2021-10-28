FROM ros:melodic-perception-bionic
# uJCpNeVz1Q3SaowTUyxF
SHELL ["/bin/bash", "-c"]
ENV HOSTNAME=localhost

RUN apt-get update && apt-get -qq -y --allow-unauthenticated install git vim python-catkin-tools python-pip curl

RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN apt-get update && apt-get -qq -y --allow-unauthenticated install \ 
	ros-melodic-mongodb-store ros-melodic-ros-numpy python-backports.functools-lru-cache tmux \
	ros-melodic-move-base-msgs ros-melodic-actionlib-msgs ros-melodic-actionlib \
	libcmph-dev
WORKDIR /home/v4r/catkin_ws/src

RUN git clone https://gitlab+deploy-token-48:jeyTiGp2G61TJko962p7@rgit.acin.tuwien.ac.at/hsr-tidyup-pipeline/obj_det_ppf_matching.git
RUN git clone https://gitlab+deploy-token-50:cqZ5fHtQTWYXFtP2DRE-@rgit.acin.tuwien.ac.at/hsr-tidyup-pipeline/obj_det_ppf_matching_msgs.git
RUN git clone https://markus-docker:R_3nRtD8NL1TET_p8tku@rgit.acin.tuwien.ac.at/leitnermrks/table_extractor.git
RUN git clone -b matching_refactoring https://gitlab+deploy-token-49:PuyyiE_FuZTR7pzTMRJd@rgit.acin.tuwien.ac.at/edith-langer/tidyupvisionpipeline.git
#RUN git clone https://gitlab+deploy-token-43:zkdqJHaArD_VVZVYXJUy@rgit.acin.tuwien.ac.at/leitnermrks/stare_at_tables.git

RUN git clone --branch v0.4.0 https://github.com/google/glog.git
WORKDIR /home/v4r/catkin_ws/src/glog  
RUN cmake -H. -Bbuild -G "Unix Makefiles" && cmake --build build && \
   	cmake --build build --target install 
WORKDIR /home/v4r/catkin_ws/src   	
RUN rm -rf glog
RUN sed -i 's+/home/edith/Projects/TidyUpVisionPipeline/change_detection+/home/v4r/catkin_ws/src/tidyupvisionpipeline/change_detection+' /home/v4r/catkin_ws/src/obj_det_ppf_matching/CMakeLists.txt 


#RUN pip install --upgrade setuptools
#RUN pip install pyrsistent==0.16.1 transforms3d==0.3.1 open3d_ros_helper==0.2.0.3 jsonschema==2.4 
#RUN pip install open3d==0.9.0.0
#RUN pip install scikit-image==0.14.5
RUN mv tidyupvisionpipeline/v4r_ppf obj_det_ppf_matching/
WORKDIR /home/v4r/catkin_ws/
RUN . /opt/ros/melodic/setup.sh && catkin build
#RUN sysctl -w net.ipv6.conf.all.forwarding=1

