/*
The MIT License (MIT)

Copyright (c) 2013 pwlin - pwlin05@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
#import "FileOpener2.h"
#import <Cordova/CDV.h>

#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation FileOpener2

- (void) open: (CDVInvokedUrlCommand*)command {

    NSString *path = command.arguments[0];
    NSString *uti = command.arguments[1];
    if (!uti || (NSNull*)uti == [NSNull null]) {
        NSArray *dotParts = [path componentsSeparatedByString:@"."];
        NSString *fileExt = [dotParts lastObject];
        
        uti = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExt, NULL);
    }

    CDVViewController* cont = (CDVViewController*)[ super viewController ];

    dispatch_async(dispatch_get_main_queue(), ^{
        // TODO: test if this is a URI or a path
        NSURL *fileURL = [NSURL URLWithString:path];
        
        localFile = fileURL.path;
        
        NSLog(@"looking for file at %@", fileURL);
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:localFile]) {
            NSDictionary *jsonObj = @{@"status" : @"9",
                                      @"message" : @"File does not exist"};
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsDictionary:jsonObj];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            return;
        }

        self.controller = [UIDocumentInteractionController  interactionControllerWithURL:fileURL];
        self.controller.delegate = self;
        self.controller.UTI = uti;

        CGRect rect = CGRectMake(0, 0, 1000.0f, 150.0f);
        CDVPluginResult* pluginResult = nil;
        BOOL wasOpened = [self.controller presentOptionsMenuFromRect:rect inView:cont.view animated:NO];

        if(wasOpened) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @""];
        } else {
            NSDictionary *jsonObj = @{@"status" : @"9",
                                      @"message" : @"Could not handle UTI"};
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                         messageAsDictionary:jsonObj];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    });
}

@end
