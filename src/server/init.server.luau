--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Hello = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Hello") :: ModuleScript)

print("[SERVIDOR] Servidor iniciado correctamente.")
print("[SERVIDOR]", Hello.saludar("Servidor"))

-- Cargar e invocar al Diseñador de Interiores Profesional
local houseModule = script:FindFirstChild("HouseBuilder") or script.Parent:FindFirstChild("HouseBuilder")

if houseModule and houseModule:IsA("ModuleScript") then
	local HouseBuilder = require(houseModule)
	local houseOrigin = Vector3.new(0, 0, 0)
	
	-- Construir la residencia
	HouseBuilder.build(houseOrigin)

	-- Configurar SpawnLocation enfrente del porche para una bienvenida cinematográfica
	local existingSpawn = Workspace:FindFirstChild("HouseEntranceSpawn")
	if not existingSpawn then
		local spawn = Instance.new("SpawnLocation")
		spawn.Name = "HouseEntranceSpawn"
		spawn.Size = Vector3.new(6, 0.4, 6)
		spawn.CFrame = CFrame.new(0, 1.2, 36) * CFrame.Angles(0, math.rad(180), 0)
		spawn.Color = Color3.fromRGB(50, 50, 55)
		spawn.Material = Enum.Material.SmoothPlastic
		spawn.Anchored = true
		spawn.CanCollide = true
		spawn.TopSurface = Enum.SurfaceType.Smooth
		spawn.Duration = 0
		spawn.Parent = Workspace
	end
else
	warn("[SERVIDOR] No se encontró el módulo HouseBuilder.")
end
