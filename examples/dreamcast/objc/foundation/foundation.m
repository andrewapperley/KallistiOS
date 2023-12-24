/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#include <Foundation/Foundation.h>
#include "NSObject/NSObjectTests.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


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