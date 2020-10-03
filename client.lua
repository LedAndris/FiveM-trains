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

  RegisterCommand('cleartrains', function()
    clear()
end, true)