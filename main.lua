-- Include Babel to your project
require "babel"

function love.load()

    -- Init Babel with your custom values
    babel.init({
        locale = "fre-FR",
        locales_folders = {
            "translations",
            "custom/translations"
        }
    })

end

function love.update(dt)

end

function love.draw()

    love.graphics.print( _( "Hello world" ), 10, 10 )
    love.graphics.print( _( "My name is %name%", { name = "Damien" } ), 10, 30 )

end
