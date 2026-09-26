--!strict
local Hello = {}

function Hello.saludar(quien: string): string
	return string.format("Hola %s, ¡el entorno de equipo con Rojo y Git está funcionando!", quien)
end

return Hello
