# cobridge

cobridge 是一个 ROS 节点，通过 WebSocket 在机器人和外部客户端/服务之间建立双向通信通道。它能够：

- 从云端实时监控机器人状态
- 远程执行机器人命令
- 根据云端指令订阅 ROS 主题和调用 ROS 服务

## 功能特点

- 兼容 ROS 1 和 ROS 2
- 安全的 WebSocket 通信
- 基于 JSON 的高效数据传输
- 支持各种 ROS 消息类型，包括通过 cv_bridge 处理图像

## 前置依赖

### ROS 1

```bash
sudo apt install -y nlohmann-json3-dev \
  libasio-dev \
  libwebsocketpp-dev \
  ros-${ROS_DISTRO}-cv-bridge \
  ros-${ROS_DISTRO}-resource-retriever \
  ros-${ROS_DISTRO}-ros-babel-fish
```

### ROS 2

```bash
sudo apt install -y nlohmann-json3-dev \
  libasio-dev \
  libwebsocketpp-dev \
  ros-${ROS_DISTRO}-cv-bridge \
  ros-${ROS_DISTRO}-resource-retriever
```

## 安装

### ROS 1

```bash
# 将此仓库克隆到您的 ROS 工作空间
git clone https://github.com/coscene-io/cobridge.git ${YOUR_ROS_WS}/src/cobridge

# 加载 ROS 环境
source /opt/ros/${ROS_DISTRO}/setup.bash

# 构建包
cd ${YOUR_ROS_WS}
catkin_make install
```

### ROS 2

```bash
# 将此仓库克隆到您的 ROS 工作空间
git clone https://github.com/coscene-io/cobridge.git ${YOUR_ROS_WS}/src/cobridge

# 加载 ROS 环境
source /opt/ros/${ROS_DISTRO}/setup.bash

# 构建包
cd ${YOUR_ROS_WS}
colcon build --packages-select cobridge
```

## 使用方法

### ROS 1

```bash
roslaunch cobridge cobridge.launch
```

### ROS 2

```bash
ros2 launch cobridge cobridge_launch.xml
```

## 配置

cobridge 可以通过启动参数进行配置。请查看启动文件了解可用选项：

- `cobridge.launch` (ROS 1)
- `cobridge_launch.xml` (ROS 2)

## 云端可视化

为了在网页端实时可视化机器人数据，cobridge 与 `colink` 组件集成，允许通过网页界面直观地监控和控制机器人。

## 许可证

Apache 2.0

## 致谢

本项目基于 Foxglove 的工作。感谢他们对机器人社区的杰出贡献。
