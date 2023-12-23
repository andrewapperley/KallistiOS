#include	<Foundation/Foundation.h>

int main(int argc, char *argv[], char **env)
{
  NSAutoreleasePool	*pool = [[NSAutoreleasePool alloc] init];
  

  [[NSRunLoop currentRunLoop] run];
  [pool release];
  return 0;
}