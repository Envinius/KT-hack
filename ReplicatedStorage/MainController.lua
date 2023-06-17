--@KTHack Submission Controller
local controller = {}

--@Services 
local Services = setmetatable({}, {
	__index = function(self, Service)
		return game:GetService(Service)
	end,
})
--//ServiceDiplomacies 
local TweenService, Tweens = Services.TweenService, Services.TweenService 
local UserInputService = Services.UserInputService 

--@Global Timeouts 
local timeout = ((8 * math.sin(.8)) - .7) 

--//@Legacy Abbreviations 
local mouse : Mouse = game.Players.LocalPlayer:GetMouse() 
local camera = workspace.CurrentCamera

--//@Local Functions 
local function zoomCam(amount : number , duration : number) 
	local tween = Tweens:Create(
		camera,
		(TweenInfo.new)(duration), 
		{FieldOfView = amount}
	)
	tween:Play() 
	task.delay(duration - -(math.cos(10)), tween.Destroy, tween) 
end

local function TweenBase(instance : any, durationid : number, prop : string, value : any)
	local tween = Tweens:Create(
		instance, 
		TweenInfo.new(durationid), 
		{[prop] = value}
	)
	tween:Play() 
	task.delay(durationid + .5, tween.Destroy, tween)
end

local function getMouseHit()
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
	local mouseLocation = UserInputService:GetMouseLocation()

	local viewportPointRay = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local RayResult = workspace:Raycast(viewportPointRay.Origin, viewportPointRay.Direction * 1000, raycastParams)
	if RayResult then
		return RayResult.Instance 
	end
end

local function getMousePos()	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}

	local mouseLocation = UserInputService:GetMouseLocation()
	local viewportPointRay = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local RayResult = workspace:Raycast(viewportPointRay.Origin, viewportPointRay.Direction * 1000, raycastParams)
	if RayResult then
		return RayResult.Position
	end
	--//Shift/Viewport Ray @: return nil, (viewportPointRay.Origin + viewportPointRay.Direction * 1000)
end


local CameraShaker = require(game:GetService('ReplicatedStorage'):WaitForChild("CameraShaker"));
local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
	camera.CFrame = camera.CFrame * shakeCf
end)
camShake:Start()
--camShake:Shake(CameraShaker.Presets[Arg])


--//@Client Module Identifiers  

function controller.SetupQueries() 
	--/Character Dependencies 
	local player = game.Players.LocalPlayer 
	local character = player.Character or player.CharacterAdded:Wait() 

	--/Local Dependencies 

	--[[ Interfacing ]] -- 
	local Gui = player.PlayerGui:WaitForChild("InputQuestionsGui", timeout)
	local Frame = Gui.MainFrame 
	local Input = Frame.Input 
	local Submit = Frame.Submit 

	-- [[ Titles ]] -- 
	local Title = Frame.Title 
	local TitleTwo = Frame.TitleTwo 

	-- [[ Answers ]] --
	local Answers = Frame.Answers 
	local AnswerOne = Answers.AnswerOne
	local AnswerTwo = Answers.AnswerTwo
	local AnswerThree = Answers.AnswerThree
	local AnswerFour = Answers.AnswerFour
	

	for _,v in(Frame:GetDescendants()) do 
		if v:IsA("TextButton") or v:IsA("TextLabel") then 
			v:SetAttribute("BackgroundTransparency", v.BackgroundTransparency)
			-- 
			v.TextTransparency = 1 
			v.BackgroundTransparency = 1 
		elseif v:IsA("TextBox") then 
			v:SetAttribute("BackgroundTransparency", v.BackgroundTransparency)
			-- 
			v.TextTransparency = 1 
		end
	end
	

	for _,v in(Frame:GetDescendants()) do 
		if v:IsA("TextButton") or v:IsA("TextLabel") then 
			TweenBase(v, 1, "TextTransparency", 0)
			
			if v:GetAttribute("BackgroundTransparency") then 
				TweenBase(v, 1, "BackgroundTransparency", v:GetAttribute("BackgroundTransparency"))
			else 
				TweenBase(v, 1, "BackgroundTransparency", 0)
			end
			--
		elseif v:IsA("TextBox") then 
			TweenBase(v, 1, "TextTransparency", 0)
			
			if v:GetAttribute("BackgroundTransparency") then 
				TweenBase(v, 1, "BackgroundTransparency", v:GetAttribute("BackgroundTransparency"))
			else 
				TweenBase(v, 1, "BackgroundTransparency", 0)
			end
			--
		end
	end
	
end 

function controller:AddQuery() 
	--/Character Dependencies 
	local player = game.Players.LocalPlayer 
	local character = player.Character or player.CharacterAdded:Wait() 

	--/Local Dependencies 

	--[[ Interfacing ]] -- 
	local Gui = player.PlayerGui:WaitForChild("InputQuestionsGui", timeout)
	local Frame = Gui.MainFrame 
	local Input = Frame.Input 
	local Submit = Frame.Submit 

	-- [[ Titles ]] -- 
	local Title = Frame.Title 
	local TitleTwo = Frame.TitleTwo 

	-- [[ Answers ]] --
	local Answers = Frame.Answers 
	local AnswerOne = Answers.AnswerOne
	local AnswerTwo = Answers.AnswerTwo
	local AnswerThree = Answers.AnswerThree
	local AnswerFour = Answers.AnswerFour
	

	local function CheckAnswers() 
		local blank = false 
		
		--[[ Check Blanks ]]--
		if AnswerOne.Text == "" then 
			blank = true 
		end
		if AnswerTwo.Text == "" then 
			blank = true 
		end
		if AnswerThree.Text == "" then 
			blank = true 
		end
		if AnswerFour.Text == "" then 
			blank = true 
		end
		return blank 
	end 
	


	
	local debounce = false 
	Submit.Activated:Connect(function()
		if not debounce then
			debounce = true 
			
			
			
			
		end
	end)
	
end



return controller 
