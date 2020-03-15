module Main exposing (Msg(..), main, update, view)

import Browser
import Data exposing (IngredientType(..), Material, Recipe, recipes)
import Element exposing (Element, alignTop, centerX, el, html, padding, paddingEach, paddingXY, spacing, text)
import Element.Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font exposing (bold, strike)
import Element.Input as Input
import Html exposing (Html, option, select)
import Html.Attributes exposing (value)
import Html.Events
import Quantity exposing (Quantity(..), Units(..), printQuantity)
import Set.Any exposing (AnySet)


type alias MaterialSet =
    AnySet String Material


type Mode
    = Normal
    | Grid


type alias Model =
    { recipes : List Recipe
    , materials : List Material
    , selectedRecipe : Maybe Recipe
    , availableMaterials : MaterialSet
    , units : Units
    , mode : Mode
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
    , selectedRecipe = List.head recipes
    , availableMaterials = Set.Any.empty materialKey -- Set.Any.fromList materialKey materials
    , units = Ml
    , mode = Grid
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
    | SetUnits Units
    | SetMode Mode



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

        SetUnits units ->
            { model | units = units }

        ToggleIngredient ingredient checked ->
            { model
                | availableMaterials =
                    if checked then
                        Set.Any.insert ingredient model.availableMaterials

                    else
                        Set.Any.remove ingredient model.availableMaterials
            }

        SetMode mode ->
            { model | mode = mode }


background =
    Element.rgb255 249 247 244


selectedColor =
    Element.rgb255 239 237 234


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
            ++ (title "VERMOUTH"
                    :: typeMenu model Vermouth
               )
            ++ (title "BITTERS"
                    :: typeMenu model Bitters
               )
            ++ (title "GARNISH"
                    :: typeMenu model Garnish
               )
            ++ (title "OTHER"
                    :: typeMenu model Other
               )
        )


recipeBlock : Model -> Recipe -> Element.Element Msg
recipeBlock model recipe =
    let
        viable =
            missingIngredients model.availableMaterials recipe |> Set.Any.isEmpty

        selected =
            model.selectedRecipe == Just recipe
    in
    Element.column
        [ spacing 10
        , Element.pointer
        , padding 10
        , Element.Background.color
            (if selected then
                selectedColor

             else
                background
            )
        , Element.width Element.fill
        , Element.height Element.fill
        , alignTop
        , onClick (SelectRecipe recipe)
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


noneSelected : Element.Element Msg
noneSelected =
    Element.column [ spacing 20, alignTop ]
        [ Element.el [ Font.italic, Font.underline ] (text "Nothing selected")
        ]


displayRecipe : Model -> Recipe -> Element.Element Msg
displayRecipe model recipe =
    Element.column [ spacing 20, alignTop ]
        [ title recipe.name
        , Element.column
            [ alignTop, spacing 8 ]
            (List.map
                (\ingredient ->
                    Element.paragraph []
                        [ text
                            ("◦ "
                                ++ printQuantity model.units ingredient.quantity
                                ++ " "
                                ++ ingredient.material.name
                            )
                        ]
                )
                recipe.ingredients
            )
        , Element.paragraph [ alignTop, Element.width Element.fill ] [ text recipe.description ]
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

        orderedRecipes =
            sufficient ++ insufficient
    in
    Element.column [ spacing 10, Element.width Element.fill ]
        (List.map
            (recipeBlock model)
            orderedRecipes
        )


header : Model -> Element.Element Msg
header model =
    Element.row [ Element.width Element.fill, padding 20 ]
        [ Input.radioRow
            [ spacing 20
            ]
            { onChange = SetMode
            , selected = Just model.mode
            , label = Input.labelHidden "Mode"
            , options =
                [ Input.option Normal (text "List")
                , Input.option Grid (text "Grid")
                ]
            }
        , Element.el
            [ paddingEach
                { left = 40
                , top = 0
                , bottom = 0
                , right = 5
                }
            ]
            (text "Units")
        , select []
            [ option [ value "Ml", Html.Events.onClick (SetUnits Ml) ]
                [ Html.text "Ml"
                ]
            , option [ value "Cl", Html.Events.onClick (SetUnits Cl) ]
                [ Html.text "Cl"
                ]
            , option [ value "Oz", Html.Events.onClick (SetUnits Oz) ]
                [ Html.text "Oz"
                ]
            ]
            |> html
        ]


renderDot : Material -> Recipe -> Element.Element Msg
renderDot material row =
    let
        on =
            Set.Any.member
                material
                (Set.Any.fromList materialKey
                    (List.map (\i -> i.material) row.ingredients)
                )
    in
    Element.el [ padding 10, centerX ]
        (Element.el
            [ Element.width (Element.px 10)
            , Element.height (Element.px 10)
            , padding 5
            , Element.centerY
            , Border.rounded 5
            , Border.color black
            , Element.Background.color <|
                if on then
                    black

                else
                    background
            , Border.width 1
            ]
            Element.none
        )


getColumn : Material -> Element.Column Recipe Msg
getColumn material =
    { header = Element.el [ padding 10, bold, Element.alignBottom ] (Element.paragraph [] [ Element.text material.name ])
    , width = Element.fill
    , view = renderDot material
    }


gridView : Model -> Element.Element Msg
gridView model =
    let
        sortedMaterials =
            List.sortBy (\ingredient -> -(recipesWithIngredient model.recipes ingredient)) model.materials
    in
    Element.el
        [ paddingEach
            { top = 40
            , right = 0
            , left = 10
            , bottom = 0
            }
        ]
        (Element.table []
            { data = model.recipes
            , columns =
                [ { header = Element.el [ padding 10 ] (Element.text "")
                  , width = Element.fill
                  , view =
                        \row ->
                            Element.el [ padding 10, bold ]
                                (Element.text row.name)
                  }
                ]
                    ++ List.map getColumn sortedMaterials
            }
        )


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
        (Element.column []
            [ header model
            , if model.mode == Grid then
                gridView model

              else
                Element.row
                    [ Element.width Element.fill, Element.height Element.fill, spacing 40 ]
                    [ Element.column
                        [ spacing 5
                        , padding 20
                        , alignTop
                        , Element.width
                            Element.shrink
                        ]
                        [ listIngredients model
                        ]
                    , Element.column
                        [ alignTop
                        , padding 20
                        , spacing 5
                        , Element.width
                            (Element.maximum 400 Element.fill)
                        ]
                        [ Element.el
                            [ paddingEach { edges | left = 10 }
                            ]
                            (title
                                "COCKTAILS"
                            )
                        , listRecipes model
                        ]
                    , Element.column
                        [ alignTop
                        , padding 20
                        , spacing 5
                        , Element.width (Element.maximum 640 Element.fill)
                        ]
                        [ case model.selectedRecipe of
                            Just r ->
                                displayRecipe model r

                            Nothing ->
                                noneSelected
                        ]
                    ]
            ]
        )
