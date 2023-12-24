/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#include <Foundation/Foundation.h>

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