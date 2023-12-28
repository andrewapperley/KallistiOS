/*
What we are testing here:
    - NSObject (base class for all Foundation objects)
    - NSNumber (container object that can represent different numerical formats)
    - NSString (container object for working with strings in different formats)
    - NSAutoReleasePool (an object that keeps track of other objects being created 
    and assures they are cleaned up if the objects are marked for autorelease)
*/

#import "NSObjectTests.h"
#import <Foundation/Foundation.h>
#include <stdio.h>

@interface Person: NSObject 
{
    NSString *_name;
    NSNumber *_age;
    NSNumber *_height;
    Person *_bestFriend;
    BOOL _dead;
}
- (void)addName:(NSString *)name age:(NSNumber *)age height:(NSNumber *)height;
- (void)setBestFriend:(Person *)bestFriend;
@property(nonatomic, retain)Person *bestFriend;
@property(nonatomic, retain, readonly)NSString *name;
@property(nonatomic, retain, readonly)NSNumber *age;
@property(nonatomic, retain, readonly)NSNumber *height;
@property(nonatomic)BOOL dead;
@end

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

@implementation NSObjectTests

- (int) testInstanceCreation {
    // Create a new instance of person
    _person1 = [[Person alloc] init];

    // Verify the runtime found the class and NSObject was able to initialize correctly
    if(!_person1) {
        fprintf(stderr, "Failed to create Person instance!\n");
        return EXIT_FAILURE;
    } 
    else printf("Created Person instance.\n");

    return EXIT_SUCCESS;
}
- (int) testPropertyVerification {
    // Call message handler for "addName," setting instance properties.
    [_person1 addName: @"Joe" age: [NSNumber numberWithInteger: 20] height: [NSNumber numberWithFloat: 6.1f]];

    // Query values of properties
    NSString *name = _person1.name;
    NSInteger age = [_person1.age integerValue];
    float height = [_person1.height floatValue];

    // Verify values were properly set and retrieved
    if(![name isEqual: @"Joe"] || age != 20 || height != 6.1f) {
        fprintf(stderr, "Failed to set and retrieve instance variables!\n");
        return EXIT_FAILURE;
    }
    else printf("Set and retrieved instance variables.\n");

    return EXIT_SUCCESS;
}
- (int) testRespondsToMessage {
     // Check if instance of Person responds to getBestFriend
    if(![_person1 respondsToSelector: @selector(bestFriend)]) { 
        fprintf(stderr, "Does not respond to getBestFriend message!\n");
        return EXIT_FAILURE;
    }
    else printf("Checked for responding to message handler.\n");

    return EXIT_SUCCESS;
}
- (int) testSecondInstanceCreation {
    // Construct another Person instance
    _person2 = [[Person alloc] init];
    
    if(!_person2) {
        fprintf(stderr, "Failed to create second Person instance!\n");
        return EXIT_FAILURE;
    } 
    else printf("Created second Person instance.\n");

    return EXIT_SUCCESS;
}
- (int) testSettingPropertyWithNSObjectInstance {
    // Initialize instance variables
    [_person2 addName: @"Jim" age: [NSNumber numberWithInteger: 30] height: [NSNumber numberWithFloat: 5.2f]];
    
    // Test out setting and retrieving properties
    _person2.dead = YES;
    _person1.bestFriend = _person2;

    if(!_person2.dead || ![_person1.bestFriend isEqual:_person2]) {
        fprintf(stderr, "Failed to set and retrieve properties!\n");
        return EXIT_FAILURE;
    } else printf("Set and retrieved properties!\n");

    return EXIT_SUCCESS;
}
@end