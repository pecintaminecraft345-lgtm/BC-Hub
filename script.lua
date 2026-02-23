-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Window
local Window = Rayfield:CreateWindow({
   Name = "BC TEAM",
   LoadingTitle = "C11huy",
   LoadingSubtitle = "by BC TEAM",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "Big Hub"
   }
})

-- Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)

local player = game.Players.LocalPlayer

-- WalkSpeed Slider
PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {10, 100},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- JumpPower Slider
PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {10, 200},
   Increment = 1,
   Suffix = " Jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- Teleport To Player Input
PlayerTab:CreateInput({
   Name = "Teleport To Player",
   PlaceholderText = "Masukkan Username",
   RemoveTextAfterFocusLost = false,
   Flag = "TeleportInput",
   Callback = function(username)
      local target = game.Players:FindFirstChild(username)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         player.Character.HumanoidRootPart.CFrame =
            target.Character.HumanoidRootPart.CFrame
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Player tidak ditemukan!",
            Duration = 3
         })
      end
   end,
})

-- Auto Teleport Forward Slider
local autoTeleport = false
local teleportSpeed = 0

task.spawn(function()
   while true do
      if autoTeleport and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         local hrp = player.Character.HumanoidRootPart
         hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * teleportSpeed)
      end
      task.wait(0.2)
   end
end)

PlayerTab:CreateSlider({
   Name = "Auto Teleport Forward",
   Range = {0, 20},
   Increment = 1,
   Suffix = " Studs",
   CurrentValue = 0,
   Flag = "AutoTeleportSlider",
   Callback = function(Value)
      teleportSpeed = Value
      autoTeleport = Value > 0
   end,
})
