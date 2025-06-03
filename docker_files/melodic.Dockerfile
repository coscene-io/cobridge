FROM ros:melodic

ENV ROS_DISTRO=melodic
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA
# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip ros-${ROS_DISTRO}-resource-retriever \
    python-bloom devscripts fakeroot debhelper apt-utils gnupg
RUN rm -rf /var/lib/apt/lists/*
