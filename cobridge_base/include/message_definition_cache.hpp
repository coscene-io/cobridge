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

#ifndef MESSAGE_DEFINITION_CACHE_HPP_
#define MESSAGE_DEFINITION_CACHE_HPP_

#include <set>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>

namespace cobridge_base
{
constexpr char SERVICE_REQUEST_MESSAGE_SUFFIX[] = "_Request";
constexpr char SERVICE_RESPONSE_MESSAGE_SUFFIX[] = "_Response";
constexpr char ACTION_GOAL_SERVICE_SUFFIX[] = "_SendGoal";
constexpr char ACTION_RESULT_SERVICE_SUFFIX[] = "_GetResult";
constexpr char ACTION_FEEDBACK_MESSAGE_SUFFIX[] = "_FeedbackMessage";

enum struct MessageDefinitionFormat
{
  IDL,
  MSG,
  SRV_REQ,
  SRV_RESP,
};

struct MessageSpec
{
  MessageSpec(
    MessageDefinitionFormat format, std::string text,
    const std::string & package_context);

  const std::set<std::string> dependencies;
  const std::string text;
  MessageDefinitionFormat format;
};

struct DefinitionIdentifier
{
  MessageDefinitionFormat format;
  std::string package_resource_name;

  bool operator==(const DefinitionIdentifier & di) const
  {
    return (format == di.format) && (package_resource_name == di.package_resource_name);
  }
};

class DefinitionNotFoundError : public std::exception
{
private:
  std::string _name;

public:
  explicit DefinitionNotFoundError(std::string name)
  : _name(std::move(name))
  {}

  const char * what() const noexcept override
  {
    return _name.c_str();
  }
};

class MessageDefinitionCache final
{
public:
  /**
   * Concatenate the message definition with its dependencies into a self-contained schema.
   * The format is different for MSG and IDL definitions, and is described fully here:
   * [MSG](https://mcap.dev/specification/appendix.html#ros2msg-data-format)
   * [IDL](https://mcap.dev/specification/appendix.html#ros2idl-data-format)
   * Throws DefinitionNotFoundError if one or more definition files are missing for the given
   * package resource name.
   */
  std::pair<MessageDefinitionFormat, std::string> get_full_msg_text(
    const std::string & package_resource_name);

  std::unordered_map<std::string, std::pair<MessageDefinitionFormat, std::string>>
  get_full_srv_text(const std::string & service_name);

private:
  struct DefinitionIdentifierHash
  {
    std::size_t operator()(const DefinitionIdentifier & di) const
    {
      std::size_t h1 = std::hash<MessageDefinitionFormat>()(di.format);
      std::size_t h2 = std::hash<std::string>()(di.package_resource_name);
      return h1 ^ h2;
    }
  };

  /**
   * Load and parse the message file referenced by the given datatype, or return it from
   * msg_specs_by_datatype
   */
  const MessageSpec & load_message_spec(const DefinitionIdentifier & definition_identifier);

  const MessageSpec & load_service_spec(const DefinitionIdentifier & definition_identifier);

  std::unordered_map<DefinitionIdentifier, MessageSpec, DefinitionIdentifierHash>
  msg_specs_by_definition_identifier_;
};

std::set<std::string> parse_dependencies(
  MessageDefinitionFormat format, const std::string & text,
  const std::string & package_context);

}  // namespace cobridge_base
#endif  // MESSAGE_DEFINITION_CACHE_HPP_
