FROM ros:jazzy

ENV ROS_DISTRO=jazzy

RUN rm -rf /etc/apt/sources.list.d/ros2*.list
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/ros2.list

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever \
    libavformat-dev libswscale-dev libopencv-dev ros-${ROS_DISTRO}-foxglove-msgs \
    python3-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
