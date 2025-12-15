
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

#include "infinity-pattern/foundation/utility/error.hpp"

namespace ipf = infinity_pattern::foundation;

BOOST_AUTO_TEST_CASE ( error_data )
{
    ipf::Error error = ipf::Error::current("test error");

    BOOST_TEST ( error.message == "test error" );
    BOOST_TEST ( !error.trace.empty() );
}

BOOST_AUTO_TEST_CASE ( error_print )
{
    ipf::Error error = ipf::Error::current("test error");

    std::stringstream b0;
    b0 << error;

    BOOST_TEST ( !b0.str().empty() );

    std::string b1 = std::format("{}", error);

    BOOST_TEST ( !b1.empty() );
    BOOST_TEST ( b0.str() == b1 );
}


