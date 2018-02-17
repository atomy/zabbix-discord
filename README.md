# Overview
This is a script for notifications to [Discord](https://discordapp.com/) issued from [Zabbix](https://www.zabbix.com/).
It uses webhooks.

# Installation
- add the *discord.sh* script to your zabbix alertscripts directory
- configure your custom alertscript in zabbix
- ???
- profit

## Howto setup webhook for discord
https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks

## Configure custom zabbix alertscript
https://www.zabbix.com/documentation/3.4/manual/config/notifications/media/script

Just go with the 3 macros:
{ALERT.SENDTO}, {ALERT.SUBJECT} and {ALERT.MESSAGE}

I build a regexp into the script to detect if it's either a *PROBLEM* or *OK* (never got things like {EVENT.VALUE} working)

## Example webhook for discord
```$ curl -X POST --data '{ "embeds": [{"title": "<NOTIFICATION TITLE>", "url": "<NOTIFICATION URL>", "description": "<NOTIFICATION BODY>", "type": "link", "thumbnail": {"url": "https://storage.googleapis.com/material-design/publish/material_v_12/assets/0Bx4BSt6jniD7dFBUNHdrY05jQ3c/style-logos-product-intro-definition.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyyy```

## Discord notification in action
![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/discord-zabbix-notification.png)