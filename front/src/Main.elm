module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Events
import Data exposing (Glass(..), Ingredient, IngredientType(..), Material, Recipe, recipes)
import Element exposing (Element, alignTop, centerX, column, el, html, padding, paddingEach, paragraph, row, spacing, text)
import Element.Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font exposing (bold, strike)
import Element.Input as Input
import Element.Region
import Html exposing (Html, label, option, select)
import Html.Attributes exposing (value)
import Html.Events
import Json.Decode as Decode
import Quantity exposing (Quantity(..), Units(..), printQuantity)
import Set.Any exposing (AnySet)
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, fill, height, stroke, strokeWidth, viewBox, width, x1, x2, y1, y2)


edges : { top : Int, right : Int, bottom : Int, left : Int }
edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


icon : String -> Element.Element Msg
icon pathSpec =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d pathSpec, stroke "currentColor", strokeWidth "1" ]
            []
        ]
        |> html


champagneFluteIcon : Element.Element Msg
champagneFluteIcon =
    icon "M9.25 17v-5.616L8 7.5 8.5 3h3l.5 4.5-1.25 3.884V17H12v.63H8V17h1.25zM8 4.856h3.616"


cocktailIcon : Element.Element Msg
cocktailIcon =
    icon "M9 9.5L5.5 4h9l-3.501 5.5v4.75H13v1.25H7v-1.25h2.056L9 9.5zm-2.5-4h7"


collinsIcon : Element.Element Msg
collinsIcon =
    icon "M13 4H7v12.5c.5.25 1.5.5 3 .5s2.712-.24 3-.5V4zm-6 6.554l6-.054"


copperMugIcon : Element.Element Msg
copperMugIcon =
    icon "M13 5H5v9.973c.593.213 2.024.527 4 .527s3.605-.314 4-.527V5zm0 2.5h3V12h-3"


highballIcon : Element.Element Msg
highballIcon =
    icon "M13 4H6v11c.512.239 1.792.5 3.5.5s3.158-.261 3.5-.5V4zm-7 6h7"


hurricaneIcon : Element.Element Msg
hurricaneIcon =
    icon "M9.25 17.5V14L7.5 12.5 7 10l.5-1.75.25-1.75-.25-1.75L7 3h6l-.5 1.75-.25 1.75.25 1.75L13 10l-.5 2.5-1.75 1.5v3.5h2.05v.5H7.196v-.5H9.25z"


irishCoffeeIcon : Element.Element Msg
irishCoffeeIcon =
    icon "M9 15v-2l-1-1-1-.5V4h6v7.5l-1 .5-1 1v2l1.332.5v.5H7.196v-.5L9 15zm4-9.5h2.5V9L13 10M7 6.5h6"


margaritaIcon : Element.Element Msg
margaritaIcon =
    icon "M9.25 16.5V9L7.8 8l-.3-1.5L5 5.25 4.5 3h11L15 5.25 12.5 6.5 12.2 8l-1.45 1v7.5h1.582v.5H7.196v-.5H9.25z"


oldFashionedIcon : Element.Element Msg
oldFashionedIcon =
    icon "M14 5H6v10c.582.209 2.06.5 4 .5s3.612-.291 4-.5V5zm-8 5h8"


steelCupIcon : Element.Element Msg
steelCupIcon =
    icon "M14.5 4h-9L7 14.5c.5.25.75.5 3 .5 1.75 0 2.75-.25 3-.5L14.5 4zM6 6h8"


wineIcon : Element.Element Msg
wineIcon =
    icon "M9.25 16.5v-6L7.8 9 7 7l1-4h4l1 4-.8 2-1.45 1.5v6h1.582v.5H7.196v-.5H9.25z"


type alias MaterialSet =
    AnySet String Material


type Mode
    = Normal
    | Grid


type Sort
    = Feasibility
    | Alphabetical


type alias Model =
    { recipes : List Recipe
    , materials : List Material
    , selectedRecipe : Maybe Recipe
    , availableMaterials : MaterialSet
    , units : Units
    , mode : Mode
    , pedantic : Bool
    , sort : Sort
    , countedMaterials : List MaterialsGroup
    }


