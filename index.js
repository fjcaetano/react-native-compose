import React from 'react';

import { NativeModules } from 'react-native';

export const ComposeMessage = NativeModules.FJCMessageCompose;
export const ComposeMail = NativeModules.FJCMailCompose;

export const ComposeResult = {
  sent: 'sent',
  saved: 'saved',
};