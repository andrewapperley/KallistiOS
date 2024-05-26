/* KallistiOS ##version##

   foundation.m
   Copyright (C) 2023 Andrew Apperley

   This example serves to verify that Libs-Base (Foundation) is correctly
   setup and demonstrates the power that such a library can provide.
*/

#import <Foundation/NSObject.h>
#import <Foundation/NSAutoreleasePool.h>
#import "NSObject/NSObjectTests.h"
#import "Containers/ContainerTests.h"
#import <objc/objc.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int result = EXIT_SUCCESS;
    const char *failedTestName = NULL;
    
    Class testClasses[] = {
        [NSObjectTests class],
        [ContainerTests class]
    };

    int testClassesCount = sizeof(testClasses) / sizeof(testClasses[0]);

    for (int i = 0; i < testClassesCount; i++) {
        Class testClass = testClasses[i];
        const char *className = class_getName(testClass);
        printf("**** Starting %s Tests ****\n", className);
        // Grab all test case method signatures. These will be methods that begin with the string 'test'.
        unsigned int outCount = 0;
        Method *methodList = class_copyMethodList(testClass, &outCount);

        if(outCount <= 0) {
            fprintf(stderr, "%s didn't implement any test cases !\n", className);
            result = EXIT_FAILURE;
            goto exit;
        }
        id tests = class_createInstance(testClass, 0);
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
        printf("**** Finished %s Tests ****\n\n", className);
        free(methodList);
    }

    goto exit;

exit:

    if(result == EXIT_FAILURE) {
        fprintf(stderr, "\n**** FAILURE! ****\n");
        if (failedTestName) {
            fprintf(stderr, "**** %s ****\n\n", failedTestName);
        }
    } else {
        printf("**** SUCCESS! ****\n\n");
    }

    //   [[NSRunLoop currentRunLoop] run];
    [pool release];
    return result;
}