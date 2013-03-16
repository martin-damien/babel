--[[

    Babel, a simple internationalisation tool for LÖVE 2D and standalone
    Lua applications (using lfs).
    Copyright (C) 2013  MARTIN Damien

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


    CONTRIBUTORS
    ------------

        KOLL Thomas R.

            Github:  http://github.com/TomK32
            Website: http://ananasblau.com

        YONABA Roland

            Github: http://github.com/Yonaba
            Website: http://yonaba.github.com

]]

local babel = {}

babel.current_locale  = nil     -- Remember the current locale
babel.debug           = false   -- Display debug informations
babel.locales_folders = {}      -- List of all the folders look in

-- We test if we are in a LÖVE application or not
-- This make Babel usable for LÖVE application and
-- standalone applications.

local in_love = love
local file_exists = function() end
local load = function() end

if not in_love then
    -- We are not in LÖVE so we must use lfs instead
    lfs = require "lfs"
    file_exists = function( file )
        local test, err_msg = lfs.attributes( file )
        if test then return true else return false end
    end
    load = function( file )
				local chunk, msg = loadfile(file)
				if not chunk then
					msg = msg:gsub('^%w+%.lua:%d+:','')
					return error(('Error reading locale file: "%s":\n\t%s'):format(file,msg),2)
				end
        return chunk
    end
else
    -- We are in LÖVE
    file_exists = love.filesystem.exists
    load = love.filesystem.load
end

--- Merge two tables in one. t2 elements will be added to t1 and t2 elements will
-- override existing elements in t2.
-- @param t1 The table who will be used to be merged.
-- @param t2 The tabls who will be merged with.
-- @return The merge tables.
local mergeTables = function( t1, t2 )

    for k, v in pairs( t2 ) do
        t1[k] = v
    end

    return t1

end

--- Init babel with the wished values.
-- @param settings A table with all the needed settings for babel.
babel.init = function( settings )

    babel.current_locale  = settings.locale or "en-UK"
    babel.locales_folders = settings.locales_folders or { "translations" }
    babel.debug           = settings.debug or false

    babel.switchLocale( babel.current_locale )

end

babel.reset = function()
    babel.dictionary      = {}      -- List of all the translations
    babel.formats         = {}      -- List of all the formats
end

--- Add a locales folder to the existing list.
-- @param folder The folder to look in.
babel.addLocalesFolder = function( folder )

    table.insert( babel.locales_folders, folder )
    babel.switchLocale() -- Reload current locale

end


--- Change current locale (can be used without parameters to reload current locale).
-- @param locale The locale to use.
babel.switchLocale = function( locale )

    locale = locale or babel.current_locale

    if not locale or locale == '' then
      return
    end

    babel.reset()

    for _, folder in pairs( babel.locales_folders ) do
				local locale_file = ("%s/%s.lua"):format(folder, locale)

        if file_exists( locale_file ) then

            if babel.debug then
                print( ("BABEL : Loading : %s"):format(locale_file))
            end

            local chunk = load( locale_file )
            language = chunk()
						babel.current_locale = locale
            babel.formats = mergeTables( babel.formats, language.formats or {} )
            babel.dictionary = mergeTables( babel.dictionary, language.translations or {} )

        else
					return error(('Cannot find locale file: "%s"'):format(locale_file))
				end

    end

end


--- Translate a string to the current locale (dynamic texts could be inserted)
-- @param string The text to translate.
-- @param parameters A list of all the dynamic elements in the string
babel.translate = function( str, parameters )

    local parameters = parameters or {}
    local translation

    if not babel.dictionary[str] then return end
    translation = babel.dictionary[str]

    -- Replace parameters
    for key, value in pairs( parameters ) do
        translation = translation:gsub( "%%" .. key .. "%%", value )
    end

    return translation

end


-- Function shortcut (gettext like)
_G._ = babel.translate


return babel
