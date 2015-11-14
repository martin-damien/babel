describe( "Babel functionalities #lib", function()

    local babel

    --- Initialize babel and load test translations from the
    -- tests/translations folder.
    setup( function()

        babel = require "babel"
        babel.init( {
            locale = "fr-FR"
        } )

        ---
        -- Add local folder folder on demand
        babel.addLocalesFolder( "tests/translations" )

    end)

    ---
    -- Test that the functions are available
    describe( "Functions", function()

        it ( "_ shortcut is available in clean environement", function()
            assert.same( _, babel.translate )
        end)

    end)

end)
