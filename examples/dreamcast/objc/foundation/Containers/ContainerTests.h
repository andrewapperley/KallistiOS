/* KallistiOS ##version##

   ContainerTests.h
   Copyright (C) 2023 Andrew Apperley

   These tests will verify that the container classes of Foundation are working correctly.
*/
#import <Foundation/NSObject.h>

@interface ContainerTests: NSObject
- (int) testNSArray;
- (int) testNSDictionary;
- (int) testNSSet;
@end