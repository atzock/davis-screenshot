RegisterCommand('screenshot', function()
    captureScreenshot()
end, false)

function captureScreenshot()
    exports['ZSX_UIV2']:Notification('Screenshot', 'Screenshot wurde aufgenommen', 'fas fa-camera', 5000)
    
    -- Try using the older format with just two parameters
    exports['screenshot-basic']:requestScreenshotUpload(Config.ImageWebhookSave, 'files[]', function(data)
        if Config.Debug then
            print("Screenshot response received: " .. tostring(data))
        end
        
        -- More robust error checking
        if data == nil or data == "" then
            exports['ZSX_UIV2']:Notification('Screenshot', 'Screenshot upload failed - empty response', 'fas fa-camera', 5000)
            return
        end
        
        -- Try to parse JSON response, but handle non-JSON responses too
        local success, response = pcall(function()
            return json.decode(data)
        end)
        
        if success then
            -- First, try the standard Discord webhook response format
            if response and response.attachments and response.attachments[1] and response.attachments[1].url then
                local imageUrl = response.attachments[1].url
                handleSuccessfulUpload(imageUrl)
            -- Then try the format from your original code
            elseif response and response.url then
                handleSuccessfulUpload(response.url)
            -- Finally, check if it's a direct URL string
            elseif type(response) == "string" and string.match(response, "https?://") then
                handleSuccessfulUpload(response)
            else
                handleFailedUpload("Unrecognized response format")
            end
        else
            -- If not JSON, check if the response is a direct URL
            if type(data) == "string" and string.match(data, "https?://") then
                handleSuccessfulUpload(data)
            else
                handleFailedUpload("Invalid response format")
            end
        end
    end)
end

function handleSuccessfulUpload(imageUrl)
    TriggerServerEvent('davis-screenshot:server:screenshot', imageUrl)
    
    -- Notify user of success
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"System", "Screenshot uploaded successfully!"}
    })
    
    if Config.Debug then
        print("Screenshot uploaded successfully to Discord!")
        print("Screenshot URL: " .. imageUrl)
    end
end

function handleFailedUpload(reason)
    -- Notify user of failure
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"System", "Failed to upload screenshot: " .. reason}
    })
    
    if Config.Debug then
        print("Failed to upload screenshot to Discord: " .. reason)
    end
end