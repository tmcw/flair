module Main exposing (Msg(..), main, update, view)

import Browser
import Element exposing (Element, alignTop, el, padding, paddingEach, paddingXY, spacing, text)
import Element.Background
import Element.Border as Border
import Element.Font as Font exposing (Font, bold, strike)
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


type IngredientType
    = Spirit
    | Garnish
    | Sweetener
    | Other


type alias Material =
    { name : String
    , t : IngredientType
    }


type alias Ingredient =
    { material : Material
    , quantity : Quantity
    }


whiskey : Material
whiskey =
    { name = "Whiskey", t = Spirit }


canadianWhiskey : Material
canadianWhiskey =
    { name = "Canadian Whiskey", t = Spirit }


water : Material
water =
    { name = "Water", t = Other }


ryeWhiskey : Material
ryeWhiskey =
    { name = "Rye Whiskey", t = Spirit }


gin : Material
gin =
    { name = "Gin", t = Spirit }


brandy : Material
brandy =
    { name = "Brandy", t = Spirit }


bitters : Material
bitters =
    { name = "Bitters", t = Spirit }


angosturaBitters : Material
angosturaBitters =
    { name = "Angostura Bitters", t = Spirit }


citrusRind : Material
citrusRind =
    { name = "Citrus rind", t = Spirit }


sweetRedVermouth : Material
sweetRedVermouth =
    { name = "Sweet red vermouth", t = Spirit }


whiteVermouth : Material
whiteVermouth =
    { name = "White vermouth", t = Spirit }


sugar : Material
sugar =
    { name = "Sugar", t = Sweetener }


campari : Material
campari =
    { name = "Campari", t = Spirit }


fernetBranca : Material
fernetBranca =
    { name = "Fernet Branca", t = Spirit }


gumSyrup : Material
gumSyrup =
    { name = "Gum syrup", t = Sweetener }


lemonPeel : Material
lemonPeel =
    { name = "Lemon peel", t = Garnish }


egg : Material
egg =
    { name = "Egg", t = Garnish }


cider : Material
cider =
    { name = "Cider", t = Spirit }


nutmeg : Material
nutmeg =
    { name = "Nutmeg", t = Other }


materials : List Material
materials =
    [ whiskey
    , gin
    , brandy
    , bitters
    , citrusRind
    , sweetRedVermouth
    , campari
    , sugar
    , lemonPeel
    , gumSyrup
    , whiteVermouth
    , egg
    , cider
    , nutmeg
    , fernetBranca
    , water
    , ryeWhiskey
    , canadianWhiskey
    , angosturaBitters
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
            [ { material = whiskey, quantity = Ml 45 }
            , { material = bitters, quantity = Dashes 2 }
            , { material = citrusRind, quantity = None }
            , { material = sugar, quantity = None }
            , { material = water, quantity = FewDashes }
            ]
      , description = """Place sugar cube in old-fashioned glass and saturate with bitters, add a dash of plain water.
Muddle until dissolve. Fill the glass with ice cubes and add whiskey. Garnish with orange slice and a cocktail cherry."""
      }
    , { name = "Manhattan"
      , ingredients =
            [ { material = ryeWhiskey, quantity = Cl 5 }
            , { material = sweetRedVermouth, quantity = Cl 2 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass.Garnish with cocktail cherry."""
      }
    , { name = "Toronto"
      , ingredients =
            [ { material = canadianWhiskey, quantity = Oz 2 }
            , { material = fernetBranca, quantity = Oz 0.25 }
            , { material = sugar, quantity = Tsp 0.25 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Stir in mixing glass with ice & strain."""
      }
    ]


type Msg
    = SelectRecipe Recipe
    | ToggleIngredient Material Bool



--- Utils
--- Pure utilities.


getMaterials : Recipe -> MaterialSet
getMaterials recipe =
    Set.Any.fromList
        materialKey
        (List.map (\ingredient -> ingredient.material) recipe.ingredients)


hasIngredients : MaterialSet -> Recipe -> Bool
hasIngredients availableMaterials recipe =
    Set.Any.isEmpty (Set.Any.diff (getMaterials recipe) availableMaterials)


recipesWithIngredient : List Recipe -> Material -> Int
recipesWithIngredient allRecipes ingredient =
    List.length
        (List.filter (\recipe -> Set.Any.member ingredient (getMaterials recipe)) allRecipes)


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
            :: List.map (ingredientNavigationItem model) model.materials
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
