LOCALE = {

    formats = {

        currency = {

            symbol = "€",
            name = "Euro",
            short_name = "EUR",
            decimal_symbol = ",",
            thousand_separator = ".",
            fract_digits = 2,
            positive_symbol = "",
            negative_symbol = "-",
            positive_format = "%c %p%q",
            negative_format = "%c %p%q"

        },

        number = {

            decimal_symbol = ",",
            thousand_separator = ".",
            fract_digits = 2,
            positive_symbol = "",
            negative_symbol = "-"

        },

        date_time = {

            long_time = "%H:%i:%s",
            short_time = "%H:%i",
            long_date = "%l %d %F %Y",
            short_date = "%d-%m-%Y",
            long_date_time = "%l %d %F %Y %H.%i uur",   -- The time should not start with a zero: 8.30 uur
            short_date_time = "%d-%m-%Y %H:%i:%s"

        },

        short_month_names = {

            "jan", "feb", "mrt", "apr", "mei", "jun", "jul", "aug", "sep",
            "okt", "nov", "dec"

        },

        long_month_names = {

            "januari", "februari", "maart", "april", "mei", "juni", "juli",
            "augustus", "september", "oktober", "november", "december"

        },

        short_day_names = {

            "ma", "di", "wo", "do", "vr", "za", "zo"

        },

        long_day_names = {

            "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag",
            "zondag"

        }

    }

}
return LOCALE
