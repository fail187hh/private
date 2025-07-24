local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AOD-RuRu/AoD/refs/heads/main/uiUI", true))()

local window = library:AddWindow("157 Private", {
    main_color = Color3.fromRGB(0,0,0),
    min_size = Vector2.new(580,630),
    can_resize = false,
})

for _, portal in pairs(game:GetDescendants()) do
	if portal.Name == "RobloxForwardPortals" then
		portal:Destroy()
	end
end

game.DescendantAdded:Connect(function(descendant)
	if descendant.Name == "RobloxForwardPortals" then
		descendant:Destroy()
	end
end)

local automationTab = window:AddTab("Automation")

automationTab:AddLabel("Settings").TextSize = 25

local walkSpeedValue = 16
automationTab:AddTextBox("Speed", function(text)
    local speed = tonumber(text)
    if speed and speed >= 1 and speed <= 500 then
        walkSpeedValue = speed
    end
end)

local setSpeed = false
automationTab:AddSwitch("Set", function(state)
    setSpeed = state
    while setSpeed do
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedValue
        task.wait(0.1)
    end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

automationTab:AddTextBox("Size", function(text)
setsize = text
end)

automationTab:AddSwitch("Set", function(state)
 getgenv().ss = state
    while getgenv().ss do
        wait()
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(setsize))
        end
    end
end)

automationTab:AddLabel("")

automationTab:AddLabel("Misc").TextSize = 25

automationTab:AddTextBox("Camera Zoom", function(text)
local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character.Humanoid.CameraMaxZoomDistance = text
    end
end)

automationTab:AddSwitch("Music", function(state)
if state then
			local sound = Instance.new("Sound")
			sound.Name = "BackgroundMusic"
			sound.SoundId = "rbxassetid://5410083226"
			sound.Volume = 1
			sound.Looped = true
			sound.Parent = game.Workspace
			sound:Play()
		else
			if game.Workspace:FindFirstChild("BackgroundMusic") then
				game.Workspace.BackgroundMusic:Destroy()
			end
		end
end)

automationTab:AddSwitch("Show Pets", function(State)
if State then
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("hidePets")
    else
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("showPets")
    end
end)

automationTab:AddSwitch("Show Other Pets", function(State)
if State then
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("hidePets")
    else
        game:GetService("ReplicatedStorage").rEvents.showPetsEvent:FireServer("showPets")
    end
end)

automationTab:AddSwitch("Disable Trade", function(State)
if State then
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("disableTrading")
    else
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("enableTrading")
    end
end)

local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)
 
local function createParts()
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local newPartSide = Instance.new("Part")
            newPartSide.Size = Vector3.new(partSize, 1, partSize)
            newPartSide.Position = startPosition + Vector3.new(x * partSize, 0, z * partSize)
            newPartSide.Anchored = true
            newPartSide.Transparency = 1
            newPartSide.CanCollide = true
            newPartSide.Name = "Part_Side_" .. x .. "_" .. z
            newPartSide.Parent = workspace
            table.insert(parts, newPartSide)
 
            local newPartLeftRight = Instance.new("Part")
            newPartLeftRight.Size = Vector3.new(partSize, 1, partSize)
            newPartLeftRight.Position = startPosition + Vector3.new(-x * partSize, 0, z * partSize)
            newPartLeftRight.Anchored = true
            newPartLeftRight.Transparency = 1
            newPartLeftRight.CanCollide = true
            newPartLeftRight.Name = "Part_LeftRight_" .. x .. "_" .. z
            newPartLeftRight.Parent = workspace
            table.insert(parts, newPartLeftRight)
 
            local newPartUpLeft = Instance.new("Part")
            newPartUpLeft.Size = Vector3.new(partSize, 1, partSize)
            newPartUpLeft.Position = startPosition + Vector3.new(-x * partSize, 0, -z * partSize)
            newPartUpLeft.Anchored = true
            newPartUpLeft.Transparency = 1
            newPartUpLeft.CanCollide = true
            newPartUpLeft.Name = "Part_UpLeft_" .. x .. "_" .. z
            newPartUpLeft.Parent = workspace
            table.insert(parts, newPartUpLeft)
 
            local newPartUpRight = Instance.new("Part")
            newPartUpRight.Size = Vector3.new(partSize, 1, partSize)
            newPartUpRight.Position = startPosition + Vector3.new(x * partSize, 0, -z * partSize)
            newPartUpRight.Anchored = true
            newPartUpRight.Transparency = 1
            newPartUpRight.CanCollide = true
            newPartUpRight.Name = "Part_UpRight_" .. x .. "_" .. z
            newPartUpRight.Parent = workspace
            table.insert(parts, newPartUpRight)
        end
    end
end
 
local function makePartsWalkthrough()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = false
        end
    end
end
 
local function makePartsSolid()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = true
        end
    end
end

automationTab:AddSwitch("Walk On Water", function(state)
    if state then
        createParts()
    else
        makePartsWalkthrough()
    end
end)

automationTab:AddSwitch("Anti AFK", function(state)
    if state then
loadstring(game:HttpGet("https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk", true))()
    end
end)

automationTab:AddSwitch("Inf Jump", function(bool)
    _G.InfiniteJump = bool
 
    if bool then
        local InfiniteJumpConnection
        InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
	
            if _G.InfiniteJump then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            else
			
                InfiniteJumpConnection:Disconnect()
            end
       end)
	   end
end)

automationTab:AddLabel("")

automationTab:AddLabel("Protection").TextSize = 25

automationTab:AddSwitch("Anti Fling", function(bool)
if bool then
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.P = 1250
        bodyVelocity.Parent = rootPart
    else
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
        if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
            existingVelocity:Destroy()
        end
    end
end)

automationTab:AddSwitch("Position Lock", function(Value)
if Value then
        -- Lock Position
        local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)
    else
        -- Unlock Position
        if getgenv().posLock then
            getgenv().posLock:Disconnect()
            getgenv().posLock = nil
        end
    end
