FROM ros:humble

ENV ROS_DISTRO=humble
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA
# Install system dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends fakeroot debhelper
RUN apt-get install -y --no-install-recommends \
    libasio-dev ros-${ROS_DISTRO}-cv-bridge zip \
    libwebsocketpp-dev ros-${ROS_DISTRO}-resource-retriever \
    python3-bloom apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
