RegisterCommand('screenshot', function()
    captureScreenshot()
end, false)

function captureScreenshot()
    exports['screenshot-basic']:requestScreenshotUploadToDiscord('https://discord.com/api/webhooks/your-webhook-url', function(data)
        local response = json.decode(data)
        if response and response.success and response.url then
            if Config.Debug then
                print("Screenshot uploaded successfully to Discord!")
                print("Screenshot URL: " .. response.url)
            end
            TriggerServerEvent('davis:server:screenshot', response.url)
        else
            if Config.Debug then
            print("Failed to upload screenshot to Discord.")
            end
        end
    end)
end