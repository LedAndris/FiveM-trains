--MANIF:CL
trains = {}
Citizen.CreateThread(function()
TriggerServerEvent('train:Get')
end)
RegisterNetEvent('train:GetBack')
AddEventHandler('train:GetBack', function(info, schedule)
    print('Trains got back: '..dump(info))
    if schedule then
        print('Creating train...')
TriggerServerEvent('train:Register', CreateTrain())
    end
trains = info
for k,v in pairs(trains) do
    if GetBlipFromEntity(NetworkGetEntityFromNetworkId(v.engine)) == 0 then
        print('Making new blip for joining player... (blip: '..GetBlipFromEntity(NetworkGetEntityFromNetworkId(v.engine))..')')
makeENTBlip(1, 66, 1.0, 'Vonat', NetworkGetEntityFromNetworkId(v.engine), false, #v.carts)
    end
end
end)


RegisterNetEvent('ENT:Blip')
AddEventHandler('ENT:Blip', function(sprite, color, size, title, ent, short, num)
    print('Blip event triggered with id: '..ent)
    blip = makeENTBlip(sprite, color, size, title, NetworkGetEntityFromNetworkId(ent), short, num)
end)
RegisterNetEvent('train:Create')
AddEventHandler('train:Create', function()
    print('Creating train...')
TriggerServerEvent('train:Register', CreateTrain())
end)
RegisterCommand('train', function(source, args)
    print('Creating train...')
    TriggerServerEvent('train:Register', CreateTrain())
end, true)

--[[
    object.engine = VehToNet(train)
    object.diver = PedToNet(ped)
    object.carts = getTrainCarts(train)
]]
RegisterCommand('trainspeed', function(source, args)
    for k, v in ipairs(trains) do
    print(GetEntitySpeed(NetToVeh(v.engine)))
    end
end, false)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
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
            print('Deleted all trains')
    end
  end)

  RegisterCommand('cleartrains', function()
    clear()
end, true)