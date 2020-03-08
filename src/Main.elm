module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Set.Any exposing (AnySet)


type alias IngredientSet =
    AnySet String Ingredient


type alias Model =
    { recipes : List Recipe
    , ingredients : List Ingredient
    , selectedRecipe : Maybe Recipe
    , availableIngredients : IngredientSet
    }


ingredientKey : Ingredient -> String
ingredientKey ingredient =
    ingredient.name


init : Model
init =
    { recipes = recipes
    , ingredients = ingredients
    , selectedRecipe = Nothing
    , availableIngredients = Set.Any.empty ingredientKey
    }


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Ingredient =
    { name : String
    }


whiskey =
    { name = "Whiskey" }


gin =
    { name = "Gin" }


brandy =
    { name = "Brandy" }


bitters =
    { name = "Bitters" }


citrusRind =
    { name = "Citrus rind" }


sweetRedVermouth =
    { name = "Sweet red vermouth" }


campari =
    { name = "Campari" }


ingredients =
    [ whiskey
    , gin
    , brandy
    , bitters
    , citrusRind
    , sweetRedVermouth
    , campari
    ]


type alias Recipe =
    { name : String
    , ingredients : List Ingredient
    , description : String
    }


recipes : List Recipe
recipes =
    [ { name = "Old Fashioned"
      , ingredients =
            [ whiskey
            , bitters
            , citrusRind
            ]
      , description = """Stir"""
      }
    , { name = "Brandy Old Fashioned"
      , ingredients =
            [ brandy
            , bitters
            , citrusRind
            ]
      , description = """Stir"""
      }
    , { name = "Negroni"
      , ingredients =
            [ gin
            , sweetRedVermouth
            , campari
            ]
      , description = """Stir"""
      }
    ]


type Msg
    = SelectRecipe Recipe
    | AddIngredient Ingredient
    | RemoveIngredient Ingredient


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectRecipe recipe ->
            { model | selectedRecipe = Just recipe }

        AddIngredient ingredient ->
            { model | availableIngredients = Set.Any.insert ingredient model.availableIngredients }

        RemoveIngredient ingredient ->
            { model | availableIngredients = Set.Any.remove ingredient model.availableIngredients }


recipeNavigationItem : Recipe -> Html Msg
recipeNavigationItem recipe =
    div []
        [ button
            [ onClick (SelectRecipe recipe)
            ]
            [ text recipe.name ]
        ]


ingredientNavigationItem : IngredientSet -> Ingredient -> Html Msg
ingredientNavigationItem ingredientSet ingredient =
    div []
        [ button
            [ onClick
                (if Set.Any.member ingredient ingredientSet then
                    RemoveIngredient ingredient

                 else
                    AddIngredient ingredient
                )
            ]
            [ text ingredient.name ]
        ]


listIngredients : IngredientSet -> List Ingredient -> Html Msg
listIngredients availableIngredients items =
    div []
        (List.map (ingredientNavigationItem availableIngredients) items)


listRecipes : List Recipe -> Html Msg
listRecipes items =
    div []
        (List.map recipeNavigationItem items)


listAvailableIngredients : IngredientSet -> Html Msg
listAvailableIngredients items =
    div []
        (List.map (ingredientNavigationItem items) (Set.Any.toList items))


view model =
    div []
        [ Html.h2 [] [ text "Recipes" ]
        , listRecipes model.recipes
        , Html.h2 [] [ text "Ingredients" ]
        , listIngredients model.availableIngredients model.ingredients
        , Html.h2 [] [ text "Selected recipe" ]
        , div []
            [ text
                (case model.selectedRecipe of
                    Just recipe ->
                        recipe.name

                    Nothing ->
                        ""
                )
            ]
        , Html.h2 [] [ text "Available ingredients" ]
        , listAvailableIngredients model.availableIngredients
        ]
