--<-.(`-')               _                         <-. (`-')_  (`-')  _                          (`-')              _           (`-') (`-')  _ _(`-')    (`-')  _      (`-')
-- __( OO)      .->     (_)        .->                \( OO) ) ( OO).-/    <-.          .->   <-.(OO )     <-.     (_)         _(OO ) ( OO).-/( (OO ).-> ( OO).-/     _(OO )
--'-'---.\  ,--.'  ,-.  ,-(`-') ,---(`-')  .----.  ,--./ ,--/ (,------. (`-')-----.(`-')----. ,------,) (`-')-----.,-(`-'),--.(_/,-.\(,------. \    .'_ (,------.,--.(_/,-.\
--| .-. (/ (`-')'.'  /  | ( OO)'  .-(OO ) /  ..  \ |   \ |  |  |  .---' (OO|(_\---'( OO).-.  '|   /`. ' (OO|(_\---'| ( OO)\   \ / (_/ |  .---' '`'-..__) |  .---'\   \ / (_/
--| '-' `.)(OO \    /   |  |  )|  | .-, \|  /  \  .|  . '|  |)(|  '--.   / |  '--. ( _) | |  ||  |_.' |  / |  '--. |  |  ) \   /   / (|  '--.  |  |  ' |(|  '--.  \   /   / 
--| /`'.  | |  /   /)  (|  |_/ |  | '.(_/'  \  /  '|  |\    |  |  .--'   \_)  .--'  \|  |)|  ||  .   .'  \_)  .--'(|  |_/ _ \     /_) |  .--'  |  |  / : |  .--' _ \     /_)
--| '--'  / `-/   /`    |  |'->|  '-'  |  \  `'  / |  | \   |  |  `---.   `|  |_)    '  '-'  '|  |\  \    `|  |_)  |  |'->\-'\   /    |  `---. |  '-'  / |  `---.\-'\   /   
--`------'    `--'      `--'    `-----'    `---''  `--'  `--'  `------'    `--'       `-----' `--' '--'    `--'    `--'       `-'     `------' `------'  `------'    `-'    
local stores = {
	["paleto_twentyfourseven"] = {
		position = { ['x'] = 1736.32092285156, ['y'] = 6419.4970703125, ['z'] = 35.037223815918 },
		reward = math.random(1000,20000),
		nameofstore = "Twenty Four Seven. (Paleto Bay)",
		lastrobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { ['x'] = 1961.24682617188, ['y'] = 3749.46069335938, ['z'] = 32.3437461853027 },
		reward = math.random(1000,20000),
		nameofstore = "Twenty Four Seven. (Sandy Shores)",
		lastrobbed = 0
	},
	["bar_one"] = {
		position = { ['x'] = 1986.1240234375, ['y'] = 3053.8747558594, ['z'] = 47.215171813965 },
		reward = math.random(1000,20000),
		nameofstore = "Yellow Jack. (Sandy Shores)",
		lastrobbed = 0
	},
	["ocean_liquor"] = {
		position = { ['x'] = -2959.33715820313, ['y'] = 388.214172363281, ['z'] = 14.0432071685791 },
		reward = math.random(1000,20000),
		nameofstore = "Robs Liquor. (Great Ocean Higway)",
		lastrobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { ['x'] = -1219.85607910156, ['y'] = -916.276550292969, ['z'] = 11.3262157440186 },
		reward = math.random(1000,20000),
		nameofstore = "Robs Liquor. (San andreas Avenue)",
		lastrobbed = 0
	},
	["grove_ltd"] = {
		position = { ['x'] = -43.4035377502441, ['y'] = -1749.20922851563, ['z'] = 29.421012878418 },
		reward = math.random(1000,20000),
		nameofstore = "LTD Gasoline. (Grove Street)",
		lastrobbed = 0
	},
	["mirror_ltd"] = {
		position = { ['x'] = 1160.67578125, ['y'] = -314.400451660156, ['z'] = 69.2050552368164 },
		reward = math.random(1000,20000),
		nameofstore = "LTD Gasoline. (Mirror Park Boulevard)",
		lastrobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
		reward = math.random(1000,20000),
		nameofstore = "Twenty Four Seven. (Little Seoul)",
		lastrobbed = 0
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdup:toofar')
AddEventHandler('esx_holdup:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('esx_holdup:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, '~r~ Le braquage à été annulé: ~g~' .. stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_holdup:rob')
AddEventHandler('esx_holdup:rob', function(robb)
	
	if stores[robb] then
		local store = stores[robb]

		if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', source, 'Ce magasin a déjà été braqué. Veuillez attendre: ' .. (1800 - (os.time() - store.lastrobbed)) .. "seconds.")
			return
		end
		
		local cops = 0
		TriggerEvent('esx:getPlayers', function(xPlayers)
			for k, v in pairs(xPlayers) do
				if v.job.name == 'cop' then
					cops = cops + 1
				end
			end
		end)
						
		if(cops > 1)then
				TriggerEvent('esx:getPlayers', function(xPlayers)
						for k, v in pairs(xPlayers) do
							if v.job.name == 'cop' then
								TriggerClientEvent('esx:showNotification', k, '~r~ Braquage en cours à: ~g~' .. store.nameofstore)
							end
						end
					end)
				TriggerClientEvent('esx:showNotification', source, 'Vous avez commencé à braquer ' .. store.nameofstore .. ', ne vous éloignez pas!')
				TriggerClientEvent('esx:showNotification', source, 'L\'alarme à été déclenché ')
				TriggerClientEvent('esx:showNotification', source, 'Tenez la position pendant 2min et l\'argent est à vous! ')
				TriggerClientEvent('esx_holdup:currentlyrobbing', source, robb)
				stores[robb].lastrobbed = os.time()
				robbers[source] = robb
				local savedSource = source
				SetTimeout(120000, function()
					if(robbers[savedSource])then
						TriggerClientEvent('esx_holdup:robberycomplete', savedSource, job)
						TriggerEvent('esx:getPlayerFromId', source, function(xPlayer) 
							if(xPlayer)then 
							xPlayer:addAccountMoney('black_money', store.reward)
							TriggerClientEvent('esx:showNotification', source, '~r~ Braquage terminé.~s~ ~h~ Fuie!')
							TriggerEvent('esx:getPlayers', function(xPlayers)
								for k, v in pairs(xPlayers) do
									if v.job.name == 'cop' then
										TriggerClientEvent('esx:showNotification', k, '~r~ Braquage terminé à: ~g~' .. store.nameofstore)
									end
								end
							end)
						end
					end)
				end
			end)
		else
			TriggerClientEvent('esx:showNotification', source, 'Il faut minimum 1 policier connecté pour braquer.')
		end				
	end
end)
