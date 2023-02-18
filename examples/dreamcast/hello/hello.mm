#import <Foundation/NSObject.h>

Class
object_getClass (id object)
{
  if (object != nil)
    return object->isa;
  else
    return Nil;
}

long sysconf(int name) {
  switch(name){
    case _SC_NPROCESSORS_CONF: return 1;
    case _SC_NPROCESSORS_ONLN: return 1;
    default: return 0;
  }
}


int main(int argc, char **argv, char **envp) {
    /* The requisite line */

    return 0;
}