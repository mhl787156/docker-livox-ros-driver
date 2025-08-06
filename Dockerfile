FROM ros:humble 

# Install required dependencies
RUN apt-get update && apt-get install -y git openssh-client curl git python3-vcstool ros-humble-pcl-ros

# Setting HOST_UID and running under ros user (mirroring host user id) to enable ros communication with host machine
ARG HOST_UID=1000 
RUN adduser --disabled-password --gecos '' --uid $HOST_UID ros

# Setup workspace (Make directories and chown before changing user)
RUN mkdir -p /ros_ws/src && chown -R ros /ros_ws
WORKDIR /ros_ws/src

# Clone repos using vcs
RUN git clone --recursive https://github.com/ucl-delta/livox_ros_driver2.git \
    && git clone --recursive https://github.com/Livox-SDK/Livox-SDK2.git -b v1.2.5

# Livox Setups 
WORKDIR /ros_ws/src/Livox-SDK2
RUN mkdir build \
    && cd build \
    && cmake .. && make -j \
    && make install \
    && touch COLCON_IGNORE 

WORKDIR /ros_ws/src/livox_ros_driver2
RUN . /opt/ros/humble/setup.sh \
    && chmod +x pre-build.sh \
    && ./pre-build.sh humble 

# Change User to ros
USER ros

# Build
WORKDIR /ros_ws
RUN . /opt/ros/humble/setup.sh \
    && colcon build --symlink-install

COPY ros_entrypoint.sh /ros_entrypoint.sh