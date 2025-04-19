RegisterCommand('screenshot', function()
    captureScreenshot()
end, false)

function captureScreenshot()
    exports['screenshot-basic']:requestScreenshotUploadToDiscord(Davis.ImageWebhookSave, function(data)
        local response = json.decode(data)
        if response and response.success and response.url then
            TriggerServerEvent('davis-screenshot:server:screenshot', source, response.url)
            
            if Davis.Debug then
                print("Screenshot uploaded successfully to Discord!")
                print("Screenshot URL: " .. response.url)
            end
        else
            if Davis.Debug then
                print("Failed to upload screenshot to Discord.")
            end
        end
    end)
end