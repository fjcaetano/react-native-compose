//
//  FJCMessageCompose.m
//  react-native-compose
//
//  Created by Flávio Caetano on 2018-09-12
//  Copyright © 2018 ReCaptcha. All rights reserved.
//


@import MobileCoreServices;
@import MessageUI;

#import "FJCMessageCompose.h"

@interface FJCMessageCompose () <MFMessageComposeViewControllerDelegate>

@property (readwrite) RCTPromiseResolveBlock resolve;
@property (readwrite) RCTPromiseRejectBlock reject;

@end


@implementation FJCMessageCompose

- (void)canSendText:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    resolve(@(MFMessageComposeViewController.canSendText));
}

- (void)canSendAttachments:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    resolve(@(MFMessageComposeViewController.canSendAttachments));
}

- (void)canSendSubject:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    return resolve(@(MFMessageComposeViewController.canSendSubject));
}

- (void)send:(NSDictionary *)data resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    if (!MFMessageComposeViewController.canSendText) {
        reject(@"cannotSendText", @"Cannot send text", nil);
        return;
    }

    MFMessageComposeViewController *vc = [MFMessageComposeViewController new];
    vc.messageComposeDelegate = self;
    vc.recipients = data[@"recipients"];
    vc.body = data[@"body"];

    if (MFMessageComposeViewController.canSendSubject) {
        vc.subject = data[@"subject"];
    }

    if (MFMessageComposeViewController.canSendAttachments) {
        for (id attachment in data[@"attachments"]) {
            NSData *data = [attachment[@"text"] dataUsingEncoding:NSUTF8StringEncoding
];
            NSString *filename = [attachment[@"filename"] stringByAppendingString:attachment[@"ext"]];
            NSString * uti = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                                                        (__bridge CFStringRef) attachment[@"mimeType"],
                                                                                        NULL);

            [vc addAttachmentData:data typeIdentifier:uti filename:filename];
        }
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

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
            self.reject(@"cancelled", @"Operation has been cancelled", nil);
            break;

        case MessageComposeResultSent:
            self.resolve(@"sent");
            break;

        case MessageComposeResultFailed:
            self.reject(@"failed", @"Operation has failed", nil);
            break;
    }

    self.resolve = nil;
    self.reject = nil;

    [controller dismissViewControllerAnimated:true completion: nil];
}

@end
