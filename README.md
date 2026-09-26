# Mi Juego Roblox 🎮

Proyecto desarrollado con **Roblox Studio**, **Rojo** y **Git**.

---

## 🚀 Guía de Inicio Rápido para Colaboradores

### Requisitos Previos
1. Tener instalado [Roblox Studio](https://www.roblox.com/create).
2. Tener instalado [Visual Studio Code](https://code.visualstudio.com/).
3. Instalar la extensión **Rojo** en VS Code (de *evaera*).
4. Instalar el plugin **Rojo** en Roblox Studio (de *LPGhatguy* en la Toolbox de Plugins).

### Cómo trabajar en este proyecto
1. **Clonar el repositorio:**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd mi-juego-roblox
   ```
2. **Crear una rama para tu tarea (nunca programar directo en `main`):**
   ```bash
   git checkout -b feature/mi-nueva-mecanica
   ```
3. **Iniciar el servidor local de Rojo:**
   - En VS Code, presiona `Ctrl + Shift + P` (o `Cmd + Shift + P` en Mac).
   - Escribe y selecciona `Rojo: Start Server`.
4. **Conectar Roblox Studio:**
   - Abre un Place en Roblox Studio (un Baseplate o el place de pruebas).
   - Ve a la pestaña **Plugins** > Clic en **Rojo** > Clic en **Connect**.
5. **Subir tus cambios:**
   ```bash
   git add .
   git commit -m "feat: agregada nueva mecánica de salto"
   git push origin feature/mi-nueva-mecanica
   ```
   - Abre un **Pull Request** en GitHub para que el equipo revise tu código antes de fusionarlo a `main`.

---

## 📁 Estructura del Proyecto

* `src/server/` -> Se sincroniza en `ServerScriptService.Server` (código solo del servidor).
* `src/client/` -> Se sincroniza en `StarterPlayer.StarterPlayerScripts.Client` (código del jugador).
* `src/shared/` -> Se sincroniza en `ReplicatedStorage.Shared` (módulos compartidos cliente-servidor).