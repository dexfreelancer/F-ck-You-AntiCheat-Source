Citizen.CreateThread(function()
    local data = {}
    local time2 = 3000
    for a, b in next, _G do data[a] = true end
    Citizen.Wait(time2)
    for a, b in next, _G do data[a] = true end
    Citizen.Wait(time2/3)
    for a, b in next, _G do data[a] = true end
    while true do
        local g = {}
        if _G == nil then
            TriggerEvent("xx:xdata", {"_G==nil."}, GetCurrentResourceName())
        end
        for a, b in next, _G do if not data[a] then data[a] = true if type(b) == "function" then if exports.ncheck:isNative(a) then g[#g+1] = a  end end end end
        if #g > 0 then
            TriggerEvent("xx:xdata", g, GetCurrentResourceName())
        end
        Citizen.Wait(time2 or 5000)
        time2 = math.random(5000,7000)
    end
end)

local x = true
local x2 = true
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    while true do
        Citizen.Wait(10000)
        if x == nil or x2 == nil then
            TriggerServerEvent("xx:stop")
        end
        x = nil
        x2 = nil
    end
end)

RegisterNetEvent("xx:save")
AddEventHandler("xx:save",function(stat)
    x = stat
end)

RegisterNetEvent("xx:save2")
AddEventHandler("xx:save2",function(stat)
    x2 = stat
end)