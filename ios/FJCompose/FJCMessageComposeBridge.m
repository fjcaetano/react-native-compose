//
//  FJCMessageComposeBridge.m
//  react-native-compose
//
//  Created by Flávio Caetano on 2018-09-12
//  Copyright © 2018 ReCaptcha. All rights reserved.
//

@import Foundation;
@import MessageUI;
@import Messages;

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(FJCMessageCompose, NSObject)

RCT_EXTERN_METHOD(canSendText:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject);

RCT_EXTERN_METHOD(canSendAttachments:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject);

RCT_EXTERN_METHOD(canSendSubject:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject);

RCT_EXTERN_METHOD(send:(NSDictionary *)data
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject);

@end
