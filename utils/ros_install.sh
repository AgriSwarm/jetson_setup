#!/bin/bash

ROS_VERSION=noetic

gecho() {
    local green="\033[0;32m"
    local reset="\033[0m"
    echo -e "${green}$1${reset}"
}

gecho "Start installing ROS.."

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key F42ED6FBAB17C654

sudo apt-get update
sudo apt-get install -y curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get install -y ros-${ROS_VERSION}-desktop-full

echo "source /opt/ros/${ROS_VERSION}/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt-get install -y python3-rosdep python3-rosinstall \
    python3-rosinstall-generator python3-wstool build-essential \
    ros-${ROS_VERSION}-ros-numpy ros-${ROS_VERSION}-rviz-visual-tools \
    ros-${ROS_VERSION}-mavros*

gecho "Initialize rosdep"
sudo rosdep init
rosdep update

sudo apt-get install -y python3-catkin-tools

gecho "Setup catkin"
sudo apt-get install python3-catkin
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin build -DCMAKE_BUILD_TYPE=Release

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
echo "source `catkin locate --shell-verbs`" >> ~/.bashrc
source ~/.bashrc
catkin source

echo "export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages" >> ~/.bashrc
