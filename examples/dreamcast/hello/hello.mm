#import <Foundation/NSObject.h>

@interface Person: NSObject
- (void)test;
@end

@implementation Person
- (void)test {
  printf("hello dc");
  fflush(stdout);
}
@end

int main(int argc, char **argv, char **envp) {
    Person *person = [[Person alloc] init];
    [person test];
    return 0;
}