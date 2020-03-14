module Main exposing (Msg(..), main, update, view)

import Browser
import Data exposing (Material, Recipe, recipes)
import Element exposing (Element, alignTop, el, padding, paddingEach, spacing, text)
import Element.Background
import Element.Border as Border
import Element.Font as Font exposing (bold, strike)
import Element.Input as Input
import Html exposing (Html)
import Quantity exposing (Quantity(..), printQuantity)
import Set.Any exposing (AnySet)


type alias MaterialSet =
    AnySet String Material


type alias Model =
    { recipes : List Recipe
    , sufficient : List Recipe
    , insufficient : List Recipe
    , materials : List Material
    , selectedRecipe : Maybe Recipe
    , availableMaterials : MaterialSet
    }


materialKey : Material -> String
materialKey ingredient =
    ingredient.name


materials : List Material
materials =
    List.concatMap (\recipe -> List.map (\ingredient -> ingredient.material) recipe.ingredients) recipes
        |> List.foldl (::) []
        |> Set.Any.fromList materialKey
        |> Set.Any.toList


init : Model
init =
    { recipes = recipes
    , materials = materials
    , selectedRecipe = Nothing
    , availableMaterials = Set.Any.fromList materialKey materials
    , sufficient = []
    , insufficient = []
    }
        |> derive


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type Msg
    = SelectRecipe Recipe
    | ToggleIngredient Material Bool



--- Utils
--- Pure utilities.


getMaterials : Recipe -> MaterialSet
getMaterials recipe =
    List.map (\ingredient -> ingredient.material) recipe.ingredients
        |> Set.Any.fromList
            materialKey


hasIngredients : MaterialSet -> Recipe -> Bool
hasIngredients availableMaterials recipe =
    Set.Any.diff (getMaterials recipe) availableMaterials |> Set.Any.isEmpty


recipesWithIngredient : List Recipe -> Material -> Int
recipesWithIngredient allRecipes ingredient =
    List.filter (\recipe -> Set.Any.member ingredient (getMaterials recipe)) allRecipes
        |> List.length


derive : Model -> Model
derive model =
    let
        ( sufficient, insufficient ) =
            List.partition (hasIngredients model.availableMaterials) model.recipes
    in
    { model
        | sufficient = sufficient
        , insufficient = insufficient
    }


update : Msg -> Model -> Model
update msg model =
    derive
        (case msg of
            SelectRecipe recipe ->
                { model | selectedRecipe = Just recipe }

            ToggleIngredient ingredient checked ->
                { model
                    | availableMaterials =
                        if checked then
                            Set.Any.insert ingredient model.availableMaterials

                        else
                            Set.Any.remove ingredient model.availableMaterials
                }
        )


background =
    Element.rgb255 249 247 244


black =
    Element.rgb 0 0 0


checkboxIcon : Bool -> Element msg
checkboxIcon checked =
    Element.el
        [ Element.width (Element.px 10)
        , Element.height (Element.px 10)
        , Element.centerY
        , Border.rounded 5
        , Border.color black
        , Element.Background.color <|
            if checked then
                black

            else
                background
        , Border.width 1
        ]
        Element.none


ingredientNavigationItem : Model -> Material -> Element.Element Msg
ingredientNavigationItem model ingredient =
    let
        checked =
            Set.Any.member ingredient model.availableMaterials
    in
    Input.checkbox []
        { onChange = \_ -> ToggleIngredient ingredient (not checked)
        , icon = checkboxIcon
        , checked = checked
        , label =
            Input.labelRight []
                (text
                    (ingredient.name
                        ++ " ("
                        ++ String.fromInt (recipesWithIngredient model.recipes ingredient)
                        ++ ")"
                    )
                )
        }


edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


title : String -> Element.Element Msg
title name =
    Element.el
        [ bold
        , paddingEach { edges | bottom = 10 }
        ]
        (text name)


listIngredients : Model -> Element.Element Msg
listIngredients model =
    Element.column [ spacing 8, alignTop ]
        (title "CABINET"
            :: (List.sortBy (\ingredient -> -(recipesWithIngredient model.recipes ingredient)) model.materials
                    |> List.map (ingredientNavigationItem model)
               )
        )


leftColumn : Model -> Element.Element Msg
leftColumn model =
    Element.column
        [ spacing 5
        , padding 20
        , alignTop
        , Element.width
            Element.shrink
        ]
        [ listIngredients model
        ]


displayRecipe : Recipe -> Element.Element Msg
displayRecipe recipe =
    Element.column [ spacing 20 ]
        [ Element.el [ Font.italic, Font.underline ] (text recipe.name)
        , Element.row [ spacing 10 ]
            [ Element.column
                [ alignTop, spacing 8, Element.width (Element.px 200) ]
                (List.map
                    (\ingredient ->
                        Element.paragraph []
                            [ text
                                ("◦ "
                                    ++ printQuantity ingredient.quantity
                                    ++ " "
                                    ++ ingredient.material.name
                                )
                            ]
                    )
                    recipe.ingredients
                )
            , Element.paragraph [ alignTop, Element.width Element.fill ] [ text recipe.description ]
            ]
        ]


listRecipes : Model -> Element.Element Msg
listRecipes model =
    Element.column [ spacing 40 ]
        (List.map displayRecipe model.sufficient)


displayOtherRecipe : MaterialSet -> Recipe -> Element.Element Msg
displayOtherRecipe availableMaterials recipe =
    Element.column [ spacing 10 ]
        [ Element.paragraph []
            ([ el [ Font.bold, Font.underline ] (text recipe.name)
             , text " ("
             ]
                ++ List.intersperse
                    (el [] (text ", "))
                    (List.map
                        (\ingredient ->
                            el
                                (if Set.Any.member ingredient.material availableMaterials then
                                    []

                                 else
                                    [ strike ]
                                )
                                (text ingredient.material.name)
                        )
                        recipe.ingredients
                    )
                ++ [ text ")"
                   ]
            )
        ]


listOtherRecipes : Model -> Element.Element Msg
listOtherRecipes model =
    Element.column [ spacing 10 ]
        (List.map (displayOtherRecipe model.availableMaterials) model.insufficient)


rightColumn : Model -> Element.Element Msg
rightColumn model =
    Element.column
        [ alignTop
        , padding 20
        , spacing 5
        , Element.width
            (Element.maximum 640 Element.fill)
        ]
        [ title "WHAT YOU CAN MAKE"
        , listRecipes model
        , title "OTHER"
        , listOtherRecipes model
        ]


view : Model -> Html Msg
view model =
    Element.layout
        [ Element.Background.color background
        , padding 20
        , Font.size 15
        , Element.width Element.fill
        , Font.family
            [ Font.external
                { name = "IBM Plex Mono"
                , url = "https://fonts.googleapis.com/css?family=IBM+Plex+Mono"
                }
            , Font.sansSerif
            ]
        ]
        (Element.row
            [ Element.width Element.fill, Element.height Element.fill, spacing 40 ]
            [ leftColumn model, rightColumn model ]
        )
