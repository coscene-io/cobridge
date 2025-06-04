FROM ros:melodic

ENV ROS_DISTRO=melodic

RUN rm -rf /etc/apt/sources.list.d/ros1*.list
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/ros1.list

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever ros-${ROS_DISTRO}-ros-babel-fish \
    libavformat-dev libswscale-dev libopencv-dev ros-${ROS_DISTRO}-foxglove-msgs \
    python-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
