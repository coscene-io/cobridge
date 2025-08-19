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
#ifndef HTTP_SERVER_HPP_
#define HTTP_SERVER_HPP_

#include <atomic>
#include <string>
#include <thread>
#include <vector>
#include <functional>
#include <memory>
#include <sstream>

namespace http_server
{

enum class LogLevel
{
  Debug,
  Info,
  Warn,
  Error,
  Fatal
};

using LogHandler = std::function<void(LogLevel, const char*)>;

class HttpServer
{
public:
  HttpServer(int port, 
             const std::string & mac_addresses, 
             const std::vector<std::string> & ip_addresses,
             LogHandler log_handler = nullptr);
  ~HttpServer();

  void start();
  void stop();

private:
  void run_server();
  void log(LogLevel level, const char* message);
  void log(LogLevel level, const std::string& message);

  int _port;
  std::string _mac_addresses;
  std::vector<std::string> _ip_addresses;
  std::thread _server_thread;
  std::atomic<bool> _running;
  LogHandler _log_handler;
};

bool get_dev_mac_addr(std::string& mac_addresses);

bool get_dev_ip_addrs(std::vector<std::string>& ip_addresses, std::string& colink_ip);

bool get_dev_netmask(const std::string& ifname,  std::string  & mask);

inline uint32_t ipv4_to_uint32(const std::string& ip) {
  std::array<uint32_t, 4> parts{};
  char dot;
  std::istringstream iss(ip);

  iss >> parts[0] >> dot >> parts[1] >> dot >> parts[2] >> dot >> parts[3];
  if (iss.fail()) {
    throw std::invalid_argument("Invalid IPv4 string: " + ip);
  }

  return (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8) | parts[3];
}

inline bool is_ip_in_subnet(const std::string& iface_ip,
                            const std::string& netmask,
                            const std::string& target_ip) {
  uint32_t iface = ipv4_to_uint32(iface_ip);
  uint32_t mask  = ipv4_to_uint32(netmask);
  uint32_t target = ipv4_to_uint32(target_ip);

  return (iface & mask) == (target & mask);
}

}  // namespace http_server
#endif  // HTTP_SERVER_HPP_
