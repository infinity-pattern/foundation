
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

#include <boost/test/unit_test.hpp>

#include <format>
#include <sstream>

#include "infinity-pattern/foundation/project/version.hpp"

namespace ipf = infinity_pattern::foundation;

BOOST_AUTO_TEST_CASE ( version_data )
{
    ipf::Version version = {.major = 1, .minor = 5, .patch = 10, .tweak = 15};

    BOOST_TEST( version.major == 1 );
    BOOST_TEST( version.minor == 5 );
    BOOST_TEST( version.patch == 10 );
    BOOST_TEST( version.tweak == 15 );
}

BOOST_AUTO_TEST_CASE ( version_comparison )
{
    ipf::Version v0 = {.major = 1, .minor = 5, .patch = 10, .tweak = 15};
    ipf::Version v1 = {.major = 1, .minor = 5, .patch = 10, .tweak = 15};
    ipf::Version v2 = {.major = 2, .minor = 5, .patch = 10, .tweak = 15};

    BOOST_TEST ( v0 == v1 );
    BOOST_TEST ( v0 != v2 );
    BOOST_TEST ( v0 <  v2 );
    BOOST_TEST ( v0 <= v2 );
    BOOST_TEST ( v2 >  v0 );
    BOOST_TEST ( v2 >= v0 );
}

BOOST_AUTO_TEST_CASE ( version_print )
{
    ipf::Version version = {.major = 1, .minor = 5, .patch = 10, .tweak = 15};

    std::stringstream b0;
    b0 << version;

    BOOST_TEST ( !b0.str().empty() );

    std::string b1 = std::format("{}", version);

    BOOST_TEST ( !b1.empty() );
    BOOST_TEST ( b0.str() == b1 );
}
