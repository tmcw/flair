module Quantity exposing (Quantity(..), printQuantity)


type Quantity
    = Dashes Int
    | FewDashes
    | Ml Float
    | Oz Float
    | Cl Float
    | Tsp Float
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
