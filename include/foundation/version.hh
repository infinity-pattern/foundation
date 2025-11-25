
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

#ifndef FOUNDATION_VERSION_HH
#define FOUNDATION_VERSION_HH

#include <format>
#include <ostream>
#include <string_view>

namespace infinity {
namespace foundation {
struct Version {
    unsigned major : 16;
    unsigned minor : 16;
    unsigned patch : 16;
    unsigned tweak : 16;

    constexpr auto operator<=>(Version const &that) const noexcept = default;
};

inline std::ostream &operator<<(std::ostream &out, const Version &version) {
    out << version.major << "." << version.minor << "." << version.patch << "."
        << version.tweak;
    return out;
}

struct Build {
    Version          version;
    std::string_view revision;
    std::string_view describe;
    std::string_view timestamp;
};

inline std::ostream &operator<<(std::ostream &out, const Build &build) {
    out << "version: [" << build.version << "]\n revision: [" << build.describe
        << "]\n built on: [" << build.timestamp << "]";
    return out;
}

extern const Build build;

} // namespace foundation
} // namespace infinity

template <> struct std::formatter<infinity::foundation::Version> {
    template <class ParseContext>
    constexpr auto parse(ParseContext &context) -> ParseContext::iterator {
        return context.begin();
    }

    template <class FormatContext>
    constexpr auto format(infinity::foundation::Version const &version,
                          FormatContext                       &context) const
        -> FormatContext::iterator {
        return std::format_to(context.out(),
                              "{}.{}.{}.{}",
                              version.major,
                              version.minor,
                              version.patch,
                              version.tweak);
    }
};

template <> struct std::formatter<infinity::foundation::Build> {
    template <class ParseContext>
    constexpr auto parse(ParseContext &context) -> ParseContext::iterator {
        return context.begin();
    }

    template <class FormatContext>
    constexpr auto format(infinity::foundation::Build const &build,
                          FormatContext                     &context) const
        -> FormatContext::iterator {
        return std::format_to(context.out(),
                              "version: [{}]\n revision: [{}]\n built on: [{}]",
                              build.version,
                              build.describe,
                              build.timestamp);
    }
};

#endif // !FOUNDATION_VERSION_HH
