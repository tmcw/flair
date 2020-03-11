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
    | Drops Int
    | None


printQuantity : Quantity -> String
printQuantity quantity =
    case quantity of
        Dashes a ->
            if a == 1 then
                "1 dash"

            else
                String.fromInt a ++ " dashes"

        FewDashes ->
            "Few dashes"

        Splash ->
            "Splash"

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
