FROM ros:foxy

ENV ROS_DISTRO=foxy

RUN apt-get update && apt-get install -y curl gnupg
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | apt-key add -
    
# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever ros-${ROS_DISTRO}-cv-bridge \
    python3-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
