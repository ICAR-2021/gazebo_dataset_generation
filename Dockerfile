FROM osrf/ros:noetic-desktop-full

RUN apt-get update && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /catkin_ws/src

RUN cd /catkin_ws/src \
 && git clone https://github.com/ICAR-2021/gazebo_dataset_generation.git 

RUN cd /catkin_ws \
 && apt-get update \
 && rosdep install --from-paths src --ignore-src -r -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN cd /catkin_ws \
 && source /opt/ros/${ROS_DISTRO}/setup.bash \
 && catkin_make

RUN apt-get update && apt-get install -y python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install open3d==0.13.0 numpy==1.20.3 scipy==1.10.1

