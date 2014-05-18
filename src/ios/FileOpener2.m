#import "FileOpener2.h"
#import <Cordova/CDV.h>

#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation FileOpener2
@synthesize controller = docController;

- (void) open: (CDVInvokedUrlCommand*)command {

    NSString *path = [command.arguments objectAtIndex:0];
    //NSString *uti = [command.arguments objectAtIndex:1];

    CDVViewController* cont = (CDVViewController*)[ super viewController ];

    NSArray *dotParts = [path componentsSeparatedByString:@"."];
    NSString *fileExt = [dotParts lastObject];

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
