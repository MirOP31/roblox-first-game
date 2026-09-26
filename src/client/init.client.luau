local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hello = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Hello"))

print("🎮 [Cliente] LocalScript cargado.")
print("🎮 [Cliente]", Hello.saludar("Jugador"))
