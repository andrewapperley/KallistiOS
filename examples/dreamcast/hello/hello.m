#include <stdio.h>
#import <Foundation/Foundation.h>

@interface Person: NSObject
- (void)test;
@end

@implementation Person
- (void)test {
  NSLog(@"hello dc");
  NSString *json = @"\
{\
  \"random_double\": 123.456789012254,\
}";
  NSError *e;
  NSData *data = [json dataUsingEncoding: NSUTF8StringEncoding];
  NSDictionary *obj = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &e];
  NSLog(@"%f", [obj valueForKey: @"random_double"]);
}
@end

int main(int argc, char **argv, char **envp) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];     
    NSLog(@"start");
    Person *person = [[Person alloc] init];
    [person test];
    NSLog(@"end");
    NSLog(@"this came from nslog");
    fflush(stdout);
    [pool drain];
    return 0;
}