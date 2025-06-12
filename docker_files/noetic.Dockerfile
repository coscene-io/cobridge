FROM ros:noetic

ENV ROS_DISTRO=noetic
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F42ED6FBAB17C654

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever ros-${ROS_DISTRO}-cv-bridge \
    python3-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
