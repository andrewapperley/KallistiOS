/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#include <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

/*
What we are testing here:
    - NSObject (base class for all Foundation objects)
    - NSNumber (container object that can represent different numerical formats)
    - NSString (container object for working with strings in different formats)
    - NSAutoReleasePool (an object that keeps track of other objects being created 
    and assures they are cleaned up if the objects are marked for autorelease)
*/
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

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    int result = EXIT_SUCCESS;
    Person *person1 = NULL;
    Person *person2 = NULL;

    // Create a new instance of person
    person1 = [[Person alloc] init];

    // Verify the runtime found the class and NSObject was able to initialize correctly
    if(!person1) {
        fprintf(stderr, "Failed to create Person instance!\n");
        result = EXIT_FAILURE;
        goto exit;
    } 
    else printf("Created Person instance.\n");

    // Call message handler for "addName," setting instance variables.
    [person1 addName: @"Joe" age: [NSNumber numberWithInteger: 20] height: [NSNumber numberWithFloat: 6.1f]];

    // Query values of instance variables by string names
    NSString *name = person1.name;
    NSInteger age = [person1.age integerValue];
    float height = [person1.height floatValue];

    // Verify values were properly set and retrieved
    if(![name isEqual: @"Joe"] || age != 20 || height != 6.1f) {
        fprintf(stderr, "Failed to set and retrieve instance variables!\n");
        result = EXIT_FAILURE;
        goto exit;
    }
    else printf("Set and retrieved instance variables.\n");

    // Check if instance of Person responds to getBestFriend
    if(![person1 respondsToSelector: @selector(bestFriend)]) { 
        fprintf(stderr, "Does not respond to getBestFriend message!\n");
        result = EXIT_FAILURE;
        goto exit;
    }
    else printf("Checked for responding to message handler.\n");

    // Construct another Person instance
    person2 = [[Person alloc] init];
    
    if(!person2) {
        fprintf(stderr, "Failed to create second Person instance!\n");
        result = EXIT_FAILURE;
        goto exit;
    } 
    else printf("Created second Person instance.\n");

    // Initialize instance variables
    [person2 addName: @"Jim" age: [NSNumber numberWithInteger: 30] height: [NSNumber numberWithFloat: 5.2f]];
    
    // Test out setting and retrieving properties
    person2.dead = YES;
    person1.bestFriend = person2;

    if(!person2.dead || ![person1.bestFriend isEqual:person2]) {
        fprintf(stderr, "Failed to set and retrieve properties!\n");
        result = EXIT_FAILURE;
    } else printf("Set and retrieved properties!\n");

exit:

    if(result == EXIT_FAILURE) 
        fprintf(stderr, "**** FAILURE! ****\n");
    else  
        printf("**** SUCCESS! ****\n");

    //   [[NSRunLoop currentRunLoop] run];
    [pool release];
    return result;
}