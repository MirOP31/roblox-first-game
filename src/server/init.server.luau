--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hello = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Hello") :: ModuleScript)

print("[SERVIDOR] Servidor iniciado correctamente.")
print("[SERVIDOR]", Hello.saludar("Servidor"))
