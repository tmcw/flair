module Quantity exposing (Quantity(..), printQuantity)


type Quantity
    = Dashes Int
    | FewDashes
    | Splash
    | Ml Float
    | Oz Float
    | Cl Float
    | Tsp Float
    | Cube Int
    | Sprigs Int
    | Drops Int
    | Custom String
    | None


printQuantity : Quantity -> String
printQuantity quantity =
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

        Ml a ->
            String.fromFloat a ++ " Ml"

        Oz a ->
            String.fromFloat a ++ " Oz"

        Cl a ->
            String.fromFloat a ++ " Cl"

        Tsp a ->
            String.fromFloat a ++ " Tsp"

        None ->
            ""
