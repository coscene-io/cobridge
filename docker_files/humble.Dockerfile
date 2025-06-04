FROM ros:humble

ENV ROS_DISTRO=humble

RUN rm -rf /etc/apt/sources.list.d/ros2*.list
RUN apt update && apt install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ros2.list

# Install system dependencies
RUN apt update && apt install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever \
    libavformat-dev libswscale-dev libopencv-dev ros-${ROS_DISTRO}-foxglove-msgs \
    python3-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
