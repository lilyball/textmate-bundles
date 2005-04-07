"""exceptions for special_items module"""

class UsageException(Exception): pass
class HandlerException(Exception): pass
class HandlerNoEntitiesException(HandlerException): pass
class SortException(Exception): pass
class ParseException(Exception): pass