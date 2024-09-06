SHELL := /bin/bash

ROS1_DISTRO := noetic
ROS2_DISTRO := foxy humble

ROS_BIN_PATH := /opt/ros/$(ROS_DISTRO)/bin

lint:
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_cpplint --filter=-build/include_order .
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_uncrustify .
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_copyright .
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_cppcheck .
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_xmllint .
	/ros_entrypoint.sh $(ROS_BIN_PATH)/ament_lint_cmake .

test:
ifeq ($(findstring $(ROS_DISTRO), $(ROS1_DISTRO)), $(ROS_DISTRO))
	./ros1_entry.sh devel/cobridge/version_test
	./ros1_entry.sh devel/cobridge/smoke_test
else ifeq ($(findstring $(ROS_DISTRO), $(ROS2_DISTRO)), $(ROS_DISTRO))
	./ros2_entry.sh build/cobridge/version_test
	./ros2_entry.sh build/cobridge/smoke_test
else
	$(error Unsupported ROS_DISTRO: $(ROS_DISTRO))
endif

build:
ifeq ($(findstring $(ROS_DISTRO), $(ROS1_DISTRO)), $(ROS_DISTRO))
	/ros_entrypoint.sh catkin_make
else ifeq ($(findstring $(ROS_DISTRO), $(ROS2_DISTRO)), $(ROS_DISTRO))
	/ros_entrypoint.sh colcon build --event-handlers console_direct+
else
	$(error Unsupported ROS_DISTRO: $(ROS_DISTRO))
endif
