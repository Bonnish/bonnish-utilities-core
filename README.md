# Bonnish Utilities - Core

**Bonnish Utilities Core** is the foundational framework for the entire Bonnish Garry's Mod addon ecosystem. It provides a centralized, modern, and high-performance user interface for server owners to seamlessly manage, configure, and monitor all their compatible modules from a single dashboard.

[![Steam Workshop](https://img.shields.io/badge/Steam-Workshop-blue?logo=steam)](https://steamcommunity.com/sharedfiles/filedetails/?id=3740098135)

## ✨ Key Features

- 🖥️ **Centralized Dashboard:** A unified, highly aesthetic control panel accessible via the **Context Menu (Hold C)** to manage all installed Bonnish addons.
- 🌍 **Multi-Language Support (i18n):** Native real-time localization (English/Spanish) that updates UI elements dynamically without requiring server restarts.
- 💾 **Cross-Server Synchronization:** Native asynchronous MySQL database support (via MySQLOO) with a bulletproof fallback to local JSON if the database isn't available.
- 🔐 **Universal Admin Compatibility:** Out-of-the-box support for popular permission systems like **ULX, SAM, ServerGuard, and FAdmin**.
- ⚙️ **Developer API:** An extremely simple registration system to create and integrate your own custom addons into the ecosystem.

## 📥 Installation

The Core module is meant to be automatically downloaded by clients when joining the server. 

**Option 1: Steam Workshop (Recommended)**
Add the addon to your server's workshop collection:
👉 [**Bonnish Utilities Core on Steam Workshop**](https://steamcommunity.com/sharedfiles/filedetails/?id=3740098135)

**Option 2: Manual Installation**
1. Download this repository as a `.zip`.
2. Extract and rename the folder to `bonnish-utilities-core`.
3. Drop it into your `garrysmod/addons/` folder.

> ⚠️ **IMPORTANT:** Server configuration (Database, Permissions, Language) is handled in a separate, secure repository. You must install the [**Bonnish Utilities Config**](https://github.com/Bonnish/bonnish-utilities-config) locally on your server.

## 💻 Developer API

Want to make your own addon compatible with the Bonnish Dashboard? It's as simple as registering it during the initialization phase:

```lua
if BonnishBase and BonnishBase.RegisterAddon then
    BonnishBase.RegisterAddon({
        id = "my_custom_addon",
        name = "My Awesome Addon",
        version = "1.0",
        workshop = "https://steamcommunity.com/sharedfiles/filedetails/?id=...",
        settings = {
            { type = "boolean", id = "enable_feature", name = "Enable Awesome Feature", desc = "Turns the feature on or off.", default = true },
            { type = "string", id = "chat_command", name = "Chat Command", desc = "Command to open the menu.", default = "!awesome" }
        }
    })
end
```

The Core will automatically parse your `settings` table, render beautiful UI toggles/inputs in the dashboard, and handle all the networking and database saving for you. You can then retrieve your saved configuration simply by calling:
```lua
local cfg = BonnishBase.GetConfig("my_custom_addon")
print(cfg.enable_feature)
```
