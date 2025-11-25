
/***************************************************************************
 *                                                                          *
 * Copyright (C) 2024 Cade Weinberg                                         *
 *                                                                          *
 * This file is part of foundation.                                         *
 *                                                                          *
 * foundation is free software: you can redistribute it and/or modify       *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, either version 3 of the License, or        *
 * (at your option) any later version.                                      *
 *                                                                          *
 * foundation is distributed in the hope that it will be useful,            *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
 * GNU General Public License for more details.                             *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * along with foundation.  If not, see <http://www.gnu.org/licenses/>.      *
 *                                                                          *
 ***************************************************************************/

#ifndef FOUNDATION_EXCEPTION_HH
#define FOUNDATION_EXCEPTION_HH

#include <exception>
#include <string>
#include <ostream>
#include <source_location>
#include <stacktrace>
#include <format>

namespace infinity {
namespace foundation {
struct Exception : public std::exception {
  std::string message;
  std::source_location location;
  std::stacktrace trace;

  static Exception
  current(std::string message,
          std::source_location location = std::source_location::current(),
          std::stacktrace trace = std::stacktrace::current()) {
    return {std::move(message), std::move(location), std::move(trace)};
  }

  const char *what() const noexcept override { return message.c_str(); }
};

std::ostream &operator<<(std::ostream &out, const std::source_location &location) {
  out << location.file_name() << ":" << location.line() << "." << location.column()
      << " in " << location.function_name();
  return out;
}

std::ostream &operator<<(std::ostream &out, const Exception &error) {
  out << "Error: " << error.message << "\n"
      << "  at " << error.location << "\n"
      << "during\n"
      << error.trace;
  return out;
}
} // namespace foundation
} // namespace infinity

template <> struct std::formatter<std::source_location> {
  template <class ParseContext> constexpr auto parse(ParseContext &ctx) -> ParseContext::iterator {
    return ctx.begin();
  }
  template <class FormatContext>
  auto format(const std::source_location &location,
              FormatContext &context) -> FormatContext::iterator {
    return std::format_to(context.out(), "{}:{}.{} in {}",
                          location.file_name(), location.line(),
                          location.column(), location.function_name());
  }
};

template <> struct std::formatter<infinity::foundation::Exception> {
  template <class ParseContext> constexpr auto parse(ParseContext &ctx) -> ParseContext::iterator {
    return ctx.begin();
  }

  template <class FormatContext>
  auto format(const infinity::foundation::Exception &error,
              FormatContext &context) -> FormatContext::iterator {
    return std::format_to(
        context.out(), "Error: {}\n  at {}\ during:\n{}",
        error.message, error.location, error.trace);
  }
};

#endif // !FOUNDATION_EXCEPTION_HH