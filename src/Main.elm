module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = 0, update = update, view = view }



--- methods should not be types, but they should be included
--- in the relativity matrix


type Ingredient
    = Whiskey
    | Gin
    | Brandy
    | Bitters
    | CitrusRind


type alias Recipe =
    { name : String
    , ingredients : List Ingredient
    , description : String
    }


recipes : List Recipe
recipes =
    [ { name = "Old Fashioned"
      , ingredients =
            [ Whiskey
            , Bitters
            , CitrusRind
            ]
      , description = """Stir"""
      }
    , { name = "Brandy Old Fashioned"
      , ingredients =
            [ Brandy
            , Bitters
            , CitrusRind
            ]
      , description = """Stir"""
      }
    ]


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


recipeNavigationItem : Recipe -> Html Msg
recipeNavigationItem recipe =
    div []
        [ div [] [ text recipe.name ] ]


listRecipes : List Recipe -> Html Msg
listRecipes items =
    div []
        (List.map recipeNavigationItem items)


view model =
    div []
        [ listRecipes recipes
        ]
