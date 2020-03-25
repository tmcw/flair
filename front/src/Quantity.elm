module Quantity exposing (Quantity(..), Units(..), printQuantity)


type Quantity
    = CL Float
    | Cube Int
    | Dash Int
    | Drop Int
    | FewDrops
    | FewDashes
    | Slice Float
    | Splash Int
    | Sprig Int
    | Tsp Float
    | Wedge Int
    | Whole Int
    | Custom String
    | None


type Units
    = Cl
    | Ml
    | Oz


formatInteger : Float -> String
formatInteger d =
    if floor d == 0 then
        ""
    else
      String.fromInt (floor d)


-- Expects number between 0 and 100, floored.
formatFractional : Float -> String
formatFractional d =
    if d == 0 then
        ""
    else if d == 10 then
        "⅒"
    else if d == 11 then
        "⅑"
    else if d == 12 then
        "⅛"
    else if d == 14 then
        "⅐"
    else if d == 16 then
        "⅙"
    else if d == 20 then
        "⅕"
    else if d == 25 then
        "¼"
    else if d == 33 then
        "⅓"
    else if d == 37 then
        "⅜"
    else if d == 40 then
        "⅖"
    else if d == 50 then
        "½"
    else if d == 60 then
        "⅗"
    else if d == 62 then
        "⅝"
    else if d == 66 then
        "⅔"
    else if d == 75 then
        "¾"
    else if d == 80 then
        "⅘"
    else if d == 83 then
        "⅚"
    else if d == 87 then
        "⅞"
    else
        "." ++ String.fromFloat d


formatFloat : Float -> String
formatFloat d =
    formatInteger d ++ formatFractional ( toFloat ( floor ( ( d - toFloat ( floor d ) ) * 100 ) ) )


plural : String -> String -> Int -> String
plural word suffix d =
    if d == 1 then
        word
    else
        word ++ suffix


printQuantity : Units -> Quantity -> String
printQuantity units quantity =
    case quantity of
        CL a ->
            case units of
                Cl ->
                    formatFloat a ++ " Cl"

                Ml ->
                    formatFloat (a * 10) ++ " Ml"

                Oz ->
                    formatFloat (a * 1 / 3) ++ " Oz"

        Cube a ->
            String.fromInt a ++ plural " cube" "s" a

        Dash a ->
            String.fromInt a ++ plural " dash" "es" a

        Drop a ->
            String.fromInt a ++ plural " drop" "s" a

        FewDrops ->
            "Few drops"

        FewDashes ->
            "Few dashes"

        Slice a ->
            formatFloat a ++ plural " slice" "s" ( floor a )

        Splash a ->
            String.fromInt a ++ plural " splash" "es" a

        Sprig a ->
            String.fromInt a ++ plural " sprig" "s" a

        Tsp a ->
            formatFloat a ++ " Tsp"

        Wedge a ->
            String.fromInt a ++ plural " wedge" "s" a

        Whole a ->
            String.fromInt a

        Custom str ->
            str

        None ->
            ""
