ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("esx_barbershop:valider")

AddEventHandler("esx_barbershop:valider", function(Price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.getMoney() >= Price then 
        xPlayer.removeMoney(Price)
        print(Price)
        TriggerClientEvent('esx:showNotification', source, "Vous avez payez ~y~"..Price.."$")
        TriggerClientEvent('esx_barbershop:enregistrer', _src)
	else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'~y~argent")
    end
end)