materialKey : Material -> String
materialKey ingredient =
    ingredient.name


type alias CachedMaterial =
    ( Int, Bool, Material )


type alias MaterialsGroup =
    { label : String
    , materials : List CachedMaterial
    }


countMaterials : Model -> IngredientType -> List CachedMaterial
countMaterials model t =
    List.filter (\material -> material.t == t) model.materials
        |> List.map
            (\material ->
                ( recipesWithIngredient recipes material
                , Set.Any.member material model.availableMaterials
                , material
                )
            )
        |> List.sortBy (\( count, _, _ ) -> -count)


deriveMaterials : Model -> Model
deriveMaterials model =
    let
        ( sufficient, unsortedInsufficient ) =
            List.partition
                (\recipe -> missingIngredients model.availableMaterials recipe |> Set.Any.isEmpty)
                model.recipes

        insufficient =
            List.sortBy
                (\recipe ->
                    (missingIngredients model.availableMaterials recipe |> Set.Any.size |> toFloat)
                        / (List.length recipe.ingredients
                            |> toFloat
                          )
                )
                unsortedInsufficient

        alphabetical =
            List.sortBy (\recipe -> recipe.name) model.recipes

        orderedRecipes =
            case model.sort of
                Feasibility ->
                    sufficient ++ insufficient

                Alphabetical ->
                    alphabetical
    in
    { model
        | materials =
            List.concatMap (\recipe -> List.map (\ingredient -> ingredient.material) recipe.ingredients) model.recipes
                |> List.foldl (::) []
                |> Set.Any.fromList materialKey
                |> Set.Any.toList
        , recipes = orderedRecipes
    }
        |> (\m ->
                { m
                    | countedMaterials =
                        List.map
                            (\( label, t ) ->
                                { label = label
                                , materials = countMaterials m t
                                }
                            )
                            [ ( "SPIRITS", Spirit )
                            , ( "LIQUEUR", Liqueur )
                            , ( "FORTIFIED", Fortified )
                            , ( "BASE", Base )
                            , ( "BITTERS", Bitters )
                            , ( "SYRUP", Syrup )
                            , ( "JUICE", Juice )
                            , ( "FRUIT", Fruit )
                            , ( "SEASONING", Seasoning )
                            , ( "OTHER", Other )
                            ]
                }
           )


init : ( Model, Cmd Msg )
init =
    ( { recipes = recipes
      , materials = []
      , countedMaterials = []
      , selectedRecipe = Nothing
      , availableMaterials = Set.Any.empty materialKey -- Set.Any.fromList materialKey materials
      , units = Ml
      , mode = Normal
      , pedantic = True
      , sort = Feasibility
      }
        |> deriveMaterials
    , Cmd.none
    )


fuzzyIngredients : Bool -> Model -> Model
fuzzyIngredients pedantic model =
    { model
        | recipes =
            if not pedantic then
                List.map
                    (\recipe ->
                        { recipe
                            | ingredients =
                                List.map
                                    fuzzyIngredient
                                    recipe.ingredients
                        }
                    )
                    recipes

            else
                recipes
    }


fuzzyIngredient : Ingredient -> Ingredient
fuzzyIngredient ingredient =
    { ingredient
        | material =
            if ingredient.material.name |> String.toLower |> String.contains "whiskey" then
                { name = "Whiskey"
                , t = Spirit
                }

            else if ingredient.material.name |> String.toLower |> String.contains "rum" then
                { name = "Rum"
                , t = Spirit
                }

            else if ingredient.material.name |> String.toLower |> String.contains "cachaça" then
                { name = "Rum"
                , t = Spirit
                }

            else if ingredient.material.name |> String.toLower |> String.contains "ginger" then
                { name = "Ginger beer"
                , t = Spirit
                }
                -- Make sure this is below `ginger` or fix it.

            else if ingredient.material.name |> String.toLower |> String.contains "gin" then
                { name = "Gin"
                , t = Spirit
                }

            else if ingredient.material.name |> String.toLower |> String.contains "cognac" then
                { name = "Brandy"
                , t = Spirit
                }

            else if ingredient.material.name |> String.toLower |> String.contains "crème de menthe" then
                { name = "Crème de menthe"
                , t = Liqueur
                }

            else if ingredient.material.name |> String.toLower |> String.contains "crème de cacao" then
                { name = "Crème de cacao"
                , t = Liqueur
                }

            else if ingredient.material.name |> String.toLower |> String.contains "prosecco" then
                { name = "Sparkling wine"
                , t = Base
                }

            else if ingredient.material.name |> String.toLower |> String.contains "champagne" then
                { name = "Sparkling wine"
                , t = Base
                }

            else if ingredient.material.name |> String.toLower |> String.contains "gomme" then
                { name = "Simple syrup"
                , t = Syrup
                }

            else if ingredient.material.name |> String.toLower |> String.contains "sugar" then
                { name = "Sugar"
                , t = Seasoning
                }

            else if ingredient.material.name |> String.toLower |> String.contains "salt" then
                { name = "Salt"
                , t = Seasoning
                }

            else if ingredient.material.name |> String.toLower |> String.contains "espresso" then
                { name = "Coffee"
                , t = Other
                }

            else
                ingredient.material
    }


keyDecoder : Decode.Decoder Msg
keyDecoder =
    Decode.map toDirection (Decode.field "key" Decode.string)


toDirection : String -> Msg
toDirection string =
    case string of
        "k" ->
            MoveUp

        "j" ->
            MoveDown

        _ ->
            Ignored


subscriptions : Model -> Sub Msg
subscriptions _ =
    Browser.Events.onKeyDown keyDecoder


