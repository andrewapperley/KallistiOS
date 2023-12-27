/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#include <Foundation/Foundation.h>
#include "NSObject/NSObjectTests.h"
#import <objc/objc.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


int main(int argc, char *argv[]) {
    // gdb_init();
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    int result = EXIT_SUCCESS;
    char *failedTestName = NULL;
    
    // Grab all test case method signatures. These will be methods that begin with the string 'test'.
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList([NSObjectTests class], &outCount);
    NSObjectTests *tests = [[NSObjectTests alloc] init];

    if(outCount <= 0) {
        fprintf(stderr, "No test cases implemented!\n");
        result = EXIT_FAILURE;
        goto exit;
    }
    
    for(int i = outCount-1; i >= 0; i--) {
        SEL selector = method_getName(methodList[i]);
        const char *selectorName = sel_getName(selector);
        if (strstr(selectorName, "test")) {
            IMP imp = objc_msg_lookup(tests, selector);
            id testCaseResult = imp(tests, selector);
            if (testCaseResult == EXIT_FAILURE){
                result = EXIT_FAILURE;
                failedTestName = selectorName;
                goto exit;
            }
        }
    }

    goto exit;

exit:

    if(result == EXIT_FAILURE) 
        fprintf(stderr, "**** %s FAILURE! ****\n", failedTestName);
    else  
        printf("**** SUCCESS! ****\n");

    //   [[NSRunLoop currentRunLoop] run];
    free(methodList);
    [pool release];
    return result;
}