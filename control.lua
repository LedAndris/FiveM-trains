CreateThread(function()
    print('Detector running...')
while true do
        Wait(0)
while #trains > 0 do
Wait(0)
for k,v in pairs(trains) do
    --collision:
if HasEntityCollidedWithAnything(NetworkGetEntityFromNetworkId(v.engine)) then
    if IsEntityTouchingEntity(NetToVeh(v.engine), GetVehiclePedIsIn(PlayerPedId(), false)) then
        print('Entity collided, stopping train')
        SetTrainSpeed(NetToVeh(v.engine), 0.00)
        while GetEntitySpeed(NetToVeh(v.engine)) > 1.00 do
            SetTrainSpeed(NetToVeh(v.engine), 0.00) --the train stops immediately, I will probably fix it soon, but wont upload it here until november cuz I forgot abt it
            Wait(100)
        end --this loop is needed otherwise the train would only stop for a few seconds (this loop is the reason why it stops instantly)
        print('Train stopped')
        local left = 10000
        while left ~= 0 do
            left = left - 10
            SetTrainSpeed(NetToVeh(v.engine), 0.00)
            Wait(10)
        end
        print('Train started') --debug prints (not configable of course)
        SetTrainSpeed(NetToVeh(v.engine), config.speed)
        SetTrainCruiseSpeed(NetToVeh(v.engine), config.speed)
        Wait(20000) --cooldown
    end
end
end
end
end
end)
