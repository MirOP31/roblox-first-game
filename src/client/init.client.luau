--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hello = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Hello") :: ModuleScript)

print("[CLIENTE] Cliente cargado con éxito.")
print("[CLIENTE]", Hello.saludar("Jugador"))
