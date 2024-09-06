FROM ros:humble

ENV ROS_DISTRO=humble
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA
# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends nlohmann-json3-dev  \
    libasio-dev ros-${ROS_DISTRO}-cv-bridge zip \
    libwebsocketpp-dev ros-${ROS_DISTRO}-resource-retriever
RUN rm -rf /var/lib/apt/lists/*
