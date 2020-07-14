#!/bin/bash

SOURCE_DIR=UnityRos2/docker/turtlebot3_navigation/

DEPENDENCIES_WS=dependencies_ws
APP_WS=app_ws

set -e

mkdir -p build
cd build

if [ ! -d UnityRos2 ]; then
  git clone https://github.com/DynoRobotics/UnityRos2.git
fi

####

. /opt/ros/dashing/setup.bash

#### build dependencies

mkdir -p $DEPENDENCIES_WS/src
vcs import $DEPENDENCIES_WS/src < $SOURCE_DIR/ros2_dependencies.repos
# Remove this so that we don't need to build gazebo_ros_pkgs
cd $DEPENDENCIES_WS
rm -rf src/navigation2/nav2_system_tests
rosdep install -q -y --from-paths src --ignore-src
colcon build --symlink-install
cd ..

. $DEPENDENCIES_WS/install/setup.sh

#### build app

mkdir -p $APP_WS/src
rsync -a \
    $SOURCE_DIR/turtlebot3_description \
    $SOURCE_DIR/turtlebot3_unity \
    $SOURCE_DIR/turtlebot3_unity_bringup \
    $APP_WS/src
cd $APP_WS
rosdep install -q -y --from-paths src --ignore-src
colcon build --symlink-install
cd ..
