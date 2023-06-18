local Controller = require(game.ReplicatedStorage.MainController)
local remote = game.ReplicatedStorage.MainController.Remote

Controller.ServerAdapter()

game.Players.PlayerAdded:Connect(function(player)
	local fold = game.ReplicatedStorage.MainController.Questions:GetChildren()
	local random = math.random(1, #fold)
	local question = fold[random]
	
	task.wait(1)
	--Controller:QueryPlayer(player, question.Name)
end)


