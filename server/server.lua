Config = Config or {}

-- Remove the webhook check that's causing the error
-- We don't need this check since your config file already has the webhook defined

RegisterNetEvent('davis-screenshot:server:screenshot')
AddEventHandler('davis-screenshot:server:screenshot', function(url)
    local source = source
    local playerName = GetPlayerName(source) or "Unknown"
    
    if Config.Debug then
        print("Screenshot URL: " .. url)
        print("Player: " .. playerName)
    end
    
    local embed = {
        {
            ["color"] = 5814783,
            ["title"] = Config.Languages[Config.Language]['new_screenshot'] .. " - " .. playerName,
            ["description"] = "Screenshot taken at: " .. os.date("%Y-%m-%d %H:%M:%S"),
            ["image"] = {
                ["url"] = url,
            },
            ["footer"] = {
                ["text"] = Config.Languages[Config.Language]['footer'],
            },
        },
    }
    
    PerformHttpRequest(Config.FinalWebhook, function(err, text, headers)
        if err ~= 200 then
            print("^1Failed to send screenshot to Discord. Error code: " .. tostring(err) .. "^7")
        else
            if Config.Debug then
                print("Screenshot successfully sent to Discord webhook")
            end
        end
    end, 'POST', json.encode({ 
        username = Config.Languages[Config.Language]['bot_username'], 
        embeds = embed 
    }), { ['Content-Type'] = 'application/json' })
end)