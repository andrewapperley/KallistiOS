/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#import <Foundation/Foundation.h>
#import "NSObject/NSObjectTests.h"
#import "Containers/ContainerTests.h"
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
    
    Class testClasses[] = {
        [NSObjectTests class],
        [ContainerTests class]
    };

    int testClassesCount = sizeof(testClasses) / sizeof(testClasses[0]);

    for (int i = 0; i < testClassesCount; i++) {
        Class testClass = testClasses[i];
        // Grab all test case method signatures. These will be methods that begin with the string 'test'.
        unsigned int outCount = 0;
        Method *methodList = class_copyMethodList(testClass, &outCount);

        if(outCount <= 0) {
            fprintf(stderr, "No test cases implemented!\n");
            result = EXIT_FAILURE;
            goto exit;
        }
        FoundationTestCase *tests = class_createInstance(testClass, 0);
        for(int ii = outCount-1; ii >= 0; ii--) {
            SEL selector = method_getName(methodList[ii]);
            const char *selectorName = sel_getName(selector);
            if (strstr(selectorName, "test")) {
                IMP imp = objc_msg_lookup(tests, selector);
                id testCaseResult = imp(tests, selector);
                if (testCaseResult == EXIT_FAILURE){
                    result = EXIT_FAILURE;
                    failedTestName = selectorName;
                    free(methodList);
                    goto exit;
                }
            }
        }
        free(methodList);
    }

    goto exit;

exit:

    if(result == EXIT_FAILURE) 
        fprintf(stderr, "**** %s FAILURE! ****\n", failedTestName);
    else  
        printf("**** SUCCESS! ****\n");

    //   [[NSRunLoop currentRunLoop] run];
    [pool release];
    return result;
}