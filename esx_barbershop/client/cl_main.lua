ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx_barbershop:enregistrer')
AddEventHandler('esx_barbershop:enregistrer', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)



for k,v in pairs(Config.Barbers) do 

    local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
    SetBlipSprite(blip, 71)
    SetBlipColour(blip, 0)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Coiffeur")
    EndTextCommandSetBlipName(blip)
end

--[[MaquillageListe = {"Aucun"}
for i = 1, 71, 1 do
    table.insert(MaquillageListe, GetLabelText("CC_MKUP_" .. i - 1))
end

LipsListe = {"Aucun"}
for i = 1, 10, 1 do
    table.insert(LipsListe, GetLabelText("CC_LIPSTICK_" .. i - 1))
end]]

local SettingsMenu = {
    percentage = 0.0,
    ColorHear = {primary = {1, 1}, secondary = {1, 1}},
    ColorBrow = {primary = {1, 1}, secondary = {1, 1}},
    ColorBeard = {primary = {1, 1}, secondary = {1, 1}}

}

function CreateFaceCam(heading)


    playerPed = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(playerPed)
    local distance = 0.9


    -- Convertir l'angle de degrés en radians
    local headingRad = heading * 0.0174533

    -- Calculer les coordonnées de la caméra
    local cameraX = playerPos.x + (distance * math.sin(-headingRad))
    local cameraY = playerPos.y + (distance * math.cos(-headingRad))
    local cameraZ = playerPos.z + 0.62

    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    local playerHeading = GetHeadingFromVector_2d(cameraX - playerPos.x, cameraY - playerPos.y)
    SetEntityHeading(playerPed, playerHeading)
    SetPedResetFlag(playerPed, 249, true)
    SetPedResetFlag(playerPed, 200, true)

    SetCamFov(camera, 30.0)
    -- Configurer les coordonnées de la caméra
    SetCamCoord(camera, cameraX, cameraY, cameraZ)

    -- Configurer l'angle de la caméra
    SetCamRot(camera, 0.0, 0.0, heading, 2)

    PointCamAtCoord(camera,playerPos.x, playerPos.y, playerPos.z + 0.70)

    -- Rendre la caméra active
    RenderScriptCams(true, false, 0, 1, 0)
end

function nosave()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobskin) 
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function StopfaceCam()
    local playerPed = GetPlayerPed(-1)

    -- Réactiver les mouvements de la tête du joueur
    SetPedResetFlag(playerPed, 249, false)
    SetPedResetFlag(playerPed, 200, false)
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(camera, false)
end

local MaquillageListe = {"Aucun"}
for i = 1, 71, 1 do
    table.insert(MaquillageListe, GetLabelText("CC_MKUP_" .. i - 1))
end

local LipsListe = {"Aucun"}
for i = 1, 10, 1 do
    table.insert(LipsListe, GetLabelText("CC_LIPSTICK_" .. i - 1))
end

