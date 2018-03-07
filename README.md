# Overview
This is a script for notifications to [Discord](https://discordapp.com/) issued from [Zabbix](https://www.zabbix.com/).
It uses webhooks.

# Prerequisites
- Discord Webhook [Howto Setup Discord Webhook](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

# Installation
0. modify hard-coded zabbix urls in `discord.sh` to aim towards your zabbix installation (`"url": "https://zabbix.your-domain-bleh.foo/"`)
0. modify hard-coded discord urls including token in `discord.sh` to aim towards your prior setup discord endpoint (`https://discordapp.com/api/webhooks/xxx/yyy`)
0. configure `AlertScriptsPath` of your zabbix installation - [Zabbix Howto](https://www.zabbix.com/documentation/3.4/manual/config/notifications/media/script)
0. add the `discord.sh` script to your zabbix `AlertScriptsPath` directory
0. make sure zabbix can access that file and it also has execution permission (`chmod 755 discord.sh`)
0. configure your custom alertscript in zabbix - [Zabbix Howto](https://www.zabbix.com/documentation/3.4/manual/config/notifications/media/script),
  script parameters are:
    0. {ALERT.SENDTO}
    0. {ALERT.SUBJECT}
    0. {ALERT.MESSAGE}
0. add media to a zabbix-user to be notified that way, probably re-configure zabbix-action

# Additional Info
I build a regexp into the script to detect if it's either a *PROBLEM* or *OK* (never got things like {EVENT.VALUE} working)

## Example webhook for discord
```$ curl -X POST --data '{ "embeds": [{"title": "<NOTIFICATION TITLE>", "url": "<NOTIFICATION URL>", "description": "<NOTIFICATION BODY>", "type": "link", "thumbnail": {"url": "https://storage.googleapis.com/material-design/publish/material_v_12/assets/0Bx4BSt6jniD7dFBUNHdrY05jQ3c/style-logos-product-intro-definition.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyyy```

## Zabbix Media type config
![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/zabbix-media-type-config.png)

## Discord notification in action
![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/discord-zabbix-notification.png)