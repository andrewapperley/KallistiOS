/*
What we are testing here:
    - NSObject (base class for all Foundation objects)
    - NSNumber (container object that can represent different numerical formats)
    - NSString (container object for working with strings in different formats)
    - NSAutoReleasePool (an object that keeps track of other objects being created 
    and assures they are cleaned up if the objects are marked for autorelease)
*/

#include "NSObjectTests.h"

@implementation Person

@synthesize bestFriend = _bestFriend, dead = _dead;

- (void)addName:(NSString *)name age:(NSNumber *)age height:(NSNumber *)height {
    _name = name;
    _age = age;
    _height = height;
}

- (void)setDead:(BOOL)dead {
    if (_dead == YES) { return; }
    _dead = dead;
}

- (BOOL)dead {
    return _dead;
}

- (void)setBestFriend:(Person *)bestFriend {
    _bestFriend = bestFriend;
}

- (Person *)bestFriend {
    return _bestFriend;
}

- (NSString *)name {
    return _name;
}

- (NSNumber *)age {
    return _age;
}

- (NSNumber *)height {
    return _height;
}
@end
