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

--[[
local CameraShaker = require(game:GetService('ReplicatedStorage'):WaitForChild("CameraShaker"));
local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
	camera.CFrame = camera.CFrame * shakeCf
end)
camShake:Start()
--camShake:Shake(CameraShaker.Presets[Arg])
]]

--//@Client Module Identifiers  

function controller.SetupQueries() 
	--/Character Dependencies 
	local player = game.Players.LocalPlayer 
	local character = player.Character or player.CharacterAdded:Wait() 

	--/Local Dependencies 

	--[[ Interfacing ]] -- 
	local Gui = player.PlayerGui:WaitForChild("InputQuestionsGui", timeout)
	Gui.Enabled = true 

	local Frame = Gui.MainFrame 
	local Input = Frame.Input 
	local Submit = Frame.Submit 
	local Finish = Frame.Finish 
	local Questions = Frame.Questions 

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
	local Finish = Frame.Finish 
	local Questions = Frame.Questions 
	
	-- [[ Titles ]] -- 
	local Title = Frame.Title 
	local TitleTwo = Frame.TitleTwo 

	-- [[ Answers ]] --
	local Answers = Frame.Answers 
	local AnswerOne = Answers.AnswerOne
	local AnswerTwo = Answers.AnswerTwo
	local AnswerThree = Answers.AnswerThree
	local AnswerFour = Answers.AnswerFour

	local debounce = false 

	local function CheckAnswers() 
		local blank = true 

		--[[ Check Blanks ]]--
		if AnswerOne.Text == "" then 
			blank = false 
		end
		if AnswerTwo.Text == "" then 
			blank = false 
		end
		if AnswerThree.Text == "" then 
			blank = false 
		end
		if AnswerFour.Text == "" then 
			blank = false 
		end
		return blank 
	end 

	if not debounce then
		debounce = true 

		if Input.Text == "" then 
			TitleTwo.Text = "Make sure your question isn't blank."
			TitleTwo.TextColor3 = Color3.fromRGB(255, 111, 111)

			task.delay(1, function() 
				TitleTwo.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTwo.Text = "Enter your answers to the question, make the first one correct." 
			end)
		else 
			local pass = CheckAnswers()
			if not pass then 
				TitleTwo.Text = "Make sure your answers are not blank."
				TitleTwo.TextColor3 = Color3.fromRGB(255, 111, 111)
				task.delay(1, function() 
					TitleTwo.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTwo.Text = "Enter your answers to the question, make the first one correct." 
				end)
			else 
				--/Assume that all of them are not blank 
				local Question = Instance.new("Folder")
				Question.Parent = game.ReplicatedStorage.MainController.Questions
				Question.Name = Input.Text 

				--[[ Create Answers for the questions ]] --  
				local Answer1 = Instance.new("BoolValue")
				Answer1.Parent = Question 
				Answer1.Name = AnswerOne.Text 
				Answer1.Value = true 
				-- 
				local Answer2 = Instance.new("BoolValue")
				Answer2.Parent = Question 
				Answer2.Name = AnswerTwo.Text 
				Answer2.Value = false 
				-- 
				local Answer3 = Instance.new("BoolValue")
				Answer3.Parent = Question 
				Answer3.Name = AnswerThree.Text
				Answer3.Value = false  
				-- 
				local Answer4 = Instance.new("BoolValue")
				Answer4.Parent = Question
				Answer4.Name = AnswerFour.Text
				Answer4.Value = false 

				TitleTwo.Text = "Question successfully created!"
				TitleTwo.TextColor3 = Color3.fromRGB(134, 255, 134)

				TweenBase(AnswerOne, 1, "TextTransparency", 1)
				TweenBase(AnswerTwo, 1, "TextTransparency", 1)
				TweenBase(AnswerThree, 1, "TextTransparency", 1)
				TweenBase(AnswerFour, 1, "TextTransparency", 1)
				TweenBase(Input, 1, "TextTransparency", 1)
				
				if #game.ReplicatedStorage.MainController.Questions:GetChildren() == 1 then 
					Questions.Text = #game.ReplicatedStorage.MainController.Questions:GetChildren() .. " question made."
				else 
					Questions.Text = #game.ReplicatedStorage.MainController.Questions:GetChildren() .. " questions made."
				end
				task.delay(1, function() 
					
					AnswerOne.Text = ""
					AnswerTwo.Text = ""
					AnswerThree.Text = ""
					AnswerFour.Text = ""
					Input.Text = ""
					-- [[ Restart ]] --
					TweenBase(Input, 1, "TextTransparency", 0)

					TweenBase(AnswerOne, 1, "TextTransparency", 0)
					TweenBase(AnswerTwo, 1, "TextTransparency", 0)
					TweenBase(AnswerThree, 1, "TextTransparency", 0)
					TweenBase(AnswerFour, 1, "TextTransparency", 0)
					
					TweenBase(TitleTwo, 1, "TextTransparency", 1)
					task.delay(1, function() 
						TweenBase(TitleTwo, 1, "TextTransparency", 0)
						TitleTwo.TextColor3 = Color3.fromRGB(255, 255, 255)
						TitleTwo.Text = "Enter your answers to the question, make the first one correct." 
					end)
				end) 

			end
		end
	end

end



return controller 
