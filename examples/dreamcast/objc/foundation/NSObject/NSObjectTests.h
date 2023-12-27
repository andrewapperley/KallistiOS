/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#include <Foundation/Foundation.h>
#include "../FoundationTestCase.h"

@class Person;

@interface NSObjectTests: FoundationTestCase {
   @private
   Person *_person1;
   Person *_person2;
}
- (int) testInstanceCreation;
- (int) testPropertyVerification;
- (int) testRespondsToMessage;
- (int) testSecondInstanceCreation;
- (int) testSettingPropertyWithNSObjectInstance;
@end