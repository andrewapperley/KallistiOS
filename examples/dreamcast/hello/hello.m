#include <stdio.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>

@interface Person: NSObject
- (void)test;
@end

@implementation Person
- (void)test {
  printf("hello dc");
  printf(" \n");
  fflush(stdout);
}
@end

int main(int argc, char **argv, char **envp) {
    printf("start \n");
    fflush(stdout);
    Person *person = [[Person alloc] init];
    [person test];
    printf("end \n");
    fflush(stdout);
    return 0;
}