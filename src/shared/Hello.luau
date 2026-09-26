local Hello = {}

function Hello.saludar(nombre: string)
	return string.format("¡Hola %s! Sistema sincronizado con Rojo y Git.", nombre)
end

return Hello
