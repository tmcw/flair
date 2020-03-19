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
import Icons exposing (champagneFluteIcon, cocktailIcon, collinsIcon, copperMugIcon, highballIcon, hurricaneIcon, irishCoffeeIcon, margaritaIcon, oldFashionedIcon, steelCupIcon, wineIcon)
import Json.Decode as Decode
import Quantity exposing (Quantity(..), Units(..), printQuantity)
import Set.Any exposing (AnySet)
import Svg exposing (svg)
import Svg.Attributes


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
    }


materialKey : Material -> String
materialKey ingredient =
    ingredient.name


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


init : ( Model, Cmd Msg )
init =
    ( { recipes = recipes
      , materials = []
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
            (r.name
                /= recipe.name
            )
                && (Set.Any.diff (getMaterials r) (getMaterials recipe)
                        |> Set.Any.size
                   )
                <= 1
                && (Set.Any.diff (getMaterials recipe) (getMaterials r)
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
    ( (case msg of
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

        SetMode mode ->
            { model | mode = mode }

        SetSubsitute on ->
            { model | pedantic = on } |> fuzzyIngredients on

        Ignored ->
            model
      )
        |> deriveMaterials
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
                    (String.fromInt (recipesWithIngredient model.recipes ingredient)
                        ++ " "
                        ++ ingredient.name
                    )
                )
        }


edges : { top : Int, right : Int, bottom : Int, left : Int }
edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


title : String -> Element.Element Msg
title name =
    el
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
    column [ spacing 8, alignTop, Element.width Element.shrink ]
        (title "SPIRITS"
            :: typeMenu model Spirit
            ++ (title "LIQUEUR"
                    :: typeMenu model Liqueur
               )
            ++ (title "FORTIFIED"
                    :: typeMenu model Fortified
               )
            ++ (title "BASE"
                    :: typeMenu model Base
               )
            ++ (title "BITTERS"
                    :: typeMenu model Bitters
               )
            ++ (title "SYRUP"
                    :: typeMenu model Syrup
               )
            ++ (title "JUICE"
                    :: typeMenu model Juice
               )
            ++ (title "FRUIT"
                    :: typeMenu model Fruit
               )
            ++ (title "SEASONING"
                    :: typeMenu model Seasoning
               )
            ++ (title "OTHER"
                    :: typeMenu model Other
               )
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
                    (text "I’m pedantic")
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
                |> List.filter (\ingredient -> ingredient.t == Spirit)
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
                        [ listIngredients model
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
