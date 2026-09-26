--!strict
--[[
    HouseBuilder.luau
    Diseñador Arquitectónico y de Interiores Profesional para Roblox Studio.
    Estilo: Villa de Lujo Minimalista Escandinava / Moderna.
    
    Genera una residencia completa con:
    - Estructura arquitectónica con techos altos y ventanales panorámicos.
    - Acabados de lujo (molduras, rodapiés, paneles alistonados de madera).
    - Iluminación ambiental cálida (downlights empotrados, lámparas colgantes, luces de lectura).
    - Salón de estar con sofá seccional en L, mueble flotante, Smart TV y alfombra.
    - Cocina abierta estilo americano con isla de mármol en cascada y taburetes.
    - Dormitorio principal con cama King-size, cabecero tapizado, mesitas flotantes y armario.
    - Porche exterior y vegetación decorativa.
]]

local Workspace = game:GetService("Workspace")

local HouseBuilder = {}

-- Paleta de Colores de Diseñador
local PALETTE = {
	WallWhite = Color3.fromRGB(242, 240, 235),
	WallAccentCharcoal = Color3.fromRGB(38, 40, 44),
	WoodOak = Color3.fromRGB(164, 126, 88),
	WoodDarkWalnut = Color3.fromRGB(72, 48, 32),
	MarbleWhite = Color3.fromRGB(245, 245, 248),
	FabricSofa = Color3.fromRGB(65, 72, 82),
	FabricPillow = Color3.fromRGB(195, 140, 85),
	FabricRug = Color3.fromRGB(228, 224, 214),
	MetalBlack = Color3.fromRGB(28, 28, 30),
	MetalBrass = Color3.fromRGB(205, 168, 90),
	GlassWindow = Color3.fromRGB(210, 235, 250),
	PlantGreen = Color3.fromRGB(50, 115, 60),
	PlantPot = Color3.fromRGB(220, 220, 222),
	LightWarm = Color3.fromRGB(255, 238, 210),
	NeonScreen = Color3.fromRGB(15, 20, 25),
}

-- Función auxiliar para crear partes con tipado estricto
local function createPart(
	parent: Instance,
	name: string,
	size: Vector3,
	cframe: CFrame,
	color: Color3,
	material: Enum.Material,
	canCollide: boolean?,
	transparency: number?
): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.CFrame = cframe
	part.Color = color
	part.Material = material
	part.Anchored = true
	part.CanCollide = if canCollide ~= nil then canCollide else true
	part.Transparency = transparency or 0
	part.CastShadow = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = parent
	return part
end

-- Función auxiliar para añadir luces puntuales cálidas
local function addPointLight(parent: Part, brightness: number, range: number, color: Color3)
	local light = Instance.new("PointLight")
	light.Brightness = brightness
	light.Range = range
	light.Color = color
	light.Shadows = true
	light.Parent = parent
end

