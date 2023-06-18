local Controller = require(game.ReplicatedStorage.MainController)
local remote = game.ReplicatedStorage.MainController.Remote

Controller.ServerAdapter()

local e = 0 

game.Players.PlayerAdded:Connect(function(player)
	if e == 0 then 
		e = 1
		player:SetAttribute("Host", true)
		task.wait(5)
		remote:FireAllClients("SendNotification", player.Name .. " is the host", "Host")
		remote:FireClient(player, "EnableHostGui")
		
		player.CharacterAdded:Connect(function(char)
			if player:GetAttribute("Host") then 
				remote:FireClient(player, "EnableHostGui")
			end
		end)
		
	end
end)


game.Players.PlayerRemoving:Connect(function(player)
	if player:GetAttribute("Host") then 
		local fold = game.Players:GetChildren()
		local random = math.random(1, #fold)
		local chosen = fold[random]
		
		chosen:SetAttribute("Host", true)
		remote:FireAllClients("SendNotification", chosen.Name .. " is now the new host", "Host changed")
	end
end)

