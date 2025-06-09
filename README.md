# cobridge

cobridge runs as a ros node on the robot side, and interacts with the cloud via websocket. cobridge establishes a link with the cloud to subscribe to a ros topic and invoke a ros service according to cloud instructions.
After cobridge establishes a link with the cloud, it can subscribe to ros topic and call ros service according to the instructions from the cloud, so as to real-time monitor the status of the robot and remotely issue commands.

## Install

### Compatibility

| ROS Version | Distribution Names  | Status       |
| ----------- | ------------------- | ------------ |
| ROS 1       | melodic, noetic     | ✅ Supported |
| ROS 2       | foxy, humble, jazzy | ✅ Supported |

### Installation Steps

- Import public key

  ```bash
  curl -fsSL https://apt.coscene.cn/coscene.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/coscene.gpg
  ```

- Add source

  ```bash
  echo "deb [signed-by=/etc/apt/trusted.gpg.d/coscene.gpg] https://apt.coscene.cn $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/coscene.list
  ```

- Update and install

  ```bash
  sudo apt update
  # CAUTION: ${ROS_DISTRO} need to be replaced by `melodic`, 'noetic', 'foxy', 'humble' or 'jazzy', if ROS_DISTRO not in your env
  sudo apt install ros-${ROS_DISTRO}-cobridge -y
  ```

- Run coBridge

  ```bash
  source /opt/ros/${ROS_DISTRO}/setup.bash

  # for ros 1 distribution
  roslaunch cobridge cobridge.launch

  # for ros 2 distribution
  ros2 launch cobridge cobridge_launch.xml
  ```

## Compile by source (Recommended !)

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

The cloud visualisation needs to be coupled with the carve line `coLink` component to visualise the state of the robot side in real time via the web side.

## Credits

originally from foxglove, thanks for their wonderful work.
