//
//  FJCMailCompose.m
//  react-native-compose
//
//  Created by Flávio Caetano on 2018-09-12
//  Copyright © 2018 ReCaptcha. All rights reserved.
//


@import MobileCoreServices;
@import MessageUI;

#import "FJCMailCompose.h"

@interface FJCMailCompose () <MFMailComposeViewControllerDelegate>

@property (readwrite) RCTPromiseResolveBlock resolve;
@property (readwrite) RCTPromiseRejectBlock reject;

@end


@implementation FJCMailCompose

- (void)canSendMail:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    resolve(@(MFMailComposeViewController.canSendMail));
}

- (void)send:(NSDictionary *)data resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if (!MFMailComposeViewController.canSendMail) {
        reject(@"cannotSendMail", @"Cannot send mail", nil);
        return;
    }

    MFMailComposeViewController *vc = [MFMailComposeViewController new];
    vc.mailComposeDelegate = self;
    vc.toRecipients = data[@"recipients"];
    vc.subject = data[@"subject"];
    [vc setMessageBody:data[@"body"] isHTML:NO];

    for (id attachment in data[@"attachments"]) {
        NSData *data = [attachment[@"text"] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *filename = [attachment[@"filename"] stringByAppendingString:attachment[@"ext"]];

        [vc addAttachmentData:data mimeType:attachment[@"mimeType"] fileName:filename];
    }

    UIViewController *rootVC = UIApplication.sharedApplication.keyWindow.rootViewController;
    if (rootVC) {
        [rootVC presentViewController:vc animated:true completion:nil];
        self.resolve = resolve;
        self.reject = reject;
    }
    else {
        reject(@"failed", @"Could not present view controller", nil);
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            self.reject(@"cancelled", @"Operation has been cancelled", nil);
            break;

        case MFMailComposeResultSent:
            self.resolve(@"sent");
            break;

        case MFMailComposeResultSaved:
            self.resolve(@"saved");
            break;

        case MFMailComposeResultFailed:
            self.reject(@"failed", @"Operation has failed", nil);
            break;
    }

    self.resolve = nil;
    self.reject = nil;

    [controller dismissViewControllerAnimated:true completion: nil];
}

@end
