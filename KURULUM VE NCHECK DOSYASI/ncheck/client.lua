local natives = {}
local rawBypass = {}
local instantBan = {"fuckmedaddy"}

function isNative(nat)
    if checkInstaBan(nat) then
        return true
    end
    if natives[nat] == true then
        return false
    end
    if rawBypass[nat] == true then
        return false
    end
    if not rawBypass[nat] then 
        if checkRawManifest(nat) then
            rawBypass[nat] = true
            return false
        end
    end
    return true
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        TriggerEvent("xx:save2",true)
    end
end)

function checkInstaBan(native)
    for k,v in pairs(instantBan) do
        if v == native then
            return true
        end
    end
    return false
end

function checkRawManifest(native)
    rawfile = LoadResourceFile(GetCurrentResourceName(),"rawmanifest.txt")
    if string.find(rawfile,"Global."..native) ~= nil then
        return true
    end
    return false
end

function loadNatives()
    jsonfile = LoadResourceFile(GetCurrentResourceName(),"lua.json")
    for native,_ in pairs(json.decode(jsonfile)) do
        natives[native] = true
    end
end
loadNatives()