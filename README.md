# cobridge

cobridge is a ROS node that establishes a bidirectional communication channel between robots and external clients/services via WebSockets. It enables:

- Real-time monitoring of robot status from the cloud
- Remote command execution on robots
- Topic subscription and service invocation based on cloud instructions

## Features

- Compatible with both ROS 1 and ROS 2
- Secure WebSocket communication
- Efficient data transmission with JSON-based messaging
- Support for various ROS message types including images via cv_bridge

## Prerequisites

### For ROS 1

```bash
sudo apt install -y nlohmann-json3-dev \
  libasio-dev \
  libwebsocketpp-dev \
  ros-${ROS_DISTRO}-cv-bridge \
  ros-${ROS_DISTRO}-resource-retriever \
  ros-${ROS_DISTRO}-ros-babel-fish
```

### For ROS 2

```bash
sudo apt install -y nlohmann-json3-dev \
  libasio-dev \
  libwebsocketpp-dev \
  ros-${ROS_DISTRO}-cv-bridge \
  ros-${ROS_DISTRO}-resource-retriever
```

## Installation

### ROS 1

```bash
# Clone this repository into your ROS workspace
git clone https://github.com/coscene-io/cobridge.git ${YOUR_ROS_WS}/src/cobridge

# Source ROS environment
source /opt/ros/${ROS_DISTRO}/setup.bash

# Build the package
cd ${YOUR_ROS_WS}
catkin_make install
```

### ROS 2

```bash
# Clone this repository into your ROS workspace
git clone https://github.com/coscene-io/cobridge.git ${YOUR_ROS_WS}/src/cobridge

# Source ROS environment
source /opt/ros/${ROS_DISTRO}/setup.bash

# Build the package
cd ${YOUR_ROS_WS}
colcon build --packages-select cobridge
```

## Usage

### ROS 1

```bash
roslaunch cobridge cobridge.launch
```

### ROS 2

```bash
ros2 launch cobridge cobridge_launch.xml
```

## Configuration

cobridge can be configured via launch parameters. Check the launch files for available options:

- `cobridge.launch` (ROS 1)
- `cobridge_launch.xml` (ROS 2)

## Cloud Visualization

For real-time visualization of robot data on the web, cobridge integrates with the `colink` component. This allows for intuitive monitoring and control through a web interface.

## Troubleshooting

If you encounter connection issues:

1. Verify network connectivity between the robot and cloud server
2. Check if the WebSocket server address is correctly configured
3. Ensure all dependencies are properly installed

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Apache 2.0

## Acknowledgments

This project is based on work from Foxglove. We thank them for their wonderful contributions to the robotics community.
