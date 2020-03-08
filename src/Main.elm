module Main exposing (Msg(..), main, update, view)

import Browser
import Element
import Element.Font
import Element.Input
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
    , ingredients : IngredientSet
    , description : String
    }


recipes : List Recipe
recipes =
    [ { name = "Old Fashioned"
      , ingredients =
            Set.Any.fromList
                ingredientKey
                [ whiskey
                , bitters
                , citrusRind
                ]
      , description = """Stir"""
      }
    , { name = "Brandy Old Fashioned"
      , ingredients =
            Set.Any.fromList
                ingredientKey
                [ brandy
                , bitters
                , citrusRind
                ]
      , description = """Stir"""
      }
    , { name = "Negroni"
      , ingredients =
            Set.Any.fromList
                ingredientKey
                [ gin
                , sweetRedVermouth
                , campari
                ]
      , description = """Stir"""
      }
    ]


type Msg
    = SelectRecipe Recipe
    | ToggleIngredient Ingredient


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectRecipe recipe ->
            { model | selectedRecipe = Just recipe }

        ToggleIngredient ingredient ->
            { model | availableIngredients = Set.Any.toggle ingredient model.availableIngredients }


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
            [ onClick (ToggleIngredient ingredient)
            ]
            [ text
                (if Set.Any.member ingredient ingredientSet then
                    ingredient.name ++ " -"

                 else
                    ingredient.name ++ " +"
                )
            ]
        ]


listIngredients : IngredientSet -> List Ingredient -> Html Msg
listIngredients availableIngredients items =
    div []
        (List.map (ingredientNavigationItem availableIngredients) items)


listRecipes : List Recipe -> Html Msg
listRecipes items =
    div []
        (List.map recipeNavigationItem items)


hasIngredients : IngredientSet -> Recipe -> Bool
hasIngredients availableIngredients recipe =
    Set.Any.isEmpty (Set.Any.diff recipe.ingredients availableIngredients)


whatYouCanMake : IngredientSet -> List Recipe -> List Recipe
whatYouCanMake availableIngredients allRecipes =
    List.filter (hasIngredients availableIngredients) allRecipes


view : Model -> Html Msg
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
        , Html.h2 [] [ text "What you can make with your ingredients" ]
        , listRecipes (whatYouCanMake model.availableIngredients model.recipes)
        ]
