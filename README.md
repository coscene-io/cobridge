# coBridge

coBridge is a ROS node deployed on robots to facilitate real-time interaction between the robot and the cloud platform via WebSocket. It subscribes to ROS topics and invokes ROS services based on instructions received from the cloud, enabling remote monitoring and command execution.

## Supported Versions

| ROS Version | Distribution Names | Ubuntu Version | Status       |
| ----------- | ------------------ | -------------- | ------------ |
| ROS 1       | melodic            | 18.04 Bionic   | ✅ Supported |
| ROS 1       | noetic             | 20.04 Focal    | ✅ Supported |
| ROS 2       | foxy               | 20.04 Focal    | ✅ Supported |
| ROS 2       | humble             | 22.04 Jammy    | ✅ Supported |
| ROS 2       | jazzy              | 24.04 Noble    | ✅ Supported |

## Installation (Binary)

1. Import public key

```bash
curl -fsSL https://apt.coscene.cn/coscene.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/coscene.gpg
```

2. Add source

```bash
echo "deb [signed-by=/etc/apt/trusted.gpg.d/coscene.gpg] https://apt.coscene.cn $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/coscene.list
```

3. Update and install

```bash
sudo apt update
# CAUTION: ${ROS_DISTRO} need to be replaced by `melodic`, 'noetic', 'foxy', 'humble' or 'jazzy', if ROS_DISTRO not in your env
sudo apt install ros-${ROS_DISTRO}-cobridge -y
```

4. Run coBridge

```bash
source /opt/ros/${ROS_DISTRO}/setup.bash

# for ros 1 distribution
roslaunch cobridge cobridge.launch

# for ros 2 distribution
ros2 launch cobridge cobridge_launch.xml
```

## Installation from Source (Recommended)

- Install deps

  ```bash
  # for ROS 1 distribution
  sudo apt install -y \
    libasio-dev \
    ros-${ROS_DISTRO}-resource-retriever

  # for ROS 2 distribution
  sudo apt install -y \
    libasio-dev \
    ros-${ROS_DISTRO}-resource-retriever
  ```

- ROS1

  ```bash
  # copy this project into {your_ros_ws}/src/
  cp -r {this_repo} {your_ros_ws}/src/.

  # Init Env variables
  source /opt/ros/{ros_distro}/setup.bash

  # Enter into your ros workspace
  cd {your_ros_ws}

  # apply patches
  ./patch_apply.sh

  # Compile
  catkin_make install
  ```

- ROS2

  ```bash
  # Init Env variables
  source /opt/ros/{ros_distro}/setup.bash

  # Copy this repo into your workspace
  cp -r {this_repo} {your_ros_ws}/src/.

  # Enter into your ros workspace
  cd {your_ros_ws}

  # apply patches
  ./patch_apply.sh

  # Build
  colcon build --packages-select cobridge
  ```

## Run

```bash
  source /opt/ros/{ros_distro}/setup.bash

  # ros 1
  roslaunch cobridge cobridge.launch

  # ros 2
  ros2 launch cobridge cobridge_launch.xml
```

## Cloud Visualization

The cloud visualization needs to be coupled with the carve line `coLink` component to visualize the state of the robot side in real time via the web side.

## Credits

Derived from Foxglove's foundational work. Thanks to their outstanding contributions.
