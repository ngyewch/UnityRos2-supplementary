#!/bin/bash

DEPENDENCIES_WS=dependencies_ws
APP_WS=app_ws

cd build

. /opt/ros/dashing/setup.bash
. $DEPENDENCIES_WS/install/setup.sh
. $APP_WS/install/setup.sh

RMW_IMPLEMENTATION=rmw_cyclonedds_cpp ros2 launch turtlebot3_unity_bringup nav2_bringup_launch.py
