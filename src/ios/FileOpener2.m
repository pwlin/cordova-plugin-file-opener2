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
@synthesize controller = docController;

- (void) open: (CDVInvokedUrlCommand*)command {

    NSString *path = [[command.arguments objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *uti = [command.arguments objectAtIndex:1];

    CDVViewController* cont = (CDVViewController*)[ super viewController ];

    NSArray *dotParts = [path componentsSeparatedByString:@"."];
    NSString *fileExt = [dotParts lastObject];
	//NSString *fileExt = [[dotparts lastObject] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSString *uti = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExt, NULL);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //NSLog(@"path %@, uti:%@", path, uti);
        NSURL *fileURL = nil;

        //fileURL = [NSURL URLWithString:path];
        fileURL = [NSURL fileURLWithPath:path];
        
        localFile = fileURL.path;

        dispatch_async(dispatch_get_main_queue(), ^{

            docController = [UIDocumentInteractionController  interactionControllerWithURL:fileURL];
            docController.delegate = self;
            docController.UTI = uti;

            CGRect rect = CGRectMake(0, 0, 1000.0f, 150.0f);
            CDVPluginResult* pluginResult = nil;
            BOOL wasOpened = [docController presentOptionsMenuFromRect:rect inView:cont.view animated:NO];
            //presentOptionsMenuFromRect
            //presentOpenInMenuFromRect

            if(wasOpened) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @""];
                //NSLog(@"Success");
            } else {
                NSDictionary *jsonObj = [ [NSDictionary alloc]
                                         initWithObjectsAndKeys :
                                         @"9", @"status",
                                         @"Could not handle UTI", @"message",
                                         nil
                                         ];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
                //NSLog(@"Could not handle UTI");
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        });
    });
}

@end
