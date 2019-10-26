# Overview
This is an alert-script for notifications to [Discord](https://discordapp.com/), issued from [Zabbix](https://www.zabbix.com/).
It uses Discord-webhooks.

![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/discord-zabbix-notification.png)

# Prerequisites
- Discord Webhook [Howto Setup Discord Webhook](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

# Installation
1. set env *WEBHOOK_URL* to your previously setup discord-web-hook-url in `discord.sh` (e.g. `https://discordapp.com/api/webhooks/xxx/yyy`)
2. (optional) set env *ZABBIX_URL* in bash-script `discord.sh` to aim towards your zabbix installation (e.g. `https://zabbix.your-domain-bleh.foo/`), this will be used to link the discord-messages to your zabbix installation
3. configure `AlertScriptsPath` of your zabbix installation - [Zabbix Howto](https://www.zabbix.com/documentation/3.4/manual/config/notifications/media/script)
4. add the `discord.sh` script to your zabbix `AlertScriptsPath` directory
5. make sure zabbix can access that file and it also has execution permission (`chmod +x discord.sh`)
6. configure your custom alertscript in zabbix - [Zabbix Howto](https://www.zabbix.com/documentation/3.4/manual/config/notifications/media/script),
  script parameters are (as shown in zabbix documentation):
    ```
    {ALERT.SENDTO}
    {ALERT.SUBJECT}
    {ALERT.MESSAGE}
    ```
7. add media to a zabbix-user to be notified that way, the "Send to"-field is the discord-channel name here, e.g. #zabbix.
8. (optional) probably re-configure zabbix-action for different message-format

# Additional Info
I build a regexp into the script to detect if it's either a *PROBLEM*, *OK* or *Resolved* (never got things like {EVENT.VALUE} working)

## Example webhook for discord
```$ curl -X POST --data '{ "embeds": [{"title": "<NOTIFICATION TITLE>", "url": "<NOTIFICATION URL>", "description": "<NOTIFICATION BODY>", "type": "link", "thumbnail": {"url": "https://storage.googleapis.com/material-design/publish/material_v_12/assets/0Bx4BSt6jniD7dFBUNHdrY05jQ3c/style-logos-product-intro-definition.png"}}] }' -H "Content-Type: application/json" https://discordapp.com/api/webhooks/xxx/yyyy```

## Zabbix Media type config
![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/zabbix-media-type-config.png)

## Zabbix User media config
![Image of Discord-Notifcation](https://github.com/atomy/zabbix-discord/blob/master/doc/zabbix-discord-user-media-config.png)
