
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

#ifndef INFINITY_PATTERN_FOUNDATION_LOGGING_LOGGER_HH
#define INFINITY_PATTERN_FOUNDATION_LOGGING_LOGGER_HH


namespace infinity_pattern {
namespace foundation {

// void log (std::ostream &out, std::string message);
void log(std::ostream &out std::string message);

template <class T>
inline void log (std::ostream &out, T t) { 
	auto size = std::formatted_size("{}", t);

	std::string buffer;
    buffer.resize(size);
	
    std::format_to_n(buffer.begin(), size, "{}", t);

	log(out, std::move(buffer));
}

/**
 * @brief The logger is a class which holds the state required to log messages to a sink
 * acording to a specified format when messages are posted by users.
 *
 */
class Logger {
public:

private:
	// the set of attributes which the logger associates with logs produced.
	// a reference to the sink
	// an api which allows for messages to be posted.

public:

};
}
}

#endif // !INFINITY_PATTERN_FOUNDATIO_LOGGING_LOGGER_HH