local CouleurRougeLevre = {
    OpaPercent = 0,
    Primaire = {1, 1},
    Secondaire = {1, 1}
}
local LipsIndex = 1
local MaquillageIndex = 1 
local LentillesList = { "Vert", "Emeraude", "Bleu clair", "Bleu marine", "Châtain", "Marron foncé", "Noisette", "Gris foncé", "Gris clair", "Rose", "Jaune", "Violet", "Opaque", "Nuances de gris", "Tequila Sunrise", "Atomique", "Courbé", "ECola", "Ranger de l/'espace", "Ying Yang", "Cible", "Lézard", "Dragon", "Extra-terrestre", "Chèvre", "Smiley", "Possédé", "Démon", "Infecté", "Alien", "Mort-vivant", "Zombie"}
local Lentillesindex = 1 
local BarbeListe = {"Rasé de près","Arc","Bouc enrobée","Bouc libre","Bouc","Bouc long","Collier","Rasée de haut","Russe","Chapeau","Pas rasé","Chapeau rasé","Chinoise","Année 50","Mafieux long","Mafieux court","Yakouza","Année 80","Longue","Chapeau incurver","Chapeau incurver long","Pablo","Jefe","Washington","Algérien","Anglais","Français","Vieux","Moine"}
local SourcilsListe = { "Sourcils n°1","Sourcils n°2","Sourcils n°3","Sourcils n°4","Sourcils n°5","Sourcils n°6","Sourcils n°7","Sourcils n°8","Sourcils n°9","Sourcils n°10","Sourcils n°11","Sourcils n°12","Sourcils n°13","Sourcils n°14","Sourcils n°15","Sourcils n°16","Sourcils n°17","Sourcils n°18","Sourcils n°19","Sourcils n°20","Sourcils n°21","Sourcils n°22","Sourcils n°23","Sourcils n°24","Sourcils n°25","Sourcils n°26","Sourcils n°27","Sourcils n°28","Sourcils n°29","Sourcils n°30","Sourcils n°31","Sourcils n°32","Sourcils n°33","Sourcils n°34"}
local CheveuxListe = {"Rasé de près","Côtés rasés","Crête","Coupe hipster","Raie sur le côté","Coupe courte","Coupe biker","Queue de cheval","Nattes tressées","Cheveux gominés","Brosse","Cheveux Hérissés","Coupe césar","Coupe inégale","Dreadlocks","Cheveux longs","Boules ébourrifiées","Surfeur","Court, raie sur le coté","Côtés gominés","Cheveux longs gominés","Jeune hipster","Mullet","Lunettes thermique","Nattes tressées classique","Nattes tressées, palmiers","Nattes tressées, éclairs","Nattes tressées, plates","Nattes tressées, zigzag","Nattes tressées, spirales","Brosse à l'ancienne","Vers l'arrière","Undercut vers l'arrière","Undercut sur le côté","Piquée","Sauvage","Moine"}
local MenuList = {List = 1, List1 = 1, List2 = 1}
local BarberMenu = false

------------------------------MENU SHOPS


function OpenMenuBarber(heading, Price, Type)
    haircolor1 = GetPedHairColor(playerPed)
    haircolor2 = GetPedHairHighlightColor(haircolor2)
    --lipstick = GetPedHeadOverlayData(playerPed, 8)
    --local successlip, overlayValuelip, colourTypelip, firstColourlip, secondColourlip, overlayOpacitylip = GetPedHeadOverlayData(PlayerPedId(), 8)
    

local barber = RageUI.CreateMenu("", "Catégories", 10, 80, Type, Type)
local barbe = RageUI.CreateSubMenu(barber, "", "Barbes", 10, 80, Type, Type)
local cheveux = RageUI.CreateSubMenu(barber, "", "Coiffures", 10, 80, Type, Type)
local sourcils = RageUI.CreateSubMenu(barber, "", "Sourcils", 10, 80, Type, Type)
--local lips = RageUI.CreateSubMenu(barber, "", "Rouge à lèvres", 10, 80, "shopui_title_barber"..Type, "shopui_title_barber"..Type)

barber.Closed = function() 
    BarberMenu = false
    StopfaceCam()
    FreezeEntityPosition(PlayerPedId(), false)
end

--[[lips.Closed = function() 
    nosave()
    StopfaceCam()
end]]

