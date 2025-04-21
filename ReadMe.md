# Screenshot Manager

A simple resource for FiveM that allows players to take and share screenshots with a Discord webhook.

## Features

* Players can take a screenshot with the `/screenshot` command
* Screenshots are automatically uploaded to a Discord webhook
* Screenshots are sent to a Discord channel with a title and a footer

## Installation

1. Download the latest version of the resource from the [releases page](https://github.com/atzock/davis-screenshot/releases)
2. Extract the zip file to your `resources` folder
3. Add the following line to your `server.cfg` file: `start davis-screenshot`
4. Configure the resource by editing the `config.lua` file

## Configuration

The configuration file is located at `davis-screenshot/config.lua`. You can change the following settings:

* `Config.FinalWebhook`: The Discord webhook URL to send the screenshot to
* `Config.ImageWebhookSave`: The Discord webhook URL to send the screenshot to (same as above, but for the image itself)
* `Config.Language`: The language to use for the Discord message (en or de)
* `Config.Languages`: A table with language-specific strings for the Discord message

## Dependencies

* [screenshot-basic](https://github.com/citizenfx/screenshot-basic) for taking screenshots
* [es_extended](https://github.com/ESX-Official/es_extended) for fivem framework

## Support

If you have any questions or need help with the resource, feel free to contact me on the [Discord](https://discord.gg/fpdbKbHp7w).