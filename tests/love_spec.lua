describe("Fake Löve2D", function()
    
    local babel

    -- Mock Löve2D
    local love = {
        filesystem = {
            exists = function() end,
            load = function() end
        }
    }

    setup( function()

        babel = require "babel"
        babel.init( {
            locale = "fr_FR",
            locales_folders = { "tests/translations" }
        } )

    end)

    describe( "Simple text", function()

    end)
    
end)
