# cobridge

cobridge 会以 ros node 的方式运行在机器人端，并通过 websocket 方式与云端进行交互。cobridge 与云端建立链接后，根据云端指令可以实现订阅 ros topic，调用 ros service，实现实时监控机器人状态、远程下发指令等功能。

## 安装

**注意: 当前仅支持 `noetic`, `foxy`, `humble`, `jazzy` 版本**

* 导入公钥

  ``` bash
  curl -fsSL https://apt.coscene.cn/coscene.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/coscene.gpg
  ```

* 添加源

  ``` bash
  echo "deb [signed-by=/etc/apt/trusted.gpg.d/coscene.gpg] https://apt.coscene.cn $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/coscene.list
  ```

* 更新apt并安装

  ``` bash
  sudo apt update
  # 注意: 如果 ROS_DISTRO 没有在你的环境变量里面，${ROS_DISTRO} 需要被 'noetic', 'foxy', 'humble' or 'jazzy'替换
  sudo apt install ros-${ROS_DISTRO}-cobridge -y
  ```

* 运行 coBridge

  ``` bash
  source /opt/ros/${ROS_DISTRO}/setup.bash
  
  # for ros 1 distribution
  roslaunch cobridge cobridge.launch
  
  # for ros 2 distribution
  ros2 launch cobridge cobridge_launch.xml 
  ```


## 编译 (推荐！)

* 安装依赖库

  ``` bash
  # for ROS 1 distribution
  sudo apt install -y \
    libasio-dev \
    ros-${ROS_DISTRO}-resource-retriever \
    ros-${ROS_DISTRO}-ros-babel-fish
  
  # for ROS 2 distribution
  sudo apt install -y \
      libasio-dev \
      ros-${ROS_DISTRO}-resource-retriever
  ```

* ROS1

  ``` bash 
  # 将工程复制到 {your_ros_ws}/src/ 文件夹内
  cp -r {this_repo} {your_ros_ws}/src/
  
  source /opt/ros/{ros_distro}/setup.bash 
  
  cd {your_ros2_ws}
  
  ./patch_apply.sh
  
  catkin_make install
  ```


* ROS2

  ``` bash 
   # 将工程复制到 {your_ros2_ws}/src/ 文件夹内
   cp -r {this_repo} {your_ros_ws}/src/ 
  
   source /opt/ros/{ros_distro}/setup.bash
  
   cd {your_ros2_ws} 
  
  ./patch_apply.sh
  
   colcon build --packages-select cobridge
  ```

## 运行
  ``` bash
  # ros 1
  roslaunch cobridge cobridge.launch
  
  # ros 2
  ros2 launch cobridge cobridge_launch.xml 
  ```

## 云端可视化
云端可视化需配合刻行 `coLink` 组件，通过网页端实时可视化机器人端状态。

## 荣誉
最初来自 foxglove，感谢他们的出色工作。