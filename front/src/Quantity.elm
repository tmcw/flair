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


printQuantity : Units -> Quantity -> String
printQuantity units quantity =
    case quantity of
        CL a ->
            case units of
                Cl ->
                    String.fromFloat a ++ " Cl"

                Ml ->
                    String.fromFloat (a * 10) ++ " Ml"

                Oz ->
                    String.fromFloat (toFloat (floor (a * 0.3519503 * 100)) / 100) ++ " Oz"

        Cube a ->
            if a == 1 then
                "1 cube"

            else
                String.fromInt a ++ " cube"


        Dash a ->
            if a == 1 then
                "1 dash"

            else
                String.fromInt a ++ " dashes"

        Drop a ->
            if a == 1 then
                "1 drop"

            else
                String.fromInt a ++ " drops"

        FewDrops ->
            "Few drops"

        FewDashes ->
            "Few dashes"

        Slice a ->
            if a == 0.5 then
                "Half slice"

            else if a == 1 then
                "1 slice"

            else
                String.fromFloat a ++ " slices"

        Splash a ->
            if a == 1 then
                "Splash"

            else
                String.fromInt a ++ " splashes"

        Sprig a ->
            if a == 1 then
                "1 sprig"

            else
                String.fromInt a ++ " sprigs"

        Tsp a ->
            String.fromFloat a ++ " Tsp"

        Wedge a ->
            if a == 1 then
                "1 wedge"

            else
                String.fromInt a ++ " wedges"

        Whole a ->
            String.fromInt a

        Custom str ->
            str

        None ->
            ""
