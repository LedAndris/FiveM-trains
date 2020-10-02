--MANIF:SV
local trains = {}
local players = 0
local scheduletrain = false
RegisterNetEvent('train:Register')
AddEventHandler('train:Register', function(obj)
for k,v in pairs(trains) do
for i,e in pairs(v) do
if type(e) == 'table' then
    for ind, cart in pairs(e) do
        DeleteEntity(NetworkGetEntityFromNetworkId(cart))
    end
else
    DeleteEntity(NetworkGetEntityFromNetworkId(e))
end
end
end
trains[#trains+1] = obj
TriggerClientEvent('train:GetBack', -1, trains, false)
end)
RegisterNetEvent('train:Get')
AddEventHandler('train:Get', function()
    local src = source
TriggerClientEvent('train:GetBack', src, trains, scheduletrain)
end)
RegisterNetEvent('API:GlobalizeEvent')
AddEventHandler('API:GlobalizeEvent', function(name, ...)
    print('Triggering event for all clients... event data: '..dump({...}))
TriggerClientEvent(name, -1, ...)
end)
AddEventHandler('playerConnecting', function()
players = players + 1
print('Players: '..players)
if players == 1 then
    print('Creating trains... (src: '..source..')')
   local target = source
    print('Scheduled train create')
    scheduletrain = true
end
end)
AddEventHandler('playerDropped', function(res)
    players = players - 1
if players == 0 then
    print('Deleting all trains since the server is empty')
    for k,v in pairs(trains) do
        for i,e in pairs(v) do
        if type(e) == 'table' then
            for ind, cart in pairs(e) do
                DeleteEntity(NetworkGetEntityFromNetworkId(cart))
            end
        else
            DeleteEntity(NetworkGetEntityFromNetworkId(e))
        end
        end
        end
end
end)

--[[
    object.engine = VehToNet(train)
    object.diver = PedToNet(ped)
    object.carts = getTrainCarts(train)
]]
CreateThread(function()
print('^2Trains loaded!')
end)

