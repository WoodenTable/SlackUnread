# SlackUnread

Show the number of unread messages in Slack on the menu bar.

### Why this project?

Because I want to hide the Dock to save screen space, but Slack does not support displaying the number of unread messages in the menu bar, so I created this project.

### How this works?

It uses [AXUIElement API](https://developer.apple.com/documentation/applicationservices/axuielement_h) to read the badge text of Slack from Dock app, then display the text on menu bar.

### Will this app leak my private messages?

It read the badge text from Dock app, it never directly accesses your Slack message, so it won't leak your privacy.
