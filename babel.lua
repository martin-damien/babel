--[[

    Babel
    Simple internationalisation tools for LÖVE 2D

    Author : MARTIN Damien
    License : GNU/GPL3+

]]

babel = {}

babel.current_locale = nil
babel.locales_path   = nil
babel.dictionary     = {}
babel.formats        = {}

babel.init = function( settings )

    babel.current_locale = settings.locale or "eng-UK"
    babel.locales_path   = settings.locales_path or "translations"

    babel.switchLocale( babel.current_locale )

end

babel.switchLocale = function( locale )

    if love.filesystem.exists( babel.locales_path .. "/" .. locale .. ".lua" ) then

        babel.current_locale = locale

        chunk = love.filesystem.load( babel.locales_path .. "/" .. locale .. ".lua" )
        language = chunk()

        babel.formats    = language.formats or {}
        babel.dictionary = language.translations or {}

    end

end

function babel.translate( string, parameters )

    local parameters = parameters or {}
    local translation = string

    if babel.dictionary[string] ~= nil then
        translation = babel.dictionary[string]
    else

    end

    -- Replace parameters
    for key, value in pairs( parameters ) do
        translation = translation:gsub( "%%" .. key .. "%%", value )
    end

    return translation

end

-- Function shortcut (gettext like)
_ = babel.translate