barber.EnableMouse = true;
barbe.Closable = false;
barbe.EnableMouse = true;
cheveux.Closable = false;
cheveux.EnableMouse = true;
sourcils.Closable = false;
sourcils.EnableMouse = true;
--lips.Closable = false;
--lips.EnableMouse = true;

    CreateFaceCam(heading)
    if BarberMenu then
        BarberMenu = false
    else
        BarberMenu = true
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(barber, true)
        Citizen.CreateThread(function()
            while BarberMenu do
                DisableAllControlActions(0)
            
                
                 
                Citizen.Wait(1)
                RageUI.IsVisible(barber, function()
                     
                    
                    RageUI.Button("Cheveux", "Choisis ta coupe de cheveux", {}, true, {}, cheveux)
                    RageUI.Button("Barbe", "Choisis ta barbe", {}, true, {}, barbe)
                    RageUI.Button("Sourcils", "Choisis ta barbe", {}, true, {}, sourcils)
                    --RageUI.Button("Rouge a levres", "Choisis ton rouge a levre", {}, true, {}, lips)
                    --[[RageUI.List("Lentilles",LentillesList, Lentillesindex,nil,{},true,{
                        onActive = function()
                            CreateFaceCam()
                        end,
                        onListChange = function(Index, Item)
                            Lentillesindex = Index
                            TriggerEvent("skinchanger:change", "eye_color", Lentillesindex)
                        end
                    })]]
                    


                end)
                RageUI.IsVisible(barbe, function()
                    RageUI.List('Barbe', BarbeListe, MenuList.List1, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List1 = i;
                            TriggerEvent("skinchanger:change", "beard_1", MenuList.List1 - 1)
                        end
                    })

                    RageUI.ColourPanel("Couleur Barbes", RageUI.PanelColour.HairCut, SettingsMenu.ColorBeard.primary[1], SettingsMenu.ColorBeard.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorBeard.primary[1] = MinimumIndex
                            SettingsMenu.ColorBeard.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3",SettingsMenu.ColorBeard.primary[2])
                        end
                    }, 1);

                    RageUI.PercentagePanel(SettingsMenu.percentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            SettingsMenu.percentage = Percentage
                            TriggerEvent("skinchanger:change", "beard_2", Percentage * 10)
                        end
                    }, 1);
                    RageUI.Button("Confirmer", nil, {Color = {BackgroundColor = {0, 255, 0, 30}}, RightLabel = Price..'$'}, true, {
                        onSelected = function()
                            TriggerServerEvent('esx_barbershop:valider')
                            BarberMenu = false
                            StopfaceCam()
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    }) 

                    RageUI.Button("Retour", nil, {Color = {BackgroundColor = {255, 0, 0, 30}}}, true, {
                        onSelected = function()
                            BarberMenu = false 
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false)
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                BarberMenu = false
                                StopfaceCam()
                                FreezeEntityPosition(PlayerPedId(), false)
                            end)
                        end
                    })

                end)
                RageUI.IsVisible(cheveux, function()
                    RageUI.List('Cheveux', CheveuxListe, MenuList.List, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List = i;
                            TriggerEvent("skinchanger:change", "hair_1",MenuList.List - 1)
                        end
                    })

                    RageUI.ColourPanel("Couleur cheveux", RageUI.PanelColour.HairCut, SettingsMenu.ColorHear.primary[1], SettingsMenu.ColorHear.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorHear.primary[1] = MinimumIndex
                            SettingsMenu.ColorHear.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1", SettingsMenu.ColorHear.primary[2])
                        end
                    }, 1);

                    RageUI.ColourPanel("Couleur cheveux", RageUI.PanelColour.HairCut, SettingsMenu.ColorHear.secondary[1], SettingsMenu.ColorHear.secondary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorHear.secondary[1] = MinimumIndex
                            SettingsMenu.ColorHear.secondary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_2", SettingsMenu.ColorHear.secondary[2])
                        end
                    }, 1);
                    RageUI.Button("Confirmer", nil, {Color = {BackgroundColor = {0, 255, 0, 30}}, RightLabel = Price..'$'}, true, {
                        onSelected = function()
                            TriggerServerEvent('esx_barbershop:valider', Price)
                            BarberMenu = false
                            StopfaceCam()
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    }) 

                    RageUI.Button("Retour", nil, {Color = {BackgroundColor = {255, 0, 0, 30}}}, true, {
                        onSelected = function()
                            BarberMenu = false 
                            BarberMenu = false
                            FreezeEntityPosition(PlayerPedId(), false)
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                SetPedHairColor(playerPed, haircolor1, haircolor2)
                                BarberMenu = false
                                StopfaceCam()
                                FreezeEntityPosition(PlayerPedId(), false)
                            end)
                        end
                    })

                end)
                RageUI.IsVisible(sourcils, function()
                    RageUI.List('Sourcils', SourcilsListe, MenuList.List2, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List2 = i;
                            TriggerEvent("skinchanger:change", "eyebrows_1", MenuList.List2)
                        end
                    })

                    RageUI.ColourPanel("Couleur Sourcils", RageUI.PanelColour.HairCut, SettingsMenu.ColorBrow.primary[1], SettingsMenu.ColorBrow.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorBrow.primary[1] = MinimumIndex
                            SettingsMenu.ColorBrow.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "eyebrows_3", SettingsMenu.ColorBrow.primary[2])
                        end
                    }, 1);

                    RageUI.PercentagePanel(SettingsMenu.percentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            SettingsMenu.percentage = Percentage
                            TriggerEvent("skinchanger:change", "eyebrows_2", Percentage * 10)
                        end
                    }, 1);
                    RageUI.Button("Confirmer", nil, {Color = {BackgroundColor = {0, 255, 0, 30}}, RightLabel = Price..'$'}, true, {
                        onSelected = function()
                            TriggerServerEvent('esx_barbershop:valider')
                            BarberMenu = false
                            StopfaceCam()
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    }) 

                    RageUI.Button("Retour", nil, {Color = {BackgroundColor = {255, 0, 0, 30}}}, true, {
                        onSelected = function()
                            BarberMenu = false 
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false)
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                BarberMenu = false
                                StopfaceCam()
                                FreezeEntityPosition(PlayerPedId(), false)
                            end)
                        end
                    })
                end)
                --[[RageUI.IsVisible(lips, function()
                    RageUI.List("Rouge a levre",LipsListe, LipsIndex,nil,{},true,{
                        onListChange = function(Index, Item)
                            LipsIndex = Index
                            TriggerEvent("skinchanger:change", "lipstick_1", LipsIndex)
                        end
                    })
                    RageUI.PercentagePanel(CouleurRougeLevre.OpaPercent, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            CouleurRougeLevre.OpaPercent = Percentage
                            TriggerEvent('skinchanger:change', 'lipstick_2',Percentage*10)
                        end
                    }, 1) 
        
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut,  CouleurRougeLevre.Primaire[1], CouleurRougeLevre.Primaire[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            CouleurRougeLevre.Primaire[1] = MinimumIndex
                            CouleurRougeLevre.Primaire[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_3",  CouleurRougeLevre.Primaire[2])
                        end
                    }, 1)
        
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, CouleurRougeLevre.Secondaire[1], CouleurRougeLevre.Secondaire[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            CouleurRougeLevre.Secondaire[1] = MinimumIndex
                            CouleurRougeLevre.Secondaire[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_4", Barber.CouleurRougeLevre.Secondaire[2])
                        end
                    }, 1)
                    RageUI.Button("Confirmer", nil, {Color = {BackgroundColor = {0, 255, 0, 30}}, RightLabel = "~r~"}, true, {
                        onSelected = function()
                            TriggerServerEvent('esx_barbershop:valider')
                        end
                    }) 

                    RageUI.Button("Retour", nil, {Color = {BackgroundColor = {255, 0, 0, 30}}}, true, {
                        onSelected = function()
                            BarberMenu = false 
                            RageUI.CloseAll()
                            FreezeEntityPosition(PlayerPedId(), false)
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                SetPedHeadOverlay(playerPed, 1, overlayValuelip, overlayOpacitylip)
                                StopfaceCam()
                            end)
                        end
                    })
                end)--]]
            end
        end)
    end
end

CreateThread(function()
    while true do
        local ms = 500
        for k, v in pairs(Config.Barbers) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local position = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
            local distance = #(position - playerCoords)
            PlayerGarage = {}
            danszone = false
            if distance <= 5 then
                ms = 0
                DrawMarker(1, v.Pos.x, v.Pos.y, v.Pos.z - 1.1 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 0.3, 240.0, 240.0, 240.0, 50, false, true, 2, true, false, false, false)
                if distance <= 1.3 then 
                    ESX.ShowHelpNotification('Appuyer ~INPUT_CONTEXT~ parler vous ~o~ coiffer')
                    if IsControlJustPressed(0, 51) --[[and menuState == false]] then
                        OpenMenuBarber(v.Pos.w, v.Price, v.type)
                    end
                end
           
            end

        end
        Wait(ms)
    end
 
end)





