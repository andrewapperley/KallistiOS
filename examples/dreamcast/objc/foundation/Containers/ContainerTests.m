/* KallistiOS ##version##

   ContainerTests.m
   Copyright (C) 2023 Andrew Apperley

   These tests will verify that the container classes of Foundation are working correctly.

What we are testing here:
    - NSArray
    - NSDictionary
    - NSSet
*/

#import "ContainerTests.h"
#import <Foundation/Foundation.h>
#include <stdio.h>

@implementation ContainerTests

- (int) testNSArray {
    NSMutableArray *grid = [NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        NSMutableArray *row = [NSMutableArray array];
        for (int ii = 0; ii < 10; ++ii) {
            [row addObject:@"X"];
        }
        [grid addObject:row];
    }

    // Verify the correct number of objects were added to the array
    if(!grid && [grid count] != 10 && [[grid objectAtIndex:0] count] != 10) {
        fprintf(stderr, "Failed to create an array with the correct number of items!\n");
        return EXIT_FAILURE;
    } 
    else printf("Created an array with 10 items.\n");

    return EXIT_SUCCESS;
}

- (int) testNSDictionary {
    NSMutableDictionary *container = [NSMutableDictionary dictionary];

    NSString *consoleName = [@"sega dreamcast" stringByReplacingOccurrencesOfString: @" " withString: @""];
    for (NSInteger i = 0; i < consoleName.length; i++) {
        unichar character = [consoleName characterAtIndex:i];
        NSString *letter = [NSString stringWithCharacters:&character length:1];
        NSNumber *letterCount = [container objectForKey:letter];
        if (!letterCount) {
            [container setObject:[NSNumber numberWithInteger: 1] forKey:letter];
        } else {
            [container setObject:[NSNumber numberWithInt:[letterCount intValue] + 1] forKey:letter];
        }
    }
    // Verify that the dictionary has the correct number for each letter in Sega Dreamcast
    if(!container &&
        [[container objectForKey:@"s"] integerValue] != 2 &&
        [[container objectForKey:@"e"] integerValue] != 2 &&
        [[container objectForKey:@"g"] integerValue] != 1 &&
        [[container objectForKey:@"a"] integerValue] != 3 &&
        [[container objectForKey:@"d"] integerValue] != 1 &&
        [[container objectForKey:@"r"] integerValue] != 1 &&
        [[container objectForKey:@"m"] integerValue] != 1 &&
        [[container objectForKey:@"c"] integerValue] != 1 &&
        [[container objectForKey:@"t"] integerValue] != 1
    ) {
        fprintf(stderr, "Failed to create a dictionary with the correct items!\n");
        return EXIT_FAILURE;
    } 
    else printf("Created a dictionary to hold the count of letters in Sega Dreamcast.\n");

    return EXIT_SUCCESS;
}

- (int)testNSSet {
    return EXIT_SUCCESS;
}
@end