#import <Foundation/Foundation.h>

@interface Dreamcast: NSObject {
  NSTimer *timer;
}
- (void)test;
@end

@implementation Dreamcast
  - (void)test {
    timer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(printSomething:) userInfo: nil repeats: YES];
  }
  - (void)printSomething:(NSTimer *)timer {
    NSLog(@"Wow! Is that Objective-C concurrency and NSLog working on the Dreamcast!");
  }
@end

int main(int argc, char **argv, char **envp) {
    gdb_init();
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];     

    Dreamcast *dc = [[Dreamcast alloc] init];
    [dc test];
    [[NSRunLoop currentRunLoop] run];
    [pool release];

    fflush(stdout);
    return 0;
}