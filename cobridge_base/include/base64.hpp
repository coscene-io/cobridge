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

#ifndef BASE64_HPP_
#define BASE64_HPP_

#include <cstdint>
#include <string>
#include <vector>
#include "standard.hpp"

namespace cobridge_base
{
std::string base64_encode(const string_view & input);

std::vector<unsigned char> base64_decode(const std::string & input);
}

#endif  // BASE64_HPP_
