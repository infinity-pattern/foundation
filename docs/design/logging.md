# Logging Library

- Feature List
	- log objects which can provide an overload of: (either operator<< or std::formatter)
		- std::* objects generally already provide this.  
	- provide methods to add attributes to logs. [severity, timestamp, thread id, message count, user provided attributes (an extension point)]
	- provide multiple places to write logs to. (std::ostream -> [fostream, cerr, ostringstream])
	- write logs on a separate thread. (thread pool with a queue of logs? or just a single thread? maybe thats a choice on startup?)
	- 
