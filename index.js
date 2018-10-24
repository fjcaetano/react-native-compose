import React from 'react';

import { NativeModules } from 'react-native';

const { FJCMessageCompose, FJCMailCompose } = NativeModules;

export const ComposeResult = {
  sent: 'sent',
  saved: 'saved',
};

export const ComposeMessage = {
  send(body) {
    return FJCMessageCompose.send(body);
  },
};

export const ComposeMail = {
  send(body) {
    return FJCMailCompose.send(body);
  },
};

(async function() {
  ComposeMail.canSendMail = await FJCMailCompose.canSendMail();
  ComposeMessage.canSendText = await FJCMessageCompose.canSendText();
  ComposeMessage.canSendAttachments = await FJCMessageCompose.canSendAttachments();
  ComposeMessage.canSendSubject = await FJCMessageCompose.canSendSubject();
}());