main : Program () Model Msg
main =
    Browser.element
        { init = always init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type Msg
    = SelectRecipe Recipe
    | ToggleIngredient Material Bool
    | SetUnits String
    | SetMode Mode
    | SetSubsitute Bool
    | SetSort String
    | MoveUp
    | MoveDown
    | Ignored



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


getNeighbors : Model -> Recipe -> List Recipe
getNeighbors model recipe =
    List.filter
        (\r ->
            let
                rMaterials =
                    getMaterials r

                recipeMaterials =
                    getMaterials recipe
            in
            (r.name
                /= recipe.name
            )
                && (Set.Any.diff rMaterials recipeMaterials
                        |> Set.Any.size
                   )
                <= 1
                && (Set.Any.diff recipeMaterials rMaterials
                        |> Set.Any.size
                   )
                <= 1
        )
        model.recipes


recipesWithIngredient : List Recipe -> Material -> Int
recipesWithIngredient allRecipes ingredient =
    List.filter (\recipe -> Set.Any.member ingredient (getMaterials recipe)) allRecipes
        |> List.length


getNext : List Recipe -> Recipe -> Maybe Recipe
getNext recipes target =
    Maybe.andThen
        (\x ->
            if x == target then
                List.drop 1 recipes |> List.head

            else
                getNext (List.drop 1 recipes) target
        )
        (List.head
            recipes
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        SelectRecipe recipe ->
            { model
                | selectedRecipe =
                    if Just recipe == model.selectedRecipe then
                        Nothing

                    else
                        Just recipe
            }

        SetUnits units ->
            { model
                | units =
                    case units of
                        "Cl" ->
                            Cl

                        "Oz" ->
                            Oz

                        "Ml" ->
                            Ml

                        _ ->
                            Cl
            }

        SetSort sort ->
            { model
                | sort =
                    case sort of
                        "Alphabetical" ->
                            Alphabetical

                        "Feasibility" ->
                            Feasibility

                        _ ->
                            Alphabetical
            }
                |> deriveMaterials

        MoveUp ->
            { model
                | selectedRecipe =
                    case model.selectedRecipe of
                        Just r ->
                            getNext (List.reverse model.recipes) r

                        Nothing ->
                            List.head model.recipes
            }

        MoveDown ->
            { model
                | selectedRecipe =
                    case model.selectedRecipe of
                        Just r ->
                            getNext model.recipes r

                        Nothing ->
                            List.head model.recipes
            }

        ToggleIngredient ingredient checked ->
            { model
                | availableMaterials =
                    if checked then
                        Set.Any.insert ingredient model.availableMaterials

                    else
                        Set.Any.remove ingredient model.availableMaterials
            }
                |> deriveMaterials

        SetMode mode ->
            { model | mode = mode }

        SetSubsitute on ->
            { model | pedantic = on }
                |> fuzzyIngredients on
                |> deriveMaterials
                |> deriveMaterials

        Ignored ->
            model
    , Cmd.none
    )


background : Element.Color
background =
    Element.rgb255 249 247 244


selectedColor : Element.Color
selectedColor =
    Element.rgb255 229 227 224


black : Element.Color
black =
    Element.rgb 0 0 0


blue : Element.Color
blue =
    Element.rgb255 29 27 124


checkboxIcon : Bool -> Element msg
checkboxIcon checked =
    el
        [ Element.width
            (Element.px
                10
            )
        , Element.height
            (Element.px
                (if checked then
                    10

                 else
                    1
                )
            )
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


materialNavigationItem : CachedMaterial -> Element.Element Msg
materialNavigationItem ( count, checked, material ) =
    Input.checkbox []
        { onChange = \_ -> ToggleIngredient material (not checked)
        , icon = checkboxIcon
        , checked = checked
        , label =
            Input.labelRight []
                (text
                    (String.fromInt count
                        ++ " "
                        ++ material.name
                    )
                )
        }


title : String -> Element.Element Msg
title name =
    el
        [ bold
        , paddingEach { edges | bottom = 5, top = 10 }
        ]
        (text name)


listMaterials : List MaterialsGroup -> Element.Element Msg
listMaterials countedMaterials =
    column [ spacing 8, alignTop, Element.width Element.shrink ]
        (List.concatMap
            (\{ label, materials } ->
                title label
                    :: List.map materialNavigationItem materials
            )
            countedMaterials
        )


glassName : Glass -> String
glassName glass =
    case glass of
        -- Tumblers
        Collins ->
            "Collins glass"

        Highball ->
            "Highball glass"

        OldFashioned ->
            "Old Fashioned glass"

        -- Stemware:
        ChampagneFlute ->
            "Champagne flute"

        Cocktail ->
            "Cocktail glass"

        Hurricane ->
            "Hurricane glass"

        Margarita ->
            "Margarita glass"

        Wine ->
            "Wine glass"

        -- Other:
        CopperMug ->
            "Copper mug"

        IrishCoffeeMug ->
            "Irish coffee mug"

        SteelCup ->
            "Steel cup"

        ZombieGlass ->
            "Zombie glass"


drinkIcon : Recipe -> Element.Element Msg
drinkIcon recipe =
    case recipe.glass of
        OldFashioned ->
            oldFashionedIcon

        Cocktail ->
            cocktailIcon

        Collins ->
            collinsIcon

        CopperMug ->
            copperMugIcon

        ChampagneFlute ->
            champagneFluteIcon

        -- These look _really_ similar and the icons are really small,
        -- so winging it for now.
        Highball ->
            highballIcon

        -- To do:
        Margarita ->
            margaritaIcon

        Hurricane ->
            hurricaneIcon

        IrishCoffeeMug ->
            irishCoffeeIcon

        SteelCup ->
            steelCupIcon

        Wine ->
            wineIcon

        ZombieGlass ->
            collinsIcon


neighborBlock : Recipe -> Recipe -> Element.Element Msg
neighborBlock recipe neighbor =
    let
        add =
            Set.Any.diff (getMaterials neighbor) (getMaterials recipe)
                |> Set.Any.toList
                |> List.head

        remove =
            Set.Any.diff (getMaterials recipe) (getMaterials neighbor)
                |> Set.Any.toList
                |> List.head
    in
    column
        [ spacing 10
        , Element.pointer
        , Element.width Element.fill
        , Element.height Element.fill
        , alignTop
        , onClick (SelectRecipe neighbor)
        ]
        [ el [ Font.italic, Font.underline ] (text neighbor.name)
        , paragraph []
            [ case ( add, remove ) of
                ( Just a, Just b ) ->
                    el [] (text ("Add " ++ a.name ++ ", remove " ++ b.name))

                ( Just a, Nothing ) ->
                    el [] (text ("Add " ++ a.name))

                ( Nothing, Just b ) ->
                    el [] (text ("Remove " ++ b.name))

                ( Nothing, Nothing ) ->
                    el [] (text "")
            ]
        ]


recipeBlock : Model -> Recipe -> Element.Element Msg
recipeBlock model recipe =
    let
        viable =
            missingIngredients model.availableMaterials recipe |> Set.Any.isEmpty

        selected =
            model.selectedRecipe == Just recipe
    in
    column
        [ spacing 10
        , Element.pointer
        , padding 10
        , Element.Background.color
            (if selected then
                selectedColor

             else
                background
            )
        , Element.alpha
            (if viable then
                1

             else
                0.5
            )
        , Element.width Element.fill
        , Element.height Element.fill
        , alignTop
        , onClick (SelectRecipe recipe)
        ]
        [ row []
            [ drinkIcon recipe
            , el [ Font.italic, Font.underline ] (text recipe.name)
            ]
        , paragraph [ paddingEach { edges | left = 5 } ]
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
    column [ spacing 20, alignTop ]
        [ el [ Font.bold ] (text "Hi.")
        , paragraph [ spacing 10 ] [ el [] (text """
        This is a website that I made about cocktails. I'm not a huge cocktail nerd (drinking is bad, probably), but think that they're cool.
        And the world's pretty bad right now and making this has been calming.""") ]
        , paragraph [ spacing 10 ] [ el [] (text """It gave me a chance to both tinker with technology I usually don't use (Elm),
        and explore some of the cool properties of cocktails: notably that they're pretty similar and have standardized ingredients,
        so they can be described in relationship to each other.""") ]
        , paragraph [ spacing 10 ] [ el [] (text """So some of it might seem funky. By default, the list is sorted by 'feasibility': as you add
    ingredients that you have, it'll put recipes that you can make (or barely make) closer to the top. Also, click on 'Grid' for a wacky adjacency grid
    of cocktails and their ingredients.""") ]
        , paragraph [ spacing 10 ] [ el [] (text """Also, for vim fans, there’s j & k support.""") ]
        ]


displayRecipe : Model -> Recipe -> Element.Element Msg
displayRecipe model recipe =
    let
        neighbors =
            getNeighbors model recipe
    in
    column [ spacing 20, alignTop ]
        ([ title recipe.name
         , row [ spacing 4, spacing 10 ]
            [ el [ alignTop ] (drinkIcon recipe)
            , paragraph [] [ text ("Served in a " ++ glassName recipe.glass) ]
            ]
         , column
            [ alignTop, spacing 8 ]
            (List.map
                (\ingredient ->
                    paragraph []
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
         , paragraph [ spacing 10, alignTop, Element.width Element.fill ] [ text recipe.description ]
         ]
            ++ (if List.isEmpty neighbors then
                    []

                else
                    title "NEIGHBORS"
                        :: List.map (neighborBlock recipe) neighbors
               )
        )


listRecipes : Model -> Element.Element Msg
listRecipes model =
    column [ spacing 10, Element.width Element.fill ]
        (List.map
            (recipeBlock model)
            model.recipes
        )


header : Model -> Element.Element Msg
header model =
    row [ Element.width Element.fill, padding 20 ]
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
        , Input.checkbox
            [ paddingEach
                { left = 20
                , top = 0
                , bottom = 0
                , right = 5
                }
            ]
            { onChange = SetSubsitute
            , icon = Input.defaultCheckbox
            , checked = model.pedantic
            , label =
                Input.labelRight []
                    (text "Pedantic")
            }
        , el []
            (Element.link
                [ Font.color blue ]
                { url = "https://github.com/tmcw/flair", label = text "{source code}" }
            )
        , el
            [ paddingEach
                { left = 40
                , top = 0
                , bottom = 0
                , right = 5
                }
            ]
            (label [ Html.Attributes.for "sort" ] [ Html.text "Sort" ] |> html)
        , el []
            (select
                [ Html.Events.onInput SetSort
                , Html.Attributes.id
                    "sort"
                ]
                [ option [ value "Feasibility" ]
                    [ Html.text "Feasibility"
                    ]
                , option [ value "Alphabetical" ]
                    [ Html.text "Alphabetical"
                    ]
                ]
                |> html
            )
        , el
            [ paddingEach
                { left = 40
                , top = 0
                , bottom = 0
                , right = 5
                }
            ]
            (label [ Html.Attributes.for "units" ] [ Html.text "Units" ] |> html)
        , select
            [ Html.Events.onInput SetUnits
            , Html.Attributes.id
                "units"
            ]
            [ option [ value "Ml" ]
                [ Html.text "Ml"
                ]
            , option [ value "Cl" ]
                [ Html.text "Cl"
                ]
            , option [ value "Oz" ]
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

        size =
            if on then
                10

            else
                2
    in
    el
        [ Element.width (Element.px 15)
        , Element.height (Element.px 15)
        , Element.centerX
        , Element.centerY
        ]
        (el
            [ Element.width (Element.px size)
            , Element.height (Element.px size)
            , Element.centerY
            , Element.centerX
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
    { header =
        svg
            [ Svg.Attributes.width "22"
            , Svg.Attributes.height "160"
            , Svg.Attributes.viewBox "0 0 20 160"
            ]
            [ Svg.text_
                [ Svg.Attributes.x "-140"
                , Svg.Attributes.y "10"
                , Svg.Attributes.width "22"
                , Svg.Attributes.height "160"
                , Svg.Attributes.rx "15"
                , Svg.Attributes.ry "15"
                , Svg.Attributes.transform "rotate(-90, 12, 5)"
                , Svg.Attributes.textAnchor "start"
                ]
                [ Svg.text material.name
                ]
            ]
            |> html
    , width = Element.fill
    , view = renderDot material
    }


gridView : Model -> Element.Element Msg
gridView model =
    let
        mod =
            fuzzyIngredients True model

        sortedMaterials =
            mod.materials
                |> List.filter (\ingredient -> ingredient.t == Spirit || ingredient.t == Liqueur || ingredient.t == Fortified || ingredient.t == Base)
                |> List.sortBy (\ingredient -> -(recipesWithIngredient model.recipes ingredient))
    in
    el
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
                { header = el [ padding 10 ] (Element.text "")
                , width = Element.fill
                , view =
                    \row ->
                        el [ padding 10, bold ]
                            (Element.text row.name)
                }
                    :: List.map getColumn sortedMaterials
            }
        )


view : Model -> Html Msg
view model =
    Element.layout
        [ Element.Background.color background
        , padding 20
        , Font.size 13
        , Element.width Element.fill
        , Font.family
            [ Font.external
                { name = "IBM Plex Mono"
                , url = "https://fonts.googleapis.com/css?family=IBM+Plex+Mono"
                }
            , Font.sansSerif
            ]
        ]
        (column [ Element.width Element.fill ]
            [ header model
            , if model.mode == Grid then
                gridView model

              else
                row
                    [ Element.width Element.fill, spacing 0 ]
                    [ column
                        [ spacing 5
                        , padding 20
                        , alignTop
                        , Element.width
                            Element.shrink
                        ]
                        [ listMaterials model.countedMaterials
                        ]
                    , column
                        [ alignTop
                        , padding 20
                        , spacing 5
                        , Element.Region.navigation
                        , Element.width
                            (Element.maximum 400 Element.fill)
                        ]
                        [ row
                            [ Element.width Element.fill
                            , spacing 10
                            ]
                            [ el
                                [ paddingEach { edges | left = 10 }
                                , Element.width Element.fill
                                ]
                                (title
                                    "COCKTAILS"
                                )
                            ]
                        , listRecipes model
                        ]
                    , column
                        [ alignTop
                        , padding 20
                        , spacing 5
                        , Element.Region.mainContent
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
