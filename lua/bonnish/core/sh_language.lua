BonnishBase = BonnishBase or {}
BonnishBase.Lang = BonnishBase.Lang or {}

function BonnishBase.AddLanguage(lang, data)
    BonnishBase.Lang[lang] = BonnishBase.Lang[lang] or {}
    for k, v in pairs(data) do
        BonnishBase.Lang[lang][k] = v
    end
end

function BonnishBase.GetLang(key)
    local lang = BonnishBase.ServerConfig and BonnishBase.ServerConfig.Language or "en"
    if BonnishBase.Lang[lang] and BonnishBase.Lang[lang][key] then
        return BonnishBase.Lang[lang][key]
    end
    -- Fallback to english
    if BonnishBase.Lang["en"] and BonnishBase.Lang["en"][key] then
        return BonnishBase.Lang["en"][key]
    end
    return key
end

-- English Core
BonnishBase.AddLanguage("en", {
    -- Core Menu
    ["core_title"] = "Bonnish Utilities",
    ["core_subtitle"] = "Central Control Panel",
    ["tab_dashboard"] = "Dashboard",
    ["tab_config"] = "Configuration",
    ["status_installed"] = "Installed",
    ["status_update"] = "Update Available",
    ["status_missing"] = "Not Installed",
    ["status_unknown"] = "Unknown",
    ["your_addons"] = "Your Addons",
    ["no_addons_db"] = "No addons registered in the database.",
    ["installed_addons"] = "Installed Addons",
    ["no_addons_installed"] = "No addons installed",
    ["select_addon"] = "Select an addon",
    ["select_addon_sub"] = "Choose an installed addon on the left to configure it.",
    ["no_config"] = "No Configuration",
    ["no_config_sub"] = "This addon does not require additional configuration.",
    ["btn_discard"] = "Discard",
    ["btn_save"] = "Save Changes",
    ["btn_saved"] = "Saved!",
    ["add_item"] = "Add Item",
    ["type_here"] = "Type here...",
    ["btn_cancel"] = "Cancel",
    ["btn_add"] = "Add",
    ["no_jobs_found"] = "No jobs found",
    ["category"] = "CATEGORY",
    ["add_to"] = "Add to "
})

-- Spanish Core
BonnishBase.AddLanguage("es", {
    -- Core Menu
    ["core_title"] = "Bonnish Utilities",
    ["core_subtitle"] = "Panel de Control Central",
    ["tab_dashboard"] = "Panel Central",
    ["tab_config"] = "Configuración",
    ["status_installed"] = "Instalado",
    ["status_update"] = "Actualización Disp.",
    ["status_missing"] = "No Instalado",
    ["status_unknown"] = "Desconocido",
    ["your_addons"] = "Tus Addons",
    ["no_addons_db"] = "No hay addons registrados en la base de datos.",
    ["installed_addons"] = "Addons Instalados",
    ["no_addons_installed"] = "No hay addons instalados",
    ["select_addon"] = "Selecciona un addon",
    ["select_addon_sub"] = "Elige un addon instalado a la izquierda para configurarlo.",
    ["no_config"] = "Sin Configuración",
    ["no_config_sub"] = "Este addon no requiere configuración adicional.",
    ["btn_discard"] = "Descartar",
    ["btn_save"] = "Guardar Cambios",
    ["btn_saved"] = "¡Guardado!",
    ["add_item"] = "Añadir Ítem",
    ["type_here"] = "Escribe aquí...",
    ["btn_cancel"] = "Cancelar",
    ["btn_add"] = "Añadir",
    ["no_jobs_found"] = "No se encontraron trabajos",
    ["category"] = "CATEGORÍA",
    ["add_to"] = "Añadir a "
})
