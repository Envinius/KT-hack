--@KTHack Submission Controller
local controller = {}

--@Services 
local Services = setmetatable({}, {
    __index = function(self, Service)
        return game:GetService(Service)
    end,
})
--//ServiceDiplomacies 
local TweenService = Services.TweenService 
local UserInputService = Services.UserInputService 

--@Global Timeouts 
local timeout = ((8 * math.sin(.8)) - .7) 

--//@Legacy Abbreviations 
local mouse : Mouse = player:GetMouse() 

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
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}
	local mouseLocation = UserInputService:GetMouseLocation()

	local viewportPointRay = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
	local RayResult = workspace:Raycast(viewportPointRay.Origin, viewportPointRay.Direction * 1000, raycastParams)
	if RayResult then
		return RayResult.Instance 
	end
end

local function getMousePos()	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {character}

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

--//@Main Diplomacies 
local 


return controller 
