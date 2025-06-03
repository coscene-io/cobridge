FROM ros:indigo

ENV ROS_DISTRO=indigo
ENV ROS_VERSION=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libasio-dev zip build-essential ros-${ROS_DISTRO}-resource-retriever\
    python-bloom devscripts fakeroot debhelper apt-utils gnupg

RUN echo "nodelet:\n  ubuntu:\n    trusty: ros-indigo-nodelet\nroscpp:\n  ubuntu:\n    trusty: ros-indigo-roscpp\nroslib:\n  ubuntu:\n    trusty: ros-indigo-roslib\nxmlrpcpp:\n  ubuntu:\n    trusty: ros-indigo-xmlrpcpp\nstd_msgs:\n  ubuntu:\n    trusty: ros-indigo-std-msgs\nstd_srvs:\n  ubuntu:\n    trusty: ros-indigo-std-srvs\nresource_retriever:\n  ubuntu:\n    trusty: ros-indigo-resource-retriever\nrosgraph_msgs:\n  ubuntu:\n    trusty: ros-indigo-rosgraph-msgs" > /tmp/indigo-local.yaml

RUN echo "yaml file:///tmp/indigo-local.yaml" | tee /etc/ros/rosdep/sources.list.d/20-indigo-local.list

RUN rm -rf /var/lib/apt/lists/*
