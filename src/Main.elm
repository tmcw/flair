module Main exposing (Msg(..), main, update, view)

import Browser
import Data exposing (IngredientType(..), Material, Recipe, recipes)
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
    , availableMaterials = Set.Any.empty materialKey -- Set.Any.fromList materialKey materials
    }


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


missingIngredients : MaterialSet -> Recipe -> MaterialSet
missingIngredients availableMaterials recipe =
    Set.Any.diff (getMaterials recipe) availableMaterials


recipesWithIngredient : List Recipe -> Material -> Int
recipesWithIngredient allRecipes ingredient =
    List.filter (\recipe -> Set.Any.member ingredient (getMaterials recipe)) allRecipes
        |> List.length


update : Msg -> Model -> Model
update msg model =
    case msg of
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
        , paddingEach { edges | bottom = 5, top = 10 }
        ]
        (text name)


typeMenu : Model -> IngredientType -> List (Element.Element Msg)
typeMenu model t =
    List.filter (\material -> material.t == t) model.materials
        |> List.sortBy (\ingredient -> -(recipesWithIngredient model.recipes ingredient))
        |> List.map (ingredientNavigationItem model)


listIngredients : Model -> Element.Element Msg
listIngredients model =
    Element.column [ spacing 8, alignTop ]
        (title "SPIRITS"
            :: typeMenu model Spirit
            ++ (title "SWEETENERS"
                    :: typeMenu model Sweetener
               )
            ++ (title "OTHER"
                    :: typeMenu model Other
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


recipeBlock : Model -> Recipe -> Element.Element Msg
recipeBlock model recipe =
    let
        viable =
            missingIngredients model.availableMaterials recipe |> Set.Any.isEmpty
    in
    Element.column
        [ spacing 10
        , padding 10
        , Border.color black
        , Border.width 1
        , if viable then
            Border.solid

          else
            Border.dashed
        , Element.width Element.fill
        , Element.height Element.fill
        , alignTop
        ]
        [ Element.el [ Font.italic, Font.underline ] (text recipe.name)
        , Element.paragraph []
            (List.intersperse
                (el [] (text ", "))
                (List.map
                    (\ingredient ->
                        el
                            (if Set.Any.member ingredient.material model.availableMaterials then
                                []

                             else
                                [ strike ]
                            )
                            (text ingredient.material.name)
                    )
                    recipe.ingredients
                )
            )
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


chunksOfLeft : Int -> List a -> List (List a)
chunksOfLeft k xs =
    if k == 0 then
        [ [] ]

    else if k < 0 then
        []

    else if List.length xs > k then
        List.take k xs :: chunksOfLeft k (List.drop k xs)

    else
        [ xs ]


listRecipes : Model -> Element.Element Msg
listRecipes model =
    let
        ( sufficient, unsortedInsufficient ) =
            List.partition
                (\recipe -> missingIngredients model.availableMaterials recipe |> Set.Any.isEmpty)
                model.recipes

        insufficient =
            List.sortBy (\recipe -> missingIngredients model.availableMaterials recipe |> Set.Any.size) unsortedInsufficient

        orderedChunkedRecipes =
            sufficient ++ insufficient |> chunksOfLeft 3
    in
    Element.column [ spacing 20, Element.width Element.fill ]
        (List.map
            (\recipes ->
                Element.row [ spacing 20 ] (List.map (recipeBlock model) recipes)
            )
            orderedChunkedRecipes
        )



--
--
-- displayOtherRecipe : MaterialSet -> Recipe -> Element.Element Msg
-- displayOtherRecipe availableMaterials recipe =
--     Element.column [ spacing 10 ]
--         [ Element.paragraph []
--             ([ el [ Font.bold, Font.underline ] (text recipe.name)
--              , text " ("
--              ]
--                 ++ List.intersperse
--                     (el [] (text ", "))
--                     (List.map
--                         (\ingredient ->
--                             el
--                                 (if Set.Any.member ingredient.material availableMaterials then
--                                     []
--
--                                  else
--                                     [ strike ]
--                                 )
--                                 (text ingredient.material.name)
--                         )
--                         recipe.ingredients
--                     )
--                 ++ [ text ")"
--                    ]
--             )
--         ]
-- listOtherRecipes : Model -> Element.Element Msg
-- listOtherRecipes model =
--     Element.column [ spacing 10 ]
--         (List.map (displayOtherRecipe model.availableMaterials) model.insufficient)


rightColumn : Model -> Element.Element Msg
rightColumn model =
    Element.column
        [ alignTop
        , padding 20
        , spacing 5
        , Element.width
            (Element.maximum 640 Element.fill)
        ]
        [ title "RECIPES"
        , listRecipes model
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
