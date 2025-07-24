#!/bin/bash
set -e
echo "HOST $(whoami), UID: $UID"

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
source "/ros_ws/install/setup.bash" --

exec "$@"
