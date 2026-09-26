# Proyecto Roblox - Guía del Equipo

Este repositorio contiene la arquitectura de código para el juego de Roblox, sincronizado mediante **Rojo** y versionado con **Git**.

## 📁 Estructura del Proyecto

* `src/server`: Scripts que corren exclusivamente en el servidor (`ServerScriptService.Server`).
* `src/client`: LocalScripts que corren en el dispositivo del jugador (`StarterPlayerScripts.Client`).
* `src/shared`: ModuleScripts compartidos entre cliente y servidor (`ReplicatedStorage.Shared`).
* `default.project.json`: Mapeo de Rojo hacia el DataModel de Roblox.

---

## 🚀 Cómo empezar a trabajar (Colaboradores)

### 1. Requisitos
* [Visual Studio Code](https://code.visualstudio.com/)
* [Git](https://git-scm.com/)
* Extensión de VS Code: **Rojo** (`evaera.vscode-rojo`)
* Plugin de Roblox Studio: **Rojo 7** (Instalado desde Plugins en Studio)

### 2. Flujo de Desarrollo (Para no pisarse el trabajo)
1. **Actualizar el código base:**
   ```bash
   git checkout main
   git pull origin main
   ```
2. **Crear una rama para tu tarea:**
   ```bash
   git checkout -b feature/nombre-de-tu-mecanica
   ```
3. **Probar en Roblox Studio:**
   * Abre VS Code: Presiona `Ctrl + Shift + P` -> `Rojo: Start Server`.
   * Abre Roblox Studio en un **Place de Pruebas personal** (un Baseplate vacío o una copia local).
   * En Studio, ve a la pestaña **Plugins** -> haz clic en el icono de **Rojo** -> **Connect**.
   * Realiza tus cambios y prueba el funcionamiento.
4. **Guardar y subir tu código:**
   ```bash
   git add .
   git commit -m "feat: descripción de lo que implementaste"
   git push origin feature/nombre-de-tu-mecanica
   ```
5. **Crear Pull Request en GitHub:**
   * Abre GitHub y solicita la revisión de tu rama hacia `main`.
   * Una vez aceptado y unido el código, el Líder Técnico sincroniza la versión final al juego oficial.

> ⚠️ **REGLA DE ORO:** Nunca conecten dos personas el plugin de Rojo al mismo tiempo dentro de la misma sesión de Team Create.
