module Quantity exposing (Quantity(..), Units(..), printQuantity)


type Quantity
    = Dashes Int
    | FewDashes
    | Splash
    | CL Float
    | Tsp Float
    | Cube Int
    | Sprigs Int
    | Drops Int
    | Custom String
    | None


type Units
    = Ml
    | Oz
    | Cl


printQuantity : Units -> Quantity -> String
printQuantity units quantity =
    case quantity of
        Dashes a ->
            if a == 1 then
                "1 dash"

            else
                String.fromInt a ++ " dashes"

        Sprigs a ->
            if a == 1 then
                "1 sprig"

            else
                String.fromInt a ++ " sprigs"

        FewDashes ->
            "Few dashes"

        Splash ->
            "Splash"

        Custom str ->
            str

        Cube a ->
            if a == 1 then
                "1 cube"

            else
                String.fromInt a ++ " cube"

        Drops a ->
            String.fromInt a ++ " drops"

        CL a ->
            case units of
                Cl ->
                    String.fromFloat a ++ " Cl"

                Ml ->
                    String.fromFloat (a * 10) ++ " Ml"

                Oz ->
                    String.fromFloat (toFloat (floor (a * 0.3519503 * 100)) / 100) ++ " Cl"

        Tsp a ->
            String.fromFloat a ++ " Tsp"

        None ->
            ""
