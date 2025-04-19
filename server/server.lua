local discordWebhook = Davis.FinalWebhook

RegisterNetEvent('davis:server:screenshot', function(url)
    if Davis.Debug then
        print("Screenshot URL: " .. url)
    end

    local embed = {
        {
            ["color"] = 5814783,
            ["title"] = Davis.Languages[Davis.Language]['new_screenshot'] .. " " .. GetPlayerName(source),
            ["url"] = url,
            ["image"] = {
                ["url"] = url or "Unknown",
            },
            ["footer"] = {
                ["text"] = Davis.Languages[Davis.Language]['footer'],
            }
        }
    }
    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = Davis.Languages[Davis.Language]['bot_username'], embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
