import React from 'react';

import { NativeModules } from 'react-native';

const FJCComposeMessage = NativeModules.FJCMessageCompose;
const FJCComposeMail = NativeModules.FJCMailCompose;

export const ComposeResult = {
  sent: 'sent',
  saved: 'saved',
};

export const ComposeMessage = {
  canSendText() {
    return FJCComposeMessage.canSendText();
  },

  canSendAttachments() {
    return FJCComposeMessage.canSendAttachments();
  },

  canSendSubject() {
    return FJCComposeMessage.canSendSubject();
  },

  send(body) {
    return FJCComposeMessage.send(body);
  },
};

export const ComposeMail = {
  canSendMail() {
    return FJCComposeMail.canSendMail();
  },

  send(body) {
    return FJCComposeMail.send(body);
  },
};
