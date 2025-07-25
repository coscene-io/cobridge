// Copyright 2024 coScene
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#ifdef ROS2_VERSION_FOXY
#include "generic_publisher.hpp"

#include <memory>
#include <string>

namespace
{
rcl_publisher_options_t get_publisher_options(const rclcpp::QoS & qos)
{
  auto options = rcl_publisher_get_default_options();
  options.qos = qos.get_rmw_qos_profile();
  return options;
}
}  // unnamed namespace

namespace cobridge
{
GenericPublisher::GenericPublisher(
  rclcpp::node_interfaces::NodeBaseInterface * node_base,
  const rosidl_message_type_support_t & type_support,
  const std::string & topic_name,
  const rclcpp::QoS & qos)
: rclcpp::PublisherBase(node_base, topic_name, type_support, get_publisher_options(qos)) {}

void GenericPublisher::publish(const std::shared_ptr<rcl_serialized_message_t> & message)
{
  auto return_code = rcl_publish_serialized_message(
    get_publisher_handle().get(), message.get(), nullptr);

  if (return_code != RCL_RET_OK) {
    rclcpp::exceptions::throw_from_rcl_error(return_code, "failed to publish serialized message");
  }
}

}  // namespace cobridge
#endif
