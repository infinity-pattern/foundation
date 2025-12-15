
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

#ifndef INFINITY_PATTERN_FOUNDATION_UTILITY_ERROR_HH
#define INFINITY_PATTERN_FOUNDATION_UTILITY_ERROR_HH

#include <format>
#include <ostream>
#include <source_location>
#include <stacktrace>
#include <string>

namespace infinity_pattern {
namespace foundation {
struct Error {
    std::string          message;
    std::source_location location;
    std::stacktrace      trace;

    static auto
    current(std::string          message,
            std::source_location location = std::source_location::current(),
            std::stacktrace trace = std::stacktrace::current()) -> Error {
        return {std::move(message), std::move(location), std::move(trace)};
    }
};

inline auto operator<<(std::ostream &out, const std::source_location &location)
    -> std::ostream & {
    out << location.file_name() << ":" << location.line() << "."
        << location.column() << " in " << location.function_name();
    return out;
}

inline auto operator<<(std::ostream &out, const Error &error) -> std::ostream & {
    out << "Error: " << error.message << "\n"
        << "  at " << error.location << "\n"
        << "  during:\n"
        << error.trace;
    return out;
}
} // namespace foundation
} // namespace infinity

template <> struct std::formatter<std::source_location> {
    template <class ParseContext>
    constexpr auto parse(ParseContext &ctx) -> ParseContext::iterator {
        return ctx.begin();
    }
    template <class FormatContext>
    auto format(const std::source_location &location, FormatContext &context)
       const -> FormatContext::iterator {
        return std::format_to(context.out(),
                              "{}:{}.{} in {}",
                              location.file_name(),
                              location.line(),
                              location.column(),
                              location.function_name());
    }
};

template <> struct std::formatter<infinity_pattern::foundation::Error> {
    template <class ParseContext>
    constexpr auto parse(ParseContext &ctx) -> ParseContext::iterator {
        return ctx.begin();
    }

    template <class FormatContext>
    auto format(const infinity_pattern::foundation::Error &error,
                FormatContext &context) const -> FormatContext::iterator {
        return std::format_to(context.out(),
                              "Error: {}\n  at {}\n  during:\n{}",
                              error.message,
                              error.location,
                              error.trace);
    }
};

#endif // !INFINITY_PATTERN_FOUNDATION_UTILITY_ERROR_HH