end)

automationTab:AddButton("Block Rebirths", function()
local OldNameCall = nil
    OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
        local Args = {
            ...
        }
        if self.Name == "rebirthRemote" and Args[1] == "rebirthRequest" then
            return
        end
        return OldNameCall(self, unpack(Args))
    end)
end)

automationTab:AddButton("Block Trades", function()
game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("disableTrading")
end)

local killerTab = window:AddTab("Killing")

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

local function checkCharacter()
    if not game.Players.LocalPlayer.Character then
        repeat
            task.wait()
        until game.Players.LocalPlayer.Character
    end
    return game.Players.LocalPlayer.Character
end

local function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function killPlayer(target)
    local character = checkCharacter()
    if character and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        if character:FindFirstChild("LeftHand") then
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
            firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
            gettool()
        end
    end
end

local function findClosestPlayer(input)
    if not input or input == "" then return nil end
    
    input = input:lower()
    local bestMatch = nil
    local bestScore = 0
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local username = player.Name:lower()
            local displayName = player.DisplayName:lower()
            
            local usernameMatch = username:find(input, 1, true) ~= nil
            local displayMatch = displayName:find(input, 1, true) ~= nil
            
            local usernameScore = 0
            local displayScore = 0
            
            if usernameMatch then
                usernameScore = (#input / #username) * 100
                if username:sub(1, #input) == input then
                    usernameScore = usernameScore + 50
                end
            end
            
            if displayMatch then
                displayScore = (#input / #displayName) * 100
                if displayName:sub(1, #input) == input then
                    displayScore = displayScore + 50
                end
            end
            
            local score = math.max(usernameScore, displayScore)
            
            if score > bestScore then
                bestScore = score
                bestMatch = player
            end
        end
    end
    
    if bestScore > 20 then
        return bestMatch
    end
    
    return nil
end

killerTab:AddLabel("Kill Aura").TextSize = 25

local killpetDropdown = killerTab:AddDropdown("Select Pet", function(selection)

end)

killpetDropdown:Add("Wild Wizard")
killpetDropdown:Add("Mighty Monster")

killerTab:AddSwitch("No Punch Animation", function(State)
    if State then
        game:GetService("Players").LocalPlayer.Backpack.Punch.RequiresHandle = true
    else
       game:GetService("Players").LocalPlayer.Backpack.Punch.RequiresHandle = false
    end
end)

killerTab:AddLabel("")

killerTab:AddTextBox("Whitelist", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
            
            local alreadyWhitelisted = false
            for _, info in ipairs(_G.whitelistedPlayers) do
                if info:find(player.Name, 1, true) then
                    alreadyWhitelisted = true
                    break
                end
            end
            
            if not alreadyWhitelisted then
                table.insert(_G.whitelistedPlayers, playerInfo)
                updateWhitelistedPlayersLabel()
            end
        end
    end
end)

local selectedPlayers = {}
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local isRunning = false
        local stepConnection
        local dropdown = nil
        
        local function updateDropdown(player)
            if dropdown then
                dropdown:Add(player.Name)
            end
        end
        
        local function removeDropdown(player)
            if dropdown then
                dropdown:Remove(player.Name)
            end
        end
        
        local function touchTargetHead(player)
            if player and player.Character then
                local targetHead = player.Character:FindFirstChild("Head")
                local localLeftHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("LeftHand")
                local localRightHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("RightHand")
        
                if targetHead and localLeftHand and localRightHand then
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                end
            end
        end
        
        local function main()
            for _, player in ipairs(selectedPlayers) do
                touchTargetHead(player)
            end
        end
        
        local function startCode()
            isRunning = true
            stepConnection = RunService.Stepped:Connect(main)
        end
        
        local function stopCode()
            isRunning = false
            if stepConnection then
                stepConnection:Disconnect()
            end
            selectedPlayers = {}
            if dropdown then
                dropdown:ClearSelection()
            end
        end

local selectedPlayers = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local isRunning = false
local stepConnection
local dropdown = nil
local autokillplayerlocal = false

local function updateDropdown(player)
    if dropdown then
        dropdown:Add(player.Name)
    end
end

local function removeDropdown(player)
    if dropdown then
        dropdown:Remove(player.Name)
    end
end

local function touchTargetHead(player)
    if player and player.Character then
        local charkterkiller = player.Character
        local mycharacter = Players.LocalPlayer.Character

        if charkterkiller and mycharacter then
            pcall(function()
                charkterkiller.Head.Anchored = true
                charkterkiller.Head.CanCollide = false

                pcall(function()
                    if charkterkiller.Head.Neck.Name == "Neck" and charkterkiller.Head.nameGui then
                        charkterkiller.Head.nameGui:Clone().Parent = charkterkiller.UpperTorso
                        charkterkiller.Head.Neck:Destroy()
                        charkterkiller.Head.nameGui:Destroy()
                        charkterkiller.Head.Transparency = 1
                        charkterkiller.Head.Face:Destroy()
                    end
                end)

                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Punch"))
                local args = {
                    [1] = "punch",
                    [2] = "rightHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    
                local args = {
                    [1] = "punch",
                    [2] = "leftHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

                    wait()
                    charkterkiller.Head.Position = Vector3.new(mycharacter.LeftHand.Position.X, mycharacter.LeftHand.Position.Y, mycharacter.LeftHand.Position.Z)
                end)
            end)
        end
    end
end

local function main()
    if autokillplayerlocal then
        for _, player in ipairs(selectedPlayers) do
            touchTargetHead(player)
        end
    end
end

local function startCode()
    isRunning = true
    autokillplayerlocal = true
    stepConnection = RunService.Stepped:Connect(main)
end

local function stopCode()
    isRunning = false
    autokillplayerlocal = false
    if stepConnection then
        stepConnection:Disconnect()
    end
    selectedPlayers = {}
    if dropdown then
        dropdown:ClearSelection()
    end
end

Players.PlayerAdded:Connect(function(player)
    updateDropdown(player)
    dropdown:ClearOptions()
    for _, p in ipairs(Players:GetPlayers()) do
        dropdown:AddOption(p.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeDropdown(player)
end)

dropdown = killerTab:AddDropdown("Whitelist", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
            
            local alreadyWhitelisted = false
            for _, info in ipairs(_G.whitelistedPlayers) do
                if info:find(player.Name, 1, true) then
                    alreadyWhitelisted = true
                    break
                end
            end
            
            if not alreadyWhitelisted then
                table.insert(_G.whitelistedPlayers, playerInfo)
                updateWhitelistedPlayersLabel()
            end
        end
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    updateDropdown(player)
end

killerTab:AddButton("Clear Whitelist", function()
    _G.whitelistedPlayers = {}
    updateWhitelistedPlayersLabel()
end)

local autoWhitelistFriendsSwitch = killerTab:AddSwitch("Whitelist Friends", function(bool)
    _G.autoWhitelistFriends = bool
    
    if bool then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
                if not table.find(_G.whitelistedPlayers, playerInfo) then
                    table.insert(_G.whitelistedPlayers, playerInfo)
                end
            end
        end
        updateWhitelistedPlayersLabel()
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    if _G.autoWhitelistFriends and player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
        local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
        if not table.find(_G.whitelistedPlayers, playerInfo) then
            table.insert(_G.whitelistedPlayers, playerInfo)
            updateWhitelistedPlayersLabel()
        end
    end
end)

killerTab:AddTextBox("Blacklist", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end
    end
end)

local selectedPlayers = {}
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local isRunning = false
        local stepConnection
        local dropdown = nil
        
        local function updateDropdown(player)
            if dropdown then
                dropdown:Add(player.Name)
            end
        end
        
        local function removeDropdown(player)
            if dropdown then
                dropdown:Remove(player.Name)
            end
        end
        
        local function touchTargetHead(player)
            if player and player.Character then
                local targetHead = player.Character:FindFirstChild("Head")
                local localLeftHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("LeftHand")
                local localRightHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("RightHand")
        
                if targetHead and localLeftHand and localRightHand then
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                end
            end
        end
        
        local function main()
            for _, player in ipairs(selectedPlayers) do
                touchTargetHead(player)
            end
        end
        
        local function startCode()
            isRunning = true
            stepConnection = RunService.Stepped:Connect(main)
        end
        
        local function stopCode()
            isRunning = false
            if stepConnection then
                stepConnection:Disconnect()
            end
            selectedPlayers = {}
            if dropdown then
                dropdown:ClearSelection()
            end
        end

local selectedPlayers = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local isRunning = false
local stepConnection
local dropdown = nil
local autokillplayerlocal = false

local function updateDropdown(player)
    if dropdown then
        dropdown:Add(player.Name)
    end
end

local function removeDropdown(player)
    if dropdown then
        dropdown:Remove(player.Name)
    end
end

local function touchTargetHead(player)
    if player and player.Character then
        local charkterkiller = player.Character
        local mycharacter = Players.LocalPlayer.Character

        if charkterkiller and mycharacter then
            pcall(function()
                charkterkiller.Head.Anchored = true
                charkterkiller.Head.CanCollide = false

                pcall(function()
                    if charkterkiller.Head.Neck.Name == "Neck" and charkterkiller.Head.nameGui then
                        charkterkiller.Head.nameGui:Clone().Parent = charkterkiller.UpperTorso
                        charkterkiller.Head.Neck:Destroy()
                        charkterkiller.Head.nameGui:Destroy()
                        charkterkiller.Head.Transparency = 1
                        charkterkiller.Head.Face:Destroy()
                    end
                end)

                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Punch"))
                local args = {
                    [1] = "punch",
                    [2] = "rightHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    
                local args = {
                    [1] = "punch",
                    [2] = "leftHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

                    wait()
                    charkterkiller.Head.Position = Vector3.new(mycharacter.LeftHand.Position.X, mycharacter.LeftHand.Position.Y, mycharacter.LeftHand.Position.Z)
                end)
            end)
        end
    end
end

local function main()
    if autokillplayerlocal then
        for _, player in ipairs(selectedPlayers) do
            touchTargetHead(player)
        end
    end
end

local function startCode()
    isRunning = true
    autokillplayerlocal = true
    stepConnection = RunService.Stepped:Connect(main)
end

local function stopCode()
    isRunning = false
    autokillplayerlocal = false
    if stepConnection then
        stepConnection:Disconnect()
    end
    selectedPlayers = {}
    if dropdown then
        dropdown:ClearSelection()
    end
end

Players.PlayerAdded:Connect(function(player)
    updateDropdown(player)
    dropdown:ClearOptions()
    for _, p in ipairs(Players:GetPlayers()) do
        dropdown:AddOption(p.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeDropdown(player)
end)

dropdown = killerTab:AddDropdown("Blacklist", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    updateDropdown(player)
end

killerTab:AddButton("Clear Blacklist", function()
    _G.targetPlayer = ""
    updateTargetPlayerLabel()
end)

local autoKillTargetSwitch = killerTab:AddSwitch("Kill List", function(bool)
    _G.autoKillTarget = bool
    
    if bool and _G.targetPlayer ~= "" then
        spawn(function()
            while _G.autoKillTarget and _G.targetPlayer ~= "" do
                local targetName = _G.targetPlayer:match("^([^%(]+)")
                if targetName then
                    targetName = targetName:gsub("%s+$", "")
                    local targetPlayer = game.Players:FindFirstChild(targetName)
                    if targetPlayer then
                        killPlayer(targetPlayer)
                    end
                end
                task.wait()
            end
        end)
    end
end)

local autoKillAllSwitch = killerTab:AddSwitch("Kill All", function(bool)
    _G.autoKillAll = bool
    
    if bool then
        spawn(function()
            while _G.autoKillAll do
                local players = game:GetService("Players"):GetPlayers()
                
                if #players <= 1 then
                    task.wait()
                    continue
                end
                
                for _, player in ipairs(players) do
                    if player == game.Players.LocalPlayer or not _G.autoKillAll then
                        continue
                    end
                    
                    local isWhitelisted = false
                    for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                        if whitelistedInfo:find(player.Name, 1, true) then
                            isWhitelisted = true
                            break
                        end
                    end
                    
                    if not isWhitelisted then
                        killPlayer(player)
                        task.wait()
                    end
                end
                
                task.wait()
            end
        end)
    end
end)

function gettool()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
		end
	end
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
	game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function createParticles(part)
	local attachment = Instance.new("Attachment", part)
	local codeParticle = Instance.new("ParticleEmitter", attachment)
	codeParticle.Texture = "rbxassetid://244905904"
	codeParticle.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 155, 0))
	})
	codeParticle.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(1, 0)
	})
	codeParticle.Lifetime = NumberRange.new(0.5, 1)
	codeParticle.Rate = 50
	codeParticle.Speed = NumberRange.new(5, 10)
	codeParticle.SpreadAngle = Vector2.new(-180, 180)
	local lightning = Instance.new("Beam", part)
	lightning.Texture = "rbxassetid://446111271"
	lightning.TextureSpeed = 3
	lightning.Color = ColorSequence.new(Color3.fromRGB(0, 255, 0))
	return {
		codeParticle,
		lightning
	}
end

local currentRadius = 75
killerTab:AddTextBox("Range (1-150)", function(Value)
currentRadius = math.clamp(tonumber(Value) or 75, 1, 150)
end)

killerTab:AddTextBox("Player Name (Optional)", function(Value)

end)

killerTab:AddSwitch("Protect Player", function(bool)
    
end)

killerTab:AddSwitch("Death Ring", function(v)
getgenv().killNearby = v
		local radiusVisual = Instance.new("Part")
		radiusVisual.Anchored = true
		radiusVisual.CanCollide = false
		radiusVisual.Transparency = 0.8
		radiusVisual.Material = Enum.Material.ForceField
		radiusVisual.Color = Color3.fromRGB(0, 0, 0)
		radiusVisual.Size = Vector3.new(1, 0.1, 1)
		task.spawn(function()
			while getgenv().killNearby do
				pcall(function()
					local myCharacter = game.Players.LocalPlayer.Character
					local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
					if myRoot then
						radiusVisual.Parent = workspace
						radiusVisual.Size = Vector3.new(currentRadius * 2, 0.1, currentRadius * 2)
						radiusVisual.CFrame = myRoot.CFrame * CFrame.new(0, -2, 0)
						local effects = createParticles(myRoot)
						for _, player in pairs(game:GetService("Players"):GetPlayers()) do
								local char = player.Character
								local root = char and char:FindFirstChild("HumanoidRootPart")
								if root and myRoot and myCharacter:FindFirstChild("LeftHand") then
									local distance = (root.Position - myRoot.Position).Magnitude
									if distance <= currentRadius then
										local killEffect = Instance.new("Part")
										killEffect.Anchored = true
										killEffect.CanCollide = false
										killEffect.Transparency = 0.5
										killEffect.Material = Enum.Material.Neon
										killEffect.Color = Color3.fromRGB(0, 0, 0)
										killEffect.CFrame = root.CFrame
										killEffect.Size = Vector3.new(5, 5, 5)
										killEffect.Parent = workspace
										game:GetService("TweenService"):Create(killEffect, TweenInfo.new(0.5), {
											Size = Vector3.new(0, 0, 0),
											Transparency = 1
										}):Play()
										game:GetService("Debris"):AddItem(killEffect, 0.5)
										firetouchinterest(root, myCharacter.LeftHand, 0)
										task.wait()
										firetouchinterest(root, myCharacter.LeftHand, 1)
										gettool()
									end
								end
							end
						task.wait(0.1)
						for _, effect in ipairs(effects) do
							effect:Destroy()
						end
					end
				end)
				task.wait(0.1)
			end
			radiusVisual:Destroy()
		end)
	end)

killerTab:AddSwitch("Invisible", function(bool)
    
end)

local Server = window:AddTab("Specs")

Server:AddLabel("View Player").TextSize = 25

    local function viewPlayer(playerName)
            local player = nil
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p.Name:lower():match(playerName:lower()) then
                    player = p
                    break
                end
            end
        
            if player then
                local function setCameraToCharacter(character)
                    game.Workspace.CurrentCamera.CameraSubject = character
                end
        
                setCameraToCharacter(player.Character or player.CharacterAdded:Wait())
        
                if currentPlayerConnection then
                    currentPlayerConnection:Disconnect()
                    currentPlayerConnection = nil
                end
        
                currentPlayerConnection = player.CharacterAdded:Connect(setCameraToCharacter)
                currentPlayer = player
            else
                warn("Player not found:", playerName)
            end
        end

        local selectedPlayers = {}
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local isRunning = false
        local stepConnection
        local dropdown = nil
        
        local function updateDropdown(player)
            if dropdown then
                dropdown:Add(player.Name)
            end
        end
        
        local function removeDropdown(player)
            if dropdown then
                dropdown:Remove(player.Name)
            end
        end
        
        local function touchTargetHead(player)
            if player and player.Character then
                local targetHead = player.Character:FindFirstChild("Head")
                local localLeftHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("LeftHand")
                local localRightHand = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("RightHand")
        
                if targetHead and localLeftHand and localRightHand then
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                    firetouchinterest(targetHead, localLeftHand, 0)
                    firetouchinterest(targetHead, localRightHand, 1)
                end
            end
        end
        
        local function main()
            for _, player in ipairs(selectedPlayers) do
                touchTargetHead(player)
            end
        end
        
        local function startCode()
            isRunning = true
            stepConnection = RunService.Stepped:Connect(main)
        end
        
        local function stopCode()
            isRunning = false
            if stepConnection then
                stepConnection:Disconnect()
            end
            selectedPlayers = {}
            if dropdown then
                dropdown:ClearSelection()
            end
        end

local selectedPlayers = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local isRunning = false
local stepConnection
local dropdown = nil
local autokillplayerlocal = false

local function updateDropdown(player)
    if dropdown then
        dropdown:Add(player.Name)
    end
end

local function removeDropdown(player)
    if dropdown then
        dropdown:Remove(player.Name)
    end
end

local function touchTargetHead(player)
    if player and player.Character then
        local charkterkiller = player.Character
        local mycharacter = Players.LocalPlayer.Character

        if charkterkiller and mycharacter then
            pcall(function()
                charkterkiller.Head.Anchored = true
                charkterkiller.Head.CanCollide = false

                pcall(function()
                    if charkterkiller.Head.Neck.Name == "Neck" and charkterkiller.Head.nameGui then
                        charkterkiller.Head.nameGui:Clone().Parent = charkterkiller.UpperTorso
                        charkterkiller.Head.Neck:Destroy()
                        charkterkiller.Head.nameGui:Destroy()
                        charkterkiller.Head.Transparency = 1
                        charkterkiller.Head.Face:Destroy()
                    end
                end)

                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Punch"))
                local args = {
                    [1] = "punch",
                    [2] = "rightHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
    
                local args = {
                    [1] = "punch",
                    [2] = "leftHand"
                }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

                    wait()
                    charkterkiller.Head.Position = Vector3.new(mycharacter.LeftHand.Position.X, mycharacter.LeftHand.Position.Y, mycharacter.LeftHand.Position.Z)
                end)
            end)
        end
    end
end

local function main()
    if autokillplayerlocal then
        for _, player in ipairs(selectedPlayers) do
            touchTargetHead(player)
        end
    end
end

local function startCode()
    isRunning = true
    autokillplayerlocal = true
    stepConnection = RunService.Stepped:Connect(main)
end

local function stopCode()
    isRunning = false
    autokillplayerlocal = false
    if stepConnection then
        stepConnection:Disconnect()
    end
    selectedPlayers = {}
    if dropdown then
        dropdown:ClearSelection()
    end
end

Players.PlayerAdded:Connect(function(player)
    updateDropdown(player)
    dropdown:ClearOptions()
    for _, p in ipairs(Players:GetPlayers()) do
        dropdown:AddOption(p.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeDropdown(player)
end)

dropdown = Server:AddDropdown("Players", function(text)
    viewPlayer(text)
end)

for _, player in ipairs(Players:GetPlayers()) do
    updateDropdown(player)
end

Server:AddLabel("")

Server:AddLabel("Track Stats").TextSize = 25

    local playerData = {}
        local currentSelectedPlayer = nil
        local dropdown = nil
local function abbreviateNumber(value)
    if value >= 1e18 then
        return string.format("%.1fQi", value / 1e18)
    elseif value >= 1e15 then
        return string.format("%.1fQa", value / 1e15)
    elseif value >= 1e12 then
        return string.format("%.1fT", value / 1e12)
    elseif value >= 1e9 then
        return string.format("%.1fB", value / 1e9)
    elseif value >= 1e6 then
        return string.format("%.1fM", value / 1e6)
    elseif value >= 1e3 then
        return string.format("%.1fK", value / 1e3)
    else
        return tostring(value)
    end
end
 
local function createPlayerLabels(player)
    local playerName = player.Name
    local leaderstats = player:FindFirstChild("leaderstats")

    local labels = {
        KillsLabel = Server:AddLabel("Kills: " .. abbreviateNumber(leaderstats.Kills.Value or 0)),
        StrengthLabel = Server:AddLabel("Strength: " .. abbreviateNumber(leaderstats.Strength.Value or 0)),
        DurabilityLabel = Server:AddLabel("Durability: " .. abbreviateNumber(player.Durability.Value or 0)),
    }

    playerData[playerName] = labels
    leaderstats.Kills.Changed:Connect(function()
        labels.KillsLabel.Text = "Kills: " .. abbreviateNumber(leaderstats.Kills.Value or 0)
    end)
    leaderstats.Strength.Changed:Connect(function()
        labels.StrengthLabel.Text = "Strength: " .. abbreviateNumber(leaderstats.Strength.Value or 0)
    end)
    player.Durability.Changed:Connect(function()
        labels.DurabilityLabel.Text = "Durability: " .. abbreviateNumber(player.Durability.Value or 0)
    end)
end
 
local function removePlayerLabels(playerName)
    local labels = playerData[playerName]
    if labels then
        for _, label in pairs(labels) do
            label:Remove()
        end
        playerData[playerName] = nil
    end
end

local function recreateDropdown()
            if dropdown then
                dropdown:Remove()
            end
            
            local dropdownOptions = {}
            for _, player in ipairs(game.Players:GetPlayers()) do
                table.insert(dropdownOptions, player.Name)
            end

            dropdown = Server:AddDropdown("Players", function(playerName)
                local player = game.Players:FindFirstChild(playerName)
                if player then
                    if currentSelectedPlayer then
                        removePlayerLabels(currentSelectedPlayer)
                    end
                    createPlayerLabels(player)
                    currentSelectedPlayer = playerName
                end
            end)
            
            for _, option in ipairs(dropdownOptions) do
                dropdown:Add(option)
            end
        end
        
        recreateDropdown()
        
        game.Players.PlayerAdded:Connect(function(player)
            recreateDropdown()
        end)

game.Players.PlayerRemoving:Connect(function(player)
            removePlayerLabels(player.Name)
            recreateDropdown()
        end)

        local Teleport = window:AddTab("Teleports")

        Teleport:AddLabel("Main").TextSize = 25

Teleport:AddButton("Spawn", function()
    local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
end)

Teleport:AddButton("Fortune", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local targetPosition = Vector3.new(-2606, 1, 5752)

    if character then
        character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end)

Teleport:AddButton("Secret", function()
    local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
end)

Teleport:AddButton("Tiny", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
end)

Teleport:AddLabel("")

Teleport:AddLabel("Gyms").TextSize = 25

Teleport:AddButton("Frost", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
end)

Teleport:AddButton("Mythical", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
end)

Teleport:AddButton("Inferno", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
end)

Teleport:AddButton("Legend", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
end)

Teleport:AddButton("King", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
end)

Teleport:AddButton("Jungle", function()
local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
end)

Teleport:AddLabel("")

Teleport:AddLabel("Brawls").TextSize = 25

Teleport:AddButton("Lava", function()
    local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
end)

Teleport:AddButton("Desert", function()
    local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
end)

Teleport:AddButton("Beach", function()
    local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
end)

local rebirth = window:AddTab("Rebirth")

rebirth:AddLabel("Rebirth").TextSize = 25

-- Target rebirth input - direct text input
rebirth:AddTextBox("Target Point", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats()
    end
end)

local teleportSwitch = rebirth:AddSwitch("Auto King", function(bool)
    _G.teleportActive = bool
 
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end)

local sizeSwitch = rebirth:AddSwitch("Always Size 2", function(bool)
    _G.autoSizeActive = bool
 
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
            end
        end)
    end
end)

local frameToggle = rebirth:AddSwitch("Hide Pop Ups", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

rebirth:AddButton("Anti Lag", function()
local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local lighting = game:GetService("Lighting")

    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then gui:Destroy() end
    end

    local function removeTransparentParts(obj)
        for _, part in pairs(obj:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency >= 0.5 then
                part:Destroy()
            end
        end
    end

    local function removeSounds(obj)
        for _, s in pairs(obj:GetDescendants()) do
            if s:IsA("Sound") then
                s:Stop()
                s:Destroy()
            end
        end
    end

    local function hideOtherPlayers()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then p.Character:Destroy() end
        end
    end

    local function removeNPCs()
        for _, npc in pairs(workspace:GetChildren()) do
            if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") and
                not game.Players:GetPlayerFromCharacter(npc) then
                npc:Destroy()
            end
        end
    end

    local function darkenSky()
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end

        local darkSky = Instance.new("Sky")
        darkSky.Name = "DarkSky"
        darkSky.SkyboxBk = "rbxassetid://0"
        darkSky.SkyboxDn = "rbxassetid://0"
        darkSky.SkyboxFt = "rbxassetid://0"
        darkSky.SkyboxLf = "rbxassetid://0"
        darkSky.SkyboxRt = "rbxassetid://0"
        darkSky.SkyboxUp = "rbxassetid://0"
        darkSky.Parent = lighting

        lighting.Brightness = 0
        lighting.ClockTime = 0
        lighting.TimeOfDay = "00:00:00"
        lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        lighting.Ambient = Color3.new(0, 0, 0)
        lighting.FogColor = Color3.new(0, 0, 0)
        lighting.FogEnd = 100

        task.spawn(function()
            while true do
                wait(5)
                if not lighting:FindFirstChild("DarkSky") then
                    darkSky:Clone().Parent = lighting
                end
                lighting.Brightness = 0
                lighting.ClockTime = 0
                lighting.OutdoorAmbient = Color3.new(0, 0, 0)
                lighting.Ambient = Color3.new(0, 0, 0)
                lighting.FogColor = Color3.new(0, 0, 0)
                lighting.FogEnd = 100
            end
        end)
    end

    local function removeParticleEffects()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then obj:Destroy() end
        end
    end

    local function removeLightSources()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("PointLight") or obj:IsA("SpotLight") or
                obj:IsA("SurfaceLight") then obj:Destroy() end
        end
    end

    removeParticleEffects()
    removeLightSources()
    darkenSky()
end)

rebirth:AddLabel("")

-- Create toggle switches
local infiniteSwitch -- Forward declaration
 
local targetSwitch = rebirth:AddSwitch("Rebirth (Target)", function(bool)
    _G.targetRebirthActive = bool
 
    if bool then
        -- Turn off infinite rebirth if it's on
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
 
        -- Start target rebirth loop
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
 
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
 
                    break
                end
 
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

infiniteSwitch = rebirth:AddSwitch("Rebirth (Normal)", function(bool)
    _G.infiniteRebirthActive = bool
 
    if bool then
        -- Turn off target rebirth if it's on
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end
 
        -- Start infinite rebirth loop
        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

local player = game.Players.LocalPlayer
local muscleEvent = player:WaitForChild("muscleEvent")
local replicatedStorage = game:GetService("ReplicatedStorage")

local function unequipPets()
    for _, folder in pairs(player.petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                replicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet",
                                                                   pet)
            end
        end
    end
    task.wait(0.1)
end

local function equipPetsByName(name)
    unequipPets()
    task.wait(0.01)
    for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
        if pet.Name == name then
            replicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local isRunning = false

local function fastReb()
    while isRunning do
        equipPetsByName("Swift Samurai")
        task.wait(0.4) -- Kurze Pause zwischen Pet-Wechsel

        local rebirths = player.leaderstats.Rebirths.Value
        local strengthTarget = 5000 + (rebirths * 2600)

        while isRunning and player.leaderstats.Strength.Value < strengthTarget do
            local repsToDo = player.MembershipType ==
                                 Enum.MembershipType.Premium and 8 or 14
            for _ = 1, repsToDo do muscleEvent:FireServer("rep") end
            task.wait(0.02) -- kurze Pause, um die Serverlast nicht zu überlasten
        end

        if player.leaderstats.Strength.Value >= strengthTarget then
            -- Sobald die Zielstärke erreicht ist, Pet wechseln
            equipPetsByName("Tribal Overlord")
            task.wait(0.4)

            local before = player.leaderstats.Rebirths.Value
            repeat
                replicatedStorage.rEvents.rebirthRemote:InvokeServer(
                    "rebirthRequest")
                task.wait(0.3)
            until player.leaderstats.Rebirths.Value > before

            task.wait(0.5)
        end
    end
end

local packFarm = rebirth:AddSwitch("Rebirth (Packs)", function(bool)
if bool then
        isRunning = true
        fastReb()
    else
        isRunning = false
    end
end)

local Farm = window:AddTab("Farming")

Farm:AddLabel("Misc").TextSize = 25

local isGrinding = false
 
local speedGrind = Farm:AddSwitch("Fast Reb (Only for Farming, not Rebirthing)", function(bool)
    local isGrinding = bool

    if not bool then
        return
    end

    for i = 1, 12 do
        task.spawn(function()
            while isGrinding do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait()
            end
        end)
    end
end)

local frameToggle = Farm:AddSwitch("Hide Pop Ups", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

local teleportSwitch2 = Farm:AddSwitch("Auto King (Only with Fast Reb)", function(bool)
    _G.teleportActive = bool
 
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end)

        Farm:AddSwitch("Auto Egg", function(bool)
_G.AutoEgg = bool
		while _G.AutoEgg do
			local boostFolder = game.Players.LocalPlayer:FindFirstChild("boostTimersFolder")
			if not boostFolder then
				useOneEgg()
				task.wait(1)
				continue
			end
			local eggTimer = boostFolder:FindFirstChild("Protein Egg")
			if not eggTimer then
				useOneEgg()
				task.wait(1)
				continue
			end
			if tonumber(eggTimer.Value) <= 25 then
				useOneEgg()
			end
			task.wait(1)
		end
end)

Farm:AddSwitch("Fast Punch", function(Value)
		_G.fastHitActive = Value
		if Value then
			local function equipAndModifyPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					local punch = player.Backpack:FindFirstChild("Punch")
					if punch then
						punch.Parent = player.Character
						if punch:FindFirstChild("attackTime") then
							punch.attackTime.Value = 0
						end
					end
					wait(0)
				end
			end
			local function rapidPunch()
				while _G.fastHitActive do
					local player = game.Players.LocalPlayer
					player.muscleEvent:FireServer("punch", "rightHand")
					player.muscleEvent:FireServer("punch", "leftHand")
					local character = player.Character
					if character then
						local punchTool = character:FindFirstChild("Punch")
						if punchTool then
							punchTool:Activate()
						end
					end
					wait(0)
				end
			end
			coroutine.wrap(equipAndModifyPunch)()
			coroutine.wrap(rapidPunch)()
		else
			local character = game.Players.LocalPlayer.Character
			local equipped = character:FindFirstChild("Punch")
			if equipped then
				equipped.Parent = game.Players.LocalPlayer.Backpack
			end
		end
end)

Farm:AddLabel("")

Farm:AddLabel("Auto Tools").TextSize = 25

 local autoRepToggle = false
Farm:AddSwitch("Farm Any Tool", function(State)
    autoRepToggle = State
    if State then
        task.spawn(function()
            while autoRepToggle do
                game:GetService("Players").LocalPlayer:WaitForChild("muscleEvent"):FireServer("rep")
                task.wait(0.01)
            end
        end)
    end
end)

Farm:AddSwitch("Fast Tools", function(State)
 _G.FastTools = Value
 
    local defaultSpeeds = {
        {
            "Punch",
            "attackTime",
            Value and 0 or 0.35
        },
        {
            "Ground Slam",
            "attackTime",
            Value and 0 or 6
        },
        {
            "Stomp",
            "attackTime",
            Value and 0 or 7
        },
        {
            "Handstands",
            "repTime",
            Value and 0 or 1
        },
        {
            "Pushups",
            "repTime",
            Value and 0 or 1
        },
        {
            "Weight",
            "repTime",
            Value and 0 or 1
        },
        {
            "Situps",
            "repTime",
            Value and 0 or 1
        }
    }
 
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
 
    for _, toolInfo in ipairs(defaultSpeeds) do
        local tool = backpack:FindFirstChild(toolInfo[1])
        if tool and tool:FindFirstChild(toolInfo[2]) then
            tool[toolInfo[2]].Value = toolInfo[3]
        end
 
        local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
        if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
            equippedTool[toolInfo[2]].Value = toolInfo[3]
        end
    end
end)

Farm:AddLabel("")

Farm:AddLabel("Auto Rocks").TextSize = 25

local function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local ancientJungleRockSwitch = Farm:AddSwitch("Jungle Rock", function(bool)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 10000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local muscleKingGymRockSwitch = Farm:AddSwitch("King Rock", function(bool)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 5000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local legendGymRockSwitch = Farm:AddSwitch("Legend Rock", function(bool)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 1000000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local eternalGymRockSwitch = Farm:AddSwitch("Inferno Rock", function(bool)
    selectrock = "Eternal Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 750000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local mythicalGymRockSwitch = Farm:AddSwitch("Mythical Rock", function(bool)
    selectrock = "Mythical Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 400000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local frostGymRockSwitch = Farm:AddSwitch("Frost Rock", function(bool)
    selectrock = "Frost Gym Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 150000 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local tinyIslandRockSwitch = Farm:AddSwitch("Tiny Rock", function(bool)
    selectrock = "Tiny Island Rock"
    getgenv().autoFarm = bool
 
    if bool then
        spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == 0 and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
 
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end
end)

local statsFolder = window:AddTab("Stats")

local sessionStartTime = os.time()
local sessionStartStrength = 0
local sessionStartDurability = 0
local sessionStartKills = 0
local sessionStartRebirths = 0
local sessionStartBrawls = 0
local hasStartedTracking = false

statsFolder:AddLabel("Strength")
local strengthStatsLabel = statsFolder:AddLabel("Actual: Waiting...")
local strengthGainLabel = statsFolder:AddLabel("Gained: 0")
 
statsFolder:AddLabel("Durability")
local durabilityStatsLabel = statsFolder:AddLabel("Actual: Waiting...")
local durabilityGainLabel = statsFolder:AddLabel("Gained: 0")
 
statsFolder:AddLabel("Rebirths")
local rebirthsStatsLabel = statsFolder:AddLabel("Actual: Waiting...")
local rebirthsGainLabel = statsFolder:AddLabel("Gained: 0")
 
statsFolder:AddLabel("Kills")
local killsStatsLabel = statsFolder:AddLabel("Actual: Waiting...")
local killsGainLabel = statsFolder:AddLabel("Gained: 0")
 
statsFolder:AddLabel("Brawls")
local brawlsStatsLabel = statsFolder:AddLabel("Actual: Waiting...")
local brawlsGainLabel = statsFolder:AddLabel("Gained: 0")
 
statsFolder:AddLabel("Time Of Session")
local sessionTimeLabel = statsFolder:AddLabel("Time: 00:00:00")

local function formatNumber(number)
    if number >= 1e15 then return string.format("%.2fQ", number/1e15)
    elseif number >= 1e12 then return string.format("%.2fT", number/1e12)
    elseif number >= 1e9 then return string.format("%.2fB", number/1e9)
    elseif number >= 1e6 then return string.format("%.2fM", number/1e6)
    elseif number >= 1e3 then return string.format("%.2fK", number/1e3)
    end
    return tostring(math.floor(number))
end
 
local function formatNumberWithCommas(number)
    local formatted = tostring(math.floor(number))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end
 
local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
 
    if days > 0 then
        return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
end
 
local function startTracking()
    if not hasStartedTracking then
        local player = game.Players.LocalPlayer
        sessionStartStrength = player.leaderstats.Strength.Value
        sessionStartDurability = player.Durability.Value
        sessionStartKills = player.leaderstats.Kills.Value
        sessionStartRebirths = player.leaderstats.Rebirths.Value
        sessionStartBrawls = player.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end
end
 
local function updateStats()
    local player = game.Players.LocalPlayer
 
    if not hasStartedTracking then
        startTracking()
    end
 
    local currentStrength = player.leaderstats.Strength.Value
    local currentDurability = player.Durability.Value
    local currentKills = player.leaderstats.Kills.Value
    local currentRebirths = player.leaderstats.Rebirths.Value
    local currentBrawls = player.leaderstats.Brawls.Value
 
    local strengthGain = currentStrength - sessionStartStrength
    local durabilityGain = currentDurability - sessionStartDurability
    local killsGain = currentKills - sessionStartKills
    local rebirthsGain = currentRebirths - sessionStartRebirths
    local brawlsGain = currentBrawls - sessionStartBrawls
 
    strengthStatsLabel.Text = string.format("Actual: %s", formatNumber(currentStrength))
    durabilityStatsLabel.Text = string.format("Actual: %s", formatNumber(currentDurability))
    rebirthsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentRebirths))
    killsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentKills))
    brawlsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentBrawls))
 
    strengthGainLabel.Text = string.format("Gained: %s", formatNumber(strengthGain))
    durabilityGainLabel.Text = string.format("Gained: %s", formatNumber(durabilityGain))
    rebirthsGainLabel.Text = string.format("Gained: %s", formatNumber(rebirthsGain))
    killsGainLabel.Text = string.format("Gained: %s", formatNumber(killsGain))
    brawlsGainLabel.Text = string.format("Gained: %s", formatNumber(brawlsGain))
 
    local elapsedTime = os.time() - sessionStartTime
    local timeString = formatTime(elapsedTime)
    sessionTimeLabel.Text = string.format("Time: %s", timeString)
end
 
updateStats()
 
spawn(function()
    while wait(2) do
        updateStats()
    end
end)
 
statsFolder:AddButton("Reset Stats", function()
    local player = game.Players.LocalPlayer
    sessionStartStrength = player.leaderstats.Strength.Value
    sessionStartDurability = player.Durability.Value
    sessionStartKills = player.leaderstats.Kills.Value
    sessionStartRebirths = player.leaderstats.Rebirths.Value
    sessionStartBrawls = player.leaderstats.Brawls.Value
    sessionStartTime = os.time()
 
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Stats",
        Text = "Stats has been reset",
        Duration = 0
    })
end)
 
statsFolder:AddButton("Copy Stats", function()
    local player = game.Players.LocalPlayer
    local statsText = "Stats Muscle Legends:\n\n"
 
    statsText = statsText .. "Strength: " .. formatNumberWithCommas(player.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Durability: " .. formatNumberWithCommas(player.Durability.Value) .. "\n"
    statsText = statsText .. "Rebirths: " .. formatNumberWithCommas(player.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Kills: " .. formatNumberWithCommas(player.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Brawls: " .. formatNumberWithCommas(player.leaderstats.Brawls.Value) .. "\n\n"
 
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        local strengthGain = player.leaderstats.Strength.Value - sessionStartStrength
        local durabilityGain = player.Durability.Value - sessionStartDurability
        local killsGain = player.leaderstats.Kills.Value - sessionStartKills
        local rebirthsGain = player.leaderstats.Rebirths.Value - sessionStartRebirths
        local brawlsGain = player.leaderstats.Brawls.Value - sessionStartBrawls
 
        statsText = statsText .. "--- Stats ---\n"
        statsText = statsText .. "Time Of Session: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Strength Gained: " .. formatNumberWithCommas(strengthGain) .. "\n"
        statsText = statsText .. "Durability Gained: " .. formatNumberWithCommas(durabilityGain) .. "\n"
        statsText = statsText .. "Rebirths Gained: " .. formatNumberWithCommas(rebirthsGain) .. "\n"
        statsText = statsText .. "Kills Gained: " .. formatNumberWithCommas(killsGain) .. "\n"
        statsText = statsText .. "Brawls Gained: " .. formatNumberWithCommas(brawlsGain) .. "\n"
    end
 
    setclipboard(statsText)
end)

local Credits = window:AddTab("Credits")

Credits:AddLabel("Script is made by 157 (fail)").TextSize = 20
Credits:AddLabel("Any Problems/Questions? -> fail.nb on Discord").TextSize = 17
