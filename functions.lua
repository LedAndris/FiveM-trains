--MANIF:SH
function makeENTBlip(sprite, color, size, title, ent, short, numberinblip)
    if DoesEntityExist(ent) then
    local blip = AddBlipForEntity(ent)
    local short = short or false
            SetBlipSprite(blip, sprite)
            SetBlipColour(blip, color)
            SetBlipDisplay(blip, 6)
            SetBlipScale(blip, size)
            BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(title)
      EndTextCommandSetBlipName(blip)
            if short then
                SetBlipAsShortRange(blip, true)
            end
            if numberinblip then
                ShowNumberOnBlip(blip, numberinblip)
            end
            print('^2Blip created successfully')
            return blip
        else
            print('^1 Failed to create blips due to error: CL:CHASE_MAIN:THRD: CL.Entstat: false (entity: '..ent..')^7')
        end
  end

  function loadTrains()
    local start = GetGameTimer()
for k,v in ipairs(config.trains) do
load(v)
print('LOOP: '..v)
end
math.abs(start - GetGameTimer() * 1000)
print('Trains loaded in: '..string.format('%f', start))
end

function load(model)
    print('Loading: '..model)
  
local model = GetHashKey(model)
if IsModelValid(model) then
RequestModel(model)
		while not HasModelLoaded(model) do
            Wait(100)
        end
        print('Model loaded')
        return true
    
else
    print('Invalid model, aborting')
    return false
end
end


function getTrainCarts(train)
    local carts = {}
    for i = 1, 100 do
        local currEnt = GetTrainCarriage(train, i)
        if DoesEntityExist(currEnt) then
            carts[i] = VehToNet(currEnt)
        else
            print('Returning '..#carts..' carts')
            return carts
        end
    end
    print('Returning '..#carts..' carts')
    return carts
    end
function CreateTrain()
    print('Creating train in function...')
    local location = config.spawns[math.random(1, #config.spawns)]
    DeleteAllTrains()
    loadTrains()
    math.randomseed(GetGameTimer())
    local traintype = math.random(0, 23)
    print('Train type: '..traintype)
    local train = CreateMissionTrain(traintype, location, 1)
    load(config.driver)
    local ped = CreatePedInsideVehicle(train, 4, GetHashKey(config.driver), -1, true, true)
    if DoesEntityExist(ped) then
        print('^2Created driver inside train, id: '..ped)
    else
        print('^1Something went wrong while creating driver, id: '..ped)
    end
    TriggerServerEvent('API:GlobalizeEvent', 'ENT:Blip', 1, 2, 1.0, 'Vonat', VehToNet(train), false, #getTrainCarts(train))
    print('Train created with id: '..train)
    SetTrainCruiseSpeed(train, config.speed)
    local object = {}
    object.engine = VehToNet(train)
    object.diver = PedToNet(ped)
    object.carts = getTrainCarts(train)
    return object
    end

    function dump(o)
        if type(o) == 'table' then
           local s = '{ '
           for k,v in pairs(o) do
              if type(k) ~= 'number' then k = '"'..k..'"' end
              s = s .. '['..k..'] = ' .. dump(v) .. ','
           end
           return s .. '} '
        else
           return tostring(o)
        end
     end
     dist = function(vec1 , vec2, useZ)
        if useZ then
        return #(vec1 - vec2)
        else
        return #(vec1.xy - vec2.xy)
        end
        end
        function firstToUpper(str)
          return (str:gsub("^%l", string.upper))
      end
      function clear()
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