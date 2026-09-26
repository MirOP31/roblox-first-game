local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hello = require(ReplicatedStorage.Shared.Hello)

print(" [Servidor] Iniciado con éxito.")
print(" [Servidor]", Hello.saludar("Servidor"))