function HouseBuilder.build(origin: Vector3): Model
	-- Limpiar instancia anterior si existe para permitir recargas en vivo
	local existing = Workspace:FindFirstChild("DesignerHouse")
	if existing then
		existing:Destroy()
	end

	local house = Instance.new("Model")
	house.Name = "DesignerHouse"

	local structureFolder = Instance.new("Folder")
	structureFolder.Name = "01_Structure"
	structureFolder.Parent = house

	local livingFolder = Instance.new("Folder")
	livingFolder.Name = "02_LivingRoom"
	livingFolder.Parent = house

	local kitchenFolder = Instance.new("Folder")
	kitchenFolder.Name = "03_Kitchen"
	kitchenFolder.Parent = house

	local bedroomFolder = Instance.new("Folder")
	bedroomFolder.Name = "04_Bedroom"
	bedroomFolder.Parent = house

	local lightingFolder = Instance.new("Folder")
	lightingFolder.Name = "05_Lighting"
	lightingFolder.Parent = house

	local decorFolder = Instance.new("Folder")
	decorFolder.Name = "06_Decorations"
	decorFolder.Parent = house

	-- Parámetros Generales de la Casa (60 x 44 studs, 14 studs de altura)
	local H_WIDTH = 60
	local H_DEPTH = 44
	local H_HEIGHT = 14
	local WALL_THICK = 1.2
	local FLOOR_Y = origin.Y + 0.6

	----------------------------------------------------------------------
	-- 1. ESTRUCTURA (Cimentación, Suelos zonificados y Techo)
	----------------------------------------------------------------------
	-- Base de cimentación exterior
	createPart(
		structureFolder,
		"Foundation",
		Vector3.new(H_WIDTH + 6, 1.2, H_DEPTH + 10),
		CFrame.new(origin.X, origin.Y + 0.6, origin.Z + 2),
		Color3.fromRGB(180, 180, 185),
		Enum.Material.Concrete
	)

	-- Porche exterior de madera delantera
	createPart(
		structureFolder,
		"FrontDeck",
		Vector3.new(H_WIDTH, 0.4, 8),
		CFrame.new(origin.X, FLOOR_Y + 0.8, origin.Z + (H_DEPTH / 2) + 4),
		PALETTE.WoodOak,
		Enum.Material.WoodPlanks
	)

	-- Suelo Zona Social (Salón): Parquet de roble en espiga
	local livingWidth = 36
	local livingX = origin.X - (H_WIDTH / 2) + (livingWidth / 2)
	createPart(
		structureFolder,
		"LivingFloor",
		Vector3.new(livingWidth, 0.4, H_DEPTH - 2),
		CFrame.new(livingX, FLOOR_Y + 0.8, origin.Z),
		PALETTE.WoodOak,
		Enum.Material.WoodPlanks
	)

	-- Suelo Zona Privada (Dormitorio y Baño): Microcemento / Mármol gris suave
	local bedWidth = H_WIDTH - livingWidth
	local bedX = origin.X + (H_WIDTH / 2) - (bedWidth / 2)
	createPart(
		structureFolder,
		"BedroomFloor",
		Vector3.new(bedWidth, 0.4, H_DEPTH - 2),
		CFrame.new(bedX, FLOOR_Y + 0.8, origin.Z),
		PALETTE.MarbleWhite,
		Enum.Material.Marble
	)

	-- Techo / Plafón Interior con voladizo moderno
	createPart(
		structureFolder,
		"Ceiling",
		Vector3.new(H_WIDTH + 4, 1.2, H_DEPTH + 6),
		CFrame.new(origin.X, FLOOR_Y + H_HEIGHT, origin.Z + 1),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)

	-- Borde Fascia exterior del techo (diseño arquitectónico oscuro)
	createPart(
		structureFolder,
		"RoofFascia",
		Vector3.new(H_WIDTH + 4.8, 0.8, H_DEPTH + 6.8),
		CFrame.new(origin.X, FLOOR_Y + H_HEIGHT + 0.6, origin.Z + 1),
		PALETTE.MetalBlack,
		Enum.Material.SmoothPlastic
	)

	----------------------------------------------------------------------
	-- 2. PAREDES PERIMETRALES Y MOLDURAS
	----------------------------------------------------------------------
	local wallCenterY = FLOOR_Y + 1 + (H_HEIGHT / 2)

	-- Pared Trasera (Norte)
	createPart(
		structureFolder,
		"WallBack",
		Vector3.new(H_WIDTH, H_HEIGHT, WALL_THICK),
		CFrame.new(origin.X, wallCenterY, origin.Z - (H_DEPTH / 2)),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)

	-- Pared Lateral Izquierda (Oeste)
	createPart(
		structureFolder,
		"WallLeft",
		Vector3.new(WALL_THICK, H_HEIGHT, H_DEPTH),
		CFrame.new(origin.X - (H_WIDTH / 2), wallCenterY, origin.Z),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)

	-- Pared Lateral Derecha (Este)
	createPart(
		structureFolder,
		"WallRight",
		Vector3.new(WALL_THICK, H_HEIGHT, H_DEPTH),
		CFrame.new(origin.X + (H_WIDTH / 2), wallCenterY, origin.Z),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)

	-- Muro Divisorio Interior (Separa Zona Social del Dormitorio) con hueco para puerta
	local dividerX = origin.X - (H_WIDTH / 2) + livingWidth
	-- Segmento divisorio posterior
	createPart(
		structureFolder,
		"InteriorDividerA",
		Vector3.new(WALL_THICK, H_HEIGHT, (H_DEPTH / 2) - 3),
		CFrame.new(dividerX, wallCenterY, origin.Z - (H_DEPTH / 4) - 1.5),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)
	-- Segmento divisorio dintel superior sobre puerta
	createPart(
		structureFolder,
		"InteriorDividerLintel",
		Vector3.new(WALL_THICK, 4.5, 6),
		CFrame.new(dividerX, FLOOR_Y + H_HEIGHT - 2.25, origin.Z + 1),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)
	-- Segmento divisorio frontal
	createPart(
		structureFolder,
		"InteriorDividerB",
		Vector3.new(WALL_THICK, H_HEIGHT, (H_DEPTH / 2) - 5),
		CFrame.new(dividerX, wallCenterY, origin.Z + (H_DEPTH / 4) + 2.5),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)

	-- Fachada Frontal (Sur): Ventanal Panorámico de Piso a Techo con perfiles negros
	local frontZ = origin.Z + (H_DEPTH / 2)

	-- Muro frontal dormitorio (lado derecho) con ventana horizontal moderna
	createPart(
		structureFolder,
		"FrontWallRightLower",
		Vector3.new(bedWidth, 3.5, WALL_THICK),
		CFrame.new(bedX, FLOOR_Y + 1.75 + 1, frontZ),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)
	createPart(
		structureFolder,
		"FrontWallRightUpper",
		Vector3.new(bedWidth, 3.5, WALL_THICK),
		CFrame.new(bedX, FLOOR_Y + H_HEIGHT - 1.75, frontZ),
		PALETTE.WallWhite,
		Enum.Material.SmoothPlastic
	)
	createPart(
		structureFolder,
		"FrontWindowRightGlass",
		Vector3.new(bedWidth - 2, 7, 0.4),
		CFrame.new(bedX, FLOOR_Y + 7, frontZ),
		PALETTE.GlassWindow,
		Enum.Material.Glass,
		true,
		0.55
	)

	-- Gran Ventanal y Puerta Corredera en Sala de Estar (Lado izquierdo)
	createPart(
		structureFolder,
		"FrontWindowLivingGlassA",
		Vector3.new(livingWidth * 0.45, H_HEIGHT - 2, 0.4),
		CFrame.new(livingX - (livingWidth * 0.23), FLOOR_Y + (H_HEIGHT / 2), frontZ),
		PALETTE.GlassWindow,
		Enum.Material.Glass,
		true,
		0.6
	)
	createPart(
		structureFolder,
		"FrontWindowLivingGlassB",
		Vector3.new(livingWidth * 0.45, H_HEIGHT - 2, 0.4),
		CFrame.new(livingX + (livingWidth * 0.23), FLOOR_Y + (H_HEIGHT / 2), frontZ),
		PALETTE.GlassWindow,
		Enum.Material.Glass,
		true,
		0.6
	)

	-- Perfiles metálicos negros de la carpintería exterior (Mullions)
	createPart(
		structureFolder,
		"MullionCenter",
		Vector3.new(0.6, H_HEIGHT, 0.8),
		CFrame.new(livingX, wallCenterY, frontZ),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	createPart(
		structureFolder,
		"MullionLeft",
		Vector3.new(0.6, H_HEIGHT, 0.8),
		CFrame.new(origin.X - (H_WIDTH / 2) + 0.3, wallCenterY, frontZ),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)

	----------------------------------------------------------------------
	-- 3. SALÓN DE ESTAR (LIVING ROOM) DE DISEÑO
	----------------------------------------------------------------------
	local sofaBaseY = FLOOR_Y + 1.6
	local livingCenterZ = origin.Z + 3
	local sofaX = origin.X - (H_WIDTH / 2) + 10

	-- Pared de Acento con Paneles Alistonados de Madera (Detrás de la TV)
	local tvWallX = origin.X - (H_WIDTH / 2) + livingWidth - 0.6
	local tvWallZ = origin.Z - 6
	createPart(
		livingFolder,
		"TVFeatureWallBacking",
		Vector3.new(0.4, H_HEIGHT - 2, 18),
		CFrame.new(tvWallX - 0.2, wallCenterY, tvWallZ),
		PALETTE.WallAccentCharcoal,
		Enum.Material.SmoothPlastic
	)
	-- Listones verticales de madera decorativos
	for i = -8, 8, 1.2 do
		createPart(
			livingFolder,
			"WoodSlat_" .. tostring(i),
			Vector3.new(0.3, H_HEIGHT - 2.4, 0.5),
			CFrame.new(tvWallX - 0.4, wallCenterY, tvWallZ + i),
			PALETTE.WoodOak,
			Enum.Material.Wood
		)
	end

	-- Mueble Multimedia Flotante
	createPart(
		livingFolder,
		"MediaConsole",
		Vector3.new(2.8, 1.8, 14),
		CFrame.new(tvWallX - 2, FLOOR_Y + 2.2, tvWallZ),
		PALETTE.WoodDarkWalnut,
		Enum.Material.Wood
	)

	-- Smart TV 85" Ultra Delgada
	createPart(
		livingFolder,
		"SmartTV_Frame",
		Vector3.new(0.4, 6.2, 11),
		CFrame.new(tvWallX - 0.8, FLOOR_Y + 7.5, tvWallZ),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	local tvScreen = createPart(
		livingFolder,
		"SmartTV_Screen",
		Vector3.new(0.1, 5.8, 10.6),
		CFrame.new(tvWallX - 1.05, FLOOR_Y + 7.5, tvWallZ),
		PALETTE.NeonScreen,
		Enum.Material.Neon,
		false
	)
	addPointLight(tvScreen, 0.4, 10, Color3.fromRGB(180, 200, 230))

	-- Barra de sonido estilizada
	createPart(
		livingFolder,
		"Soundbar",
		Vector3.new(0.8, 0.6, 6.5),
		CFrame.new(tvWallX - 1.8, FLOOR_Y + 3.4, tvWallZ),
		PALETTE.MetalBlack,
		Enum.Material.SmoothPlastic
	)

	-- Alfombra de Área Grande y Esponjosa
	createPart(
		livingFolder,
		"LivingRug",
		Vector3.new(16, 0.15, 20),
		CFrame.new(sofaX + 4, FLOOR_Y + 1.05, livingCenterZ - 2),
		PALETTE.FabricRug,
		Enum.Material.Fabric
	)

	-- Sofá Seccional en "L" de Alta Gama
	-- Asiento Principal
	createPart(
		livingFolder,
		"SofaMainBase",
		Vector3.new(6.5, 1.4, 16),
		CFrame.new(sofaX, sofaBaseY, livingCenterZ - 2),
		PALETTE.FabricSofa,
		Enum.Material.Fabric
	)
	-- Respaldo Principal
	createPart(
		livingFolder,
		"SofaMainBackrest",
		Vector3.new(1.8, 3.2, 16),
		CFrame.new(sofaX - 2.8, sofaBaseY + 1.2, livingCenterZ - 2),
		PALETTE.FabricSofa,
		Enum.Material.Fabric
	)
	-- Módulo Chaise Longue (L-shape)
	createPart(
		livingFolder,
		"SofaChaiseBase",
		Vector3.new(9, 1.4, 5.5),
		CFrame.new(sofaX + 4.5, sofaBaseY, livingCenterZ + 3.25),
		PALETTE.FabricSofa,
		Enum.Material.Fabric
	)
	-- Cojines de Acento Terracota/Ocre
	createPart(
		livingFolder,
		"CushionA",
		Vector3.new(1.6, 1.6, 0.8),
		CFrame.new(sofaX - 1.2, sofaBaseY + 1.4, livingCenterZ - 6) * CFrame.Angles(0, math.rad(-15), math.rad(10)),
		PALETTE.FabricPillow,
		Enum.Material.Fabric
	)
	createPart(
		livingFolder,
		"CushionB",
		Vector3.new(1.6, 1.6, 0.8),
		CFrame.new(sofaX - 1.2, sofaBaseY + 1.4, livingCenterZ) * CFrame.Angles(0, math.rad(10), math.rad(10)),
		PALETTE.FabricPillow,
		Enum.Material.Fabric
	)

	-- Mesa de Centro Minimalista con Tapa de Cristal y Base de Nogal
	createPart(
		livingFolder,
		"CoffeeTableBase",
		Vector3.new(5, 0.4, 8),
		CFrame.new(sofaX + 5, FLOOR_Y + 1.6, livingCenterZ - 3),
		PALETTE.WoodDarkWalnut,
		Enum.Material.Wood
	)
	createPart(
		livingFolder,
		"CoffeeTableGlass",
		Vector3.new(5.4, 0.2, 8.4),
		CFrame.new(sofaX + 5, FLOOR_Y + 2.2, livingCenterZ - 3),
		PALETTE.GlassWindow,
		Enum.Material.Glass,
		true,
		0.4
	)
	-- Patas metálicas de la mesa de centro
	local tableLegs = {
		Vector3.new(-2.2, 0, -3.6),
		Vector3.new(2.2, 0, -3.6),
		Vector3.new(-2.2, 0, 3.6),
		Vector3.new(2.2, 0, 3.6),
	}
	for idx, offset in ipairs(tableLegs) do
		createPart(
			livingFolder,
			"TableLeg_" .. tostring(idx),
			Vector3.new(0.3, 1, 0.3),
			CFrame.new(sofaX + 5 + offset.X, FLOOR_Y + 1.6, livingCenterZ - 3 + offset.Z),
			PALETTE.MetalBlack,
			Enum.Material.Metal
		)
	end

	-- Lámpara de Pie de Arco Contemporánea
	createPart(
		livingFolder,
		"FloorLampBase",
		Vector3.new(2, 0.3, 2),
		CFrame.new(sofaX - 4, FLOOR_Y + 1.15, livingCenterZ - 8),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	createPart(
		livingFolder,
		"FloorLampPole",
		Vector3.new(0.3, 9, 0.3),
		CFrame.new(sofaX - 4, FLOOR_Y + 5.5, livingCenterZ - 8),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	local floorLampShade = createPart(
		livingFolder,
		"FloorLampShade",
		Vector3.new(1.8, 1.4, 1.8),
		CFrame.new(sofaX - 2.5, FLOOR_Y + 9.5, livingCenterZ - 7),
		PALETTE.LightWarm,
		Enum.Material.Neon,
		false
	)
	addPointLight(floorLampShade, 1.5, 14, PALETTE.LightWarm)

	-- Planta de Interior Ficus Lyrata en Maceta Nórdica
	createPart(
		decorFolder,
		"PlantPot",
		Vector3.new(2.2, 3, 2.2),
		CFrame.new(origin.X - (H_WIDTH / 2) + 3, FLOOR_Y + 2.5, origin.Z - (H_DEPTH / 2) + 3),
		PALETTE.PlantPot,
		Enum.Material.Marble
	)
	createPart(
		decorFolder,
		"PlantSoil",
		Vector3.new(1.9, 0.2, 1.9),
		CFrame.new(origin.X - (H_WIDTH / 2) + 3, FLOOR_Y + 3.9, origin.Z - (H_DEPTH / 2) + 3),
		Color3.fromRGB(45, 30, 20),
		Enum.Material.Ground
	)
	-- Hojas de la planta en diferentes alturas
	createPart(
		decorFolder,
		"PlantFoliageA",
		Vector3.new(2.6, 2.4, 2.6),
		CFrame.new(origin.X - (H_WIDTH / 2) + 3, FLOOR_Y + 5.2, origin.Z - (H_DEPTH / 2) + 3),
		PALETTE.PlantGreen,
		Enum.Material.Grass
	)
	createPart(
		decorFolder,
		"PlantFoliageB",
		Vector3.new(2, 2.2, 2),
		CFrame.new(origin.X - (H_WIDTH / 2) + 3, FLOOR_Y + 7, origin.Z - (H_DEPTH / 2) + 3),
		Color3.fromRGB(65, 135, 75),
		Enum.Material.Grass
	)

	----------------------------------------------------------------------
	-- 4. COCINA ABIERTA CON ISLA DE MÁRMOL EN CASCADA (GOURMET KITCHEN)
	----------------------------------------------------------------------
	local kitchenZ = origin.Z - (H_DEPTH / 2) + 6
	local kitchenCenterX = origin.X - 12

	-- Mueble Encimera Trasero (Bancada con Fregadero e Inducción)
	createPart(
		kitchenFolder,
		"KitchenBackCounter",
		Vector3.new(18, 3.2, 3),
		CFrame.new(kitchenCenterX, FLOOR_Y + 2.6, origin.Z - (H_DEPTH / 2) + 1.8),
		PALETTE.WoodDarkWalnut,
		Enum.Material.Wood
	)
	-- Encimera de mármol blanco posterior
	createPart(
		kitchenFolder,
		"KitchenBackTop",
		Vector3.new(18.2, 0.4, 3.2),
		CFrame.new(kitchenCenterX, FLOOR_Y + 4.3, origin.Z - (H_DEPTH / 2) + 1.8),
		PALETTE.MarbleWhite,
		Enum.Material.Marble
	)
	-- Placa de Inducción empotrada
	createPart(
		kitchenFolder,
		"InductionCooktop",
		Vector3.new(4, 0.1, 2.2),
		CFrame.new(kitchenCenterX - 4, FLOOR_Y + 4.52, origin.Z - (H_DEPTH / 2) + 1.8),
		PALETTE.MetalBlack,
		Enum.Material.Glass
	)
	-- Fregadero integrado con grifería negra mate
	createPart(
		kitchenFolder,
		"KitchenSink",
		Vector3.new(3.5, 0.2, 2.2),
		CFrame.new(kitchenCenterX + 4, FLOOR_Y + 4.45, origin.Z - (H_DEPTH / 2) + 1.8),
		Color3.fromRGB(150, 150, 155),
		Enum.Material.Metal
	)
	createPart(
		kitchenFolder,
		"KitchenFaucet",
		Vector3.new(0.3, 1.6, 0.8),
		CFrame.new(kitchenCenterX + 4, FLOOR_Y + 5.2, origin.Z - (H_DEPTH / 2) + 0.8),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	-- Campana extractora moderna suspendida
	createPart(
		kitchenFolder,
		"RangeHood",
		Vector3.new(4.5, 3.5, 2.4),
		CFrame.new(kitchenCenterX - 4, FLOOR_Y + H_HEIGHT - 3, origin.Z - (H_DEPTH / 2) + 2),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)

	-- ISLA DE COCINA EN CASCADA (Waterfall Marble Island)
	local islandX = kitchenCenterX
	local islandZ = kitchenZ + 6.5
	-- Cuerpo de la isla
	createPart(
		kitchenFolder,
		"IslandBody",
		Vector3.new(14, 3.2, 4.5),
		CFrame.new(islandX, FLOOR_Y + 2.6, islandZ),
		PALETTE.WallAccentCharcoal,
		Enum.Material.SmoothPlastic
	)
	-- Mármol superior
	createPart(
		kitchenFolder,
		"IslandTop",
		Vector3.new(15, 0.5, 5.2),
		CFrame.new(islandX, FLOOR_Y + 4.35, islandZ),
		PALETTE.MarbleWhite,
		Enum.Material.Marble
	)
	-- Caída en cascada izquierda y derecha
	createPart(
		kitchenFolder,
		"IslandWaterfallLeft",
		Vector3.new(0.5, 3.35, 5.2),
		CFrame.new(islandX - 7.25, FLOOR_Y + 2.65, islandZ),
		PALETTE.MarbleWhite,
		Enum.Material.Marble
	)
	createPart(
		kitchenFolder,
		"IslandWaterfallRight",
		Vector3.new(0.5, 3.35, 5.2),
		CFrame.new(islandX + 7.25, FLOOR_Y + 2.65, islandZ),
		PALETTE.MarbleWhite,
		Enum.Material.Marble
	)

	-- Taburetes de Bar Contemporáneos (Bar Stools)
	for i = -4.5, 4.5, 4.5 do
		local stoolX = islandX + i
		local stoolZ = islandZ + 3.8
		-- Pata esbelta negra
		createPart(
			kitchenFolder,
			"StoolLeg_" .. tostring(i),
			Vector3.new(0.3, 2.4, 0.3),
			CFrame.new(stoolX, FLOOR_Y + 2.2, stoolZ),
			PALETTE.MetalBlack,
			Enum.Material.Metal
		)
		-- Asiento tapizado en piel coñac
		createPart(
			kitchenFolder,
			"StoolSeat_" .. tostring(i),
			Vector3.new(1.8, 0.4, 1.8),
			CFrame.new(stoolX, FLOOR_Y + 3.5, stoolZ),
			PALETTE.FabricPillow,
			Enum.Material.Fabric
		)
	end

	-- Lámparas Colgantes de Latón sobre la Isla (Pendant Lights)
	for i = -4, 4, 4 do
		local pendX = islandX + i
		-- Cable fino
		createPart(
			lightingFolder,
			"PendantCord_" .. tostring(i),
			Vector3.new(0.1, 5, 0.1),
			CFrame.new(pendX, FLOOR_Y + H_HEIGHT - 3.5, islandZ),
			PALETTE.MetalBlack,
			Enum.Material.Metal
		)
		-- Campana de latón dorada
		createPart(
			lightingFolder,
			"PendantShade_" .. tostring(i),
			Vector3.new(1.4, 1.2, 1.4),
			CFrame.new(pendX, FLOOR_Y + H_HEIGHT - 6.2, islandZ),
			PALETTE.MetalBrass,
			Enum.Material.Metal
		)
		-- Bombilla cálida
		local bulb = createPart(
			lightingFolder,
			"PendantBulb_" .. tostring(i),
			Vector3.new(0.6, 0.6, 0.6),
			CFrame.new(pendX, FLOOR_Y + H_HEIGHT - 6.8, islandZ),
			PALETTE.LightWarm,
			Enum.Material.Neon,
			false
		)
		addPointLight(bulb, 1.4, 12, PALETTE.LightWarm)
	end

	----------------------------------------------------------------------
	-- 5. SUITE PRINCIPAL (MASTER BEDROOM)
	----------------------------------------------------------------------
	local bedCenterX = origin.X + (H_WIDTH / 2) - (bedWidth / 2)
	local bedCenterZ = origin.Z - 6

	-- Cabecero Acolchado Tapizado de Pared Completa
	createPart(
		bedroomFolder,
		"BedHeadboard",
		Vector3.new(16, 5.5, 0.8),
		CFrame.new(bedCenterX, FLOOR_Y + 3.75, origin.Z - (H_DEPTH / 2) + 0.8),
		PALETTE.WallAccentCharcoal,
		Enum.Material.Fabric
	)

	-- Base de Cama King-Size Flotante
	createPart(
		bedroomFolder,
		"BedFrame",
		Vector3.new(9.5, 1.2, 11),
		CFrame.new(bedCenterX, FLOOR_Y + 1.6, bedCenterZ),
		PALETTE.WoodOak,
		Enum.Material.Wood
	)

	-- Colchón de Alta Densidad con Sábanas Blancas
	createPart(
		bedroomFolder,
		"BedMattress",
		Vector3.new(9, 1.4, 10.5),
		CFrame.new(bedCenterX, FLOOR_Y + 2.8, bedCenterZ + 0.2),
		Color3.fromRGB(248, 248, 250),
		Enum.Material.Fabric
	)

	-- Edredón Plegado / Cubrecama Textil Gris
	createPart(
		bedroomFolder,
		"BedDuvet",
		Vector3.new(9.1, 0.5, 6.5),
		CFrame.new(bedCenterX, FLOOR_Y + 3.4, bedCenterZ + 2.2),
		PALETTE.FabricSofa,
		Enum.Material.Fabric
	)

	-- Almohadas Dobles Elegantes
	createPart(
		bedroomFolder,
		"PillowLeft",
		Vector3.new(3.5, 0.6, 2),
		CFrame.new(bedCenterX - 2.4, FLOOR_Y + 3.7, bedCenterZ - 3.8) * CFrame.Angles(math.rad(15), 0, 0),
		Color3.fromRGB(250, 250, 250),
		Enum.Material.Fabric
	)
	createPart(
		bedroomFolder,
		"PillowRight",
		Vector3.new(3.5, 0.6, 2),
		CFrame.new(bedCenterX + 2.4, FLOOR_Y + 3.7, bedCenterZ - 3.8) * CFrame.Angles(math.rad(15), 0, 0),
		Color3.fromRGB(250, 250, 250),
		Enum.Material.Fabric
	)

	-- Mesitas de Noche Flotantes a Ambos Lados
	local nightstandOffsets = { -6.5, 6.5 }
	for _, offset in ipairs(nightstandOffsets) do
		local nsX = bedCenterX + offset
		local nsZ = origin.Z - (H_DEPTH / 2) + 2.5
		-- Cajonera suspendida
		createPart(
			bedroomFolder,
			"Nightstand",
			Vector3.new(3, 1.2, 2.5),
			CFrame.new(nsX, FLOOR_Y + 2.4, nsZ),
			PALETTE.WoodDarkWalnut,
			Enum.Material.Wood
		)
		-- Lámpara de lectura cilíndrica con luz suave
		local lampShade = createPart(
			lightingFolder,
			"BedsideLamp",
			Vector3.new(1.2, 1.6, 1.2),
			CFrame.new(nsX, FLOOR_Y + 3.8, nsZ),
			PALETTE.LightWarm,
			Enum.Material.Neon,
			false
		)
		addPointLight(lampShade, 1, 8, PALETTE.LightWarm)
	end

	-- Cuadro de Arte Contemporáneo con Marco Negro Mate
	createPart(
		decorFolder,
		"ArtFrame",
		Vector3.new(10, 4.2, 0.3),
		CFrame.new(bedCenterX, FLOOR_Y + 8.8, origin.Z - (H_DEPTH / 2) + 0.8),
		PALETTE.MetalBlack,
		Enum.Material.Metal
	)
	createPart(
		decorFolder,
		"ArtCanvas",
		Vector3.new(9.4, 3.6, 0.1),
		CFrame.new(bedCenterX, FLOOR_Y + 8.8, origin.Z - (H_DEPTH / 2) + 0.95),
		Color3.fromRGB(225, 215, 195),
		Enum.Material.SmoothPlastic
	)

	-- Armario Empotrado de Puertas Correderas Japonesas
	createPart(
		bedroomFolder,
		"Wardrobe",
		Vector3.new(WALL_THICK + 1.2, H_HEIGHT - 2, 14),
		CFrame.new(origin.X + (H_WIDTH / 2) - 1.5, wallCenterY, origin.Z + 8),
		PALETTE.WoodOak,
		Enum.Material.Wood
	)

	----------------------------------------------------------------------
	-- 6. ILUMINACIÓN GENERAL EMPOTRADA (RECESSED ARCHITECTURAL DOWNLIGHTS)
	----------------------------------------------------------------------
	local ceilingLightY = FLOOR_Y + H_HEIGHT - 0.4
	local downlightPositions = {
		-- Salón
		Vector3.new(sofaX + 4, ceilingLightY, livingCenterZ - 4),
		Vector3.new(sofaX + 4, ceilingLightY, livingCenterZ + 4),
		-- Cocina
		Vector3.new(kitchenCenterX - 6, ceilingLightY, kitchenZ),
		Vector3.new(kitchenCenterX + 6, ceilingLightY, kitchenZ),
		-- Dormitorio
		Vector3.new(bedCenterX - 4, ceilingLightY, bedCenterZ + 5),
		Vector3.new(bedCenterX + 4, ceilingLightY, bedCenterZ + 5),
	}

	for idx, pos in ipairs(downlightPositions) do
		-- Aro decorativo negro
		createPart(
			lightingFolder,
			"DownlightTrim_" .. tostring(idx),
			Vector3.new(1.4, 0.1, 1.4),
			CFrame.new(pos),
			PALETTE.MetalBlack,
			Enum.Material.Metal
		)
		-- Foco LED empotrado cálido
		local spot = createPart(
			lightingFolder,
			"DownlightLED_" .. tostring(idx),
			Vector3.new(0.9, 0.12, 0.9),
			CFrame.new(pos.X, pos.Y - 0.05, pos.Z),
			PALETTE.LightWarm,
			Enum.Material.Neon,
			false
		)
		addPointLight(spot, 1.2, 18, PALETTE.LightWarm)
	end

	-- Ensamblar el modelo completo en Workspace
	house.Parent = Workspace
	print(string.format("✨ [HouseBuilder] Villa de diseño profesional generada con éxito en Workspace (%d objetos).", #house:GetDescendants()))

	return house
end

return HouseBuilder
