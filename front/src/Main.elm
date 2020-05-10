port module Main exposing (Msg(..), main, setDark, update, view)

import Browser
import Browser.Dom as Dom
import Browser.Events
import Browser.Navigation as Nav
import Data exposing (Glass(..), Ingredient, Material, MaterialType(..), Recipe, SuperMaterial(..), Video(..), recipes)
import Element exposing (Element, alignTop, column, el, fill, height, html, padding, paddingEach, paragraph, row, shrink, spacing, text, width)
import Element.Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font exposing (bold, strike)
import Element.Input as Input
import Element.Region
import Html exposing (details, iframe, label, option, select, summary)
import Html.Attributes exposing (value)
import Html.Events
import Http
import Json.Decode as Decode exposing (Decoder, bool, field, string)
import Json.Encode as Encode
import Quantity exposing (Quantity(..), Units(..), printQuantity)
import Set
import Set.Any exposing (AnySet)
import Slug
import Svg exposing (path, svg)
import Svg.Attributes exposing (d, stroke, strokeWidth, viewBox)
import Task
import Url exposing (Url)



-- Types


type alias CachedMaterial =
    ( Int, Bool, Material )


type alias MaterialsGroup =
    { label : String
    , materials : List CachedMaterial
    }


type alias MaterialSet =
    AnySet String Material


type Mode
    = Normal
    | Grid


type Sort
    = Feasibility
    | Alphabetical


type Device
    = Desktop
    | Mobile


type Tab
    = TMaterials
    | TCocktails
    | TDetail
    | TSettings


type alias Model =
    { recipes : List Recipe
    , materials : List Material
    , selectedRecipe : Maybe Recipe
    , availableMaterials : MaterialSet
    , units : Units
    , mode : Mode
    , pedantic : Bool
    , sort : Sort
    , dark : Bool
    , email : String
    , syncing : Bool
    , sentEmail : Bool
    , countedMaterials : List MaterialsGroup
    , device : Device
    , tab : Tab
    , key : Nav.Key
    }


type Msg
    = SelectRecipe Recipe
    | ToggleIngredient Material Bool
    | SetUnits String
    | SetMode Mode
    | SetSubsitute Bool
    | SetDark Bool
    | SetSort String
    | MoveUp
    | MoveDown
    | Ignored
    | GotOk (Result Http.Error Bool)
    | GotMagic (Result Http.Error Bool)
    | GotDevice Device
    | GotInventory (Result Http.Error (List String))
    | GetMagicLink
    | SetEmail String
    | SetTab Tab
    | ChangedUrl Url
    | ClickedLink Browser.UrlRequest



-- Icons


icon : String -> Element.Element Msg
icon pathSpec =
    svg
        [ Svg.Attributes.width "20", Svg.Attributes.height "20", Svg.Attributes.fill "none", viewBox "0 0 20 20" ]
        [ path [ d pathSpec, stroke "currentColor", strokeWidth "1" ]
            []
        ]
        |> html


glassIcon : Recipe -> Element.Element Msg
glassIcon recipe =
    case recipe.glass of
        OldFashioned ->
            icon "M14 5H6v10c.582.209 2.06.5 4 .5s3.612-.291 4-.5V5zm-8 5h8"

        Cocktail ->
            icon "M9 9.5L5.5 4h9l-3.501 5.5v4.75H13v1.25H7v-1.25h2.056L9 9.5zm-2.5-4h7"

        Collins ->
            icon "M13 4H7v12.5c.5.25 1.5.5 3 .5s2.712-.24 3-.5V4zm-6 6.554l6-.054"

        CopperMug ->
            icon "M13 5H5v9.973c.593.213 2.024.527 4 .527s3.605-.314 4-.527V5zm0 2.5h3V12h-3"

        ChampagneFlute ->
            icon "M9.25 17v-5.616L8 7.5 8.5 3h3l.5 4.5-1.25 3.884V17H12v.63H8V17h1.25zM8 4.856h3.616"

        -- These are the same because they look so similar
        Highball ->
            icon "M13 4H6v11c.512.239 1.792.5 3.5.5s3.158-.261 3.5-.5V4zm-7 6h7"

        ZombieGlass ->
            icon "M13 4H6v11c.512.239 1.792.5 3.5.5s3.158-.261 3.5-.5V4zm-7 6h7"

        Margarita ->
            icon "M9.25 16.5V9L7.8 8l-.3-1.5L5 5.25 4.5 3h11L15 5.25 12.5 6.5 12.2 8l-1.45 1v7.5h1.582v.5H7.196v-.5H9.25z"

        Hurricane ->
            icon "M9.25 17.5V14L7.5 12.5 7 10l.5-1.75.25-1.75-.25-1.75L7 3h6l-.5 1.75-.25 1.75.25 1.75L13 10l-.5 2.5-1.75 1.5v3.5h2.05v.5H7.196v-.5H9.25z"

        IrishCoffeeMug ->
            icon "M9 15v-2l-1-1-1-.5V4h6v7.5l-1 .5-1 1v2l1.332.5v.5H7.196v-.5L9 15zm4-9.5h2.5V9L13 10M7 6.5h6"

        SteelCup ->
            icon "M14.5 4h-9L7 14.5c.5.25.75.5 3 .5 1.75 0 2.75-.25 3-.5L14.5 4zM6 6h8"

        Wine ->
            icon "M9.25 16.5v-6L7.8 9 7 7l1-4h4l1 4-.8 2-1.45 1.5v6h1.582v.5H7.196v-.5H9.25z"

        ChampagneCoupe ->
            icon "M9.25 16.5v-8L8 7 6 6 4.5 4.5V3h11v1.5l-1.5 2-2 .5-1.25 1.5v8h1.582v.5H7.196v-.5H9.25z"



-- Constants


white : Element.Color
white =
    Element.rgb 229 227 224


black : Element.Color
black =
    Element.rgb 0 0 0


blue : Element.Color
blue =
    Element.rgb255 29 27 124


lightBlue : Element.Color
lightBlue =
    Element.rgb255 129 127 224


edges : { top : Int, right : Int, bottom : Int, left : Int }
edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


selectCmd : Nav.Key -> Maybe Recipe -> Cmd Msg
selectCmd key selected =
    case selected of
        Just r ->
            Cmd.batch
                [ Task.attempt (\_ -> Ignored) (Dom.focus (recipeSlug r))
                , Nav.replaceUrl key ("#" ++ recipeSlug r)
                ]

        Nothing ->
            Cmd.none



-- Application loop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectRecipe recipe ->
            ( { model
                | selectedRecipe =
                    if Just recipe == model.selectedRecipe then
                        Nothing

                    else
                        Just recipe
                , tab = TDetail
              }
            , selectCmd model.key (Just recipe)
            )

        SetUnits units ->
            ( { model
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
            , Cmd.none
            )

        SetSort sort ->
            ( { model
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
            , Cmd.none
            )

        MoveUp ->
            let
                selected =
                    model.selectedRecipe
                        |> Maybe.map (\r -> getNext (List.reverse model.recipes) r)
                        |> Maybe.withDefault (List.head model.recipes)
            in
            ( { model
                | selectedRecipe = selected
              }
            , selectCmd model.key selected
            )

        MoveDown ->
            let
                selected =
                    model.selectedRecipe
                        |> Maybe.map (\r -> getNext model.recipes r)
                        |> Maybe.withDefault (List.head model.recipes)
            in
            ( { model
                | selectedRecipe = selected
              }
            , selectCmd model.key selected
            )

        ToggleIngredient material checked ->
            ( { model
                | availableMaterials =
                    if checked then
                        Set.Any.insert material model.availableMaterials

                    else
                        Set.Any.remove material model.availableMaterials
              }
                |> deriveMaterials
            , if model.syncing then
                saveMaterial material.name checked

              else
                Cmd.none
            )

        SetMode mode ->
            ( { model | mode = mode }, Cmd.none )

        SetSubsitute on ->
            ( { model | pedantic = on }
                |> deriveMaterials
            , Cmd.none
            )

        SetDark on ->
            ( { model | dark = on }, setDark on )

        SetEmail e ->
            ( { model | email = e }, Cmd.none )

        SetTab tab ->
            ( { model | tab = tab }, Cmd.none )

        Ignored ->
            ( model, Cmd.none )

        GetMagicLink ->
            ( { model | email = "" }, getMagicLink model.email )

        GotInventory result ->
            case result of
                Ok inventory ->
                    let
                        inventorySet =
                            Set.fromList inventory
                    in
                    ( { model
                        | availableMaterials =
                            List.filter
                                (\m ->
                                    Set.member
                                        m.name
                                        inventorySet
                                )
                                model.materials
                                |> Set.Any.fromList materialKey
                        , syncing = True
                      }
                        |> deriveMaterials
                    , Cmd.none
                    )

                Err _ ->
                    ( { model
                        | syncing = False
                      }
                    , Cmd.none
                    )

        GotMagic _ ->
            ( { model | sentEmail = True }, Cmd.none )

        GotDevice device ->
            ( { model | device = device }, Cmd.none )

        GotOk _ ->
            ( model, Cmd.none )

        ChangedUrl _ ->
            ( model, Cmd.none )

        ClickedLink _ ->
            ( model, Cmd.none )


resizeHandler : Int -> Int -> Msg
resizeHandler w _ =
    if w < 640 then
        GotDevice Mobile

    else
        GotDevice Desktop


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onKeyDown keyDecoder
        , Browser.Events.onResize resizeHandler
        ]


okDecoder : Decoder Bool
okDecoder =
    field "ok" bool


inventoryDecoder : Decoder (List String)
inventoryDecoder =
    Decode.list string


saveMaterial : String -> Bool -> Cmd Msg
saveMaterial material add =
    Http.post
        { url = "/api/store"
        , body =
            Http.jsonBody
                (Encode.object
                    [ ( "material", Encode.string material )
                    , ( "add", Encode.bool add )
                    ]
                )
        , expect = Http.expectJson GotOk okDecoder
        }


getMagicLink : String -> Cmd Msg
getMagicLink email =
    Http.post
        { url = "/api/signin"
        , body =
            Http.jsonBody
                (Encode.object
                    [ ( "email", Encode.string email )
                    ]
                )
        , expect = Http.expectJson GotMagic okDecoder
        }


loadInventory : Cmd Msg
loadInventory =
    Http.get
        { url = "/api/inventory"
        , expect = Http.expectJson GotInventory inventoryDecoder
        }


init : Bool -> Url -> Nav.Key -> ( Model, Cmd Msg )
init isMobile url key =
    ( { recipes = recipes
      , materials = []
      , countedMaterials = []
      , selectedRecipe =
            List.filter
                (\r ->
                    recipeSlug r
                        == (url.fragment
                                |> Maybe.withDefault ""
                           )
                )
                recipes
                |> List.head
      , availableMaterials = Set.Any.empty materialKey
      , units = Ml
      , mode = Normal
      , pedantic = True
      , sort = Feasibility
      , dark = False
      , syncing = False
      , sentEmail = False
      , email = ""
      , key = key
      , device =
            if isMobile then
                Mobile

            else
                Desktop
      , tab = TDetail
      }
        |> deriveMaterials
    , loadInventory
    )


port setDark : Bool -> Cmd msg


main : Program Bool Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }


materialKey : Material -> String
materialKey ingredient =
    ingredient.name



-- Translate between M:SS (minutes:seconds) syntax into
-- a number of seconds, for the benefit of YouTube’s skip-to-time
-- method


parseTime : String -> String
parseTime str =
    str
        |> String.split ":"
        |> List.reverse
        |> List.indexedMap
            (\idx val -> (String.toInt val |> Maybe.withDefault 0) * max 1 (idx * 60))
        |> List.sum
        |> String.fromInt


countMaterials : Model -> MaterialType -> List CachedMaterial
countMaterials model t =
    List.filter (\material -> material.t == t) model.materials
        |> List.map
            (\material ->
                ( recipesWithMaterial model.pedantic recipes material
                , Set.Any.member material model.availableMaterials
                , material
                )
            )
        |> List.sortBy (\( count, _, _ ) -> -count)


deriveMaterials : Model -> Model
deriveMaterials model =
    let
        recipesByGap =
            List.map
                (\recipe -> ( recipe, missingIngredients model.pedantic model.availableMaterials recipe |> Set.Any.size |> toFloat ))
                model.recipes

        ( sufficient, unsortedInsufficient ) =
            List.partition
                (\( _, gapSize ) -> gapSize == 0)
                recipesByGap

        insufficient =
            List.sortBy
                (\( recipe, gapSize ) ->
                    gapSize
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
                    sufficient
                        ++ insufficient
                        |> List.map (\( recipe, _ ) -> recipe)

                Alphabetical ->
                    alphabetical
    in
    { model
        | materials =
            List.concatMap
                (\recipe ->
                    List.concatMap
                        (\ingredient ->
                            [ aliasMaterial False ingredient.material
                            , ingredient.material
                            ]
                        )
                        recipe.ingredients
                )
                model.recipes
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
                            , ( "SODA", Soda )
                            , ( "FRUIT", Fruit )
                            , ( "SEASONING", Seasoning )
                            , ( "OTHER", Other )
                            ]
                }
           )


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


aliasMaterial : Bool -> Material -> Material
aliasMaterial pedantic material =
    if pedantic then
        material

    else
        case material.super of
            SuperMaterial Nothing ->
                material

            SuperMaterial (Just m) ->
                m


getMaterials : Bool -> Recipe -> MaterialSet
getMaterials pedantic recipe =
    recipe.ingredients
        |> List.filter
            (\ingredient -> not ingredient.optional && (pedantic || (ingredient.material.t /= Fruit && ingredient.material.t /= Seasoning)))
        |> List.map
            (\ingredient -> aliasMaterial pedantic ingredient.material)
        |> Set.Any.fromList
            materialKey


missingIngredients : Bool -> MaterialSet -> Recipe -> MaterialSet
missingIngredients pedantic availableMaterials recipe =
    Set.Any.diff (getMaterials pedantic recipe) availableMaterials


getNeighbors : Model -> Recipe -> List ( List Material, List Material, Recipe )
getNeighbors model recipe =
    model.recipes
        |> List.filter (\r -> r.name /= recipe.name)
        |> List.map
            (\r ->
                let
                    rMaterials =
                        getMaterials model.pedantic r

                    recipeMaterials =
                        getMaterials model.pedantic recipe
                in
                ( Set.Any.diff rMaterials recipeMaterials |> Set.Any.toList
                , Set.Any.diff recipeMaterials rMaterials |> Set.Any.toList
                , r
                )
            )
        |> List.filter (\( add, remove, _ ) -> List.length add + List.length remove < 4)
        |> List.sortBy (\( add, remove, _ ) -> List.length add + List.length remove)


recipesWithMaterial : Bool -> List Recipe -> Material -> Int
recipesWithMaterial pedantic allRecipes material =
    List.filter (\recipe -> hasMaterial pedantic recipe material) allRecipes
        |> List.length


getNext : List Recipe -> Recipe -> Maybe Recipe
getNext recipes target =
    List.head recipes
        |> Maybe.andThen
            (\x ->
                if x == target then
                    List.drop 1 recipes |> List.head

                else
                    getNext (List.drop 1 recipes) target
            )



-- User interface


checkboxIconX : Int -> Bool -> Element msg
checkboxIconX x checked =
    let
        wh =
            x |> String.fromInt

        c =
            x // 2 |> String.fromInt

        r =
            x // 3 |> String.fromInt
    in
    svg
        [ Svg.Attributes.width wh
        , Svg.Attributes.height wh
        ]
        [ Svg.circle
            [ Svg.Attributes.cx c
            , Svg.Attributes.cy c
            , Svg.Attributes.r r
            , Svg.Attributes.stroke "currentColor"
            , Svg.Attributes.strokeWidth "1"
            , Svg.Attributes.fill
                (if checked then
                    "currentColor"

                 else
                    "transparent"
                )
            ]
            []
        ]
        |> html


checkboxIcon : Bool -> Element Msg
checkboxIcon =
    checkboxIconX 12


checkboxIconL : Bool -> Element Msg
checkboxIconL =
    checkboxIconX 14


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
                        ++ (if material.name == "Islay Single Malt Scotch whiskey" then
                                "Islay Whiskey"

                            else
                                material.name
                           )
                    )
                )
        }


title : String -> Element.Element Msg
title name =
    el
        [ bold
        , paddingEach { edges | bottom = 5 }
        ]
        (text name)


listMaterials : Bool -> List MaterialsGroup -> Element.Element Msg
listMaterials pedantic countedMaterials =
    countedMaterials
        |> List.concatMap
            (\{ label, materials } ->
                [ column [ spacing 8, alignTop ]
                    (title label
                        :: List.map
                            materialNavigationItem
                            (if pedantic then
                                List.filter
                                    (\( count, _, _ ) -> count > 0)
                                    materials

                             else
                                List.filter
                                    (\( count, _, material ) -> count > 0 && material.super == SuperMaterial Nothing)
                                    materials
                            )
                    )
                ]
            )
        |> column [ spacing 20, alignTop, width shrink ]


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

        ChampagneCoupe ->
            "Champagne coupe"


capitalize : String -> String
capitalize str =
    case String.toList str of
        x :: xs ->
            String.fromChar (Char.toUpper x) ++ String.fromList xs

        [] ->
            ""


neighborBlock : ( List Material, List Material, Recipe ) -> Element.Element Msg
neighborBlock ( add, remove, neighbor ) =
    column
        [ spacing 10
        , Element.pointer
        , width fill
        , height fill
        , alignTop
        , onClick (SelectRecipe neighbor)
        ]
        [ el [ Font.italic, Font.underline ] (text neighbor.name)
        , paragraph []
            [ List.map (\a -> "add " ++ a.name) add
                ++ List.map (\a -> "remove " ++ a.name) remove
                |> String.join ", "
                |> capitalize
                |> text
                |> el []
            ]
        ]


recipeSlug : Recipe -> String
recipeSlug recipe =
    Maybe.map Slug.toString
        (Slug.generate recipe.name)
        |> Maybe.withDefault ""


recipeBlock : Model -> Recipe -> Element.Element Msg
recipeBlock model recipe =
    let
        viable =
            missingIngredients model.pedantic model.availableMaterials recipe |> Set.Any.isEmpty

        selected =
            model.selectedRecipe == Just recipe
    in
    column
        ([ spacing 10
         , Element.pointer
         , Element.alpha
            (if viable then
                1

             else
                0.5
            )
         , width fill
         , height fill
         , alignTop
         , onClick (SelectRecipe recipe)
         , Element.htmlAttribute
            (Html.Attributes.id (recipeSlug recipe))
         , Element.htmlAttribute
            (Html.Attributes.tabindex 0)
         ]
            ++ (if selected then
                    if model.dark then
                        [ Border.color
                            (Element.rgb255
                                239
                                237
                                234
                            )
                        , Border.width 1
                        , padding 9
                        ]

                    else
                        [ Element.Background.color
                            (Element.rgb255
                                229
                                227
                                224
                            )
                        , padding 10
                        ]

                else
                    [ padding 10
                    ]
               )
        )
        [ row []
            [ glassIcon recipe
            , el [ Font.italic, Font.underline ] (text recipe.name)
            ]
        , recipe.ingredients
            |> List.filter (\ingredient -> not ingredient.optional)
            |> List.map
                (listIngredientInBlock model)
            |> List.intersperse
                (el [] (text ", "))
            |> paragraph [ paddingEach { edges | left = 5 } ]
        ]


listIngredientInBlock : Model -> Ingredient -> Element.Element Msg
listIngredientInBlock model ingredient =
    el
        (if
            Set.Any.member (aliasMaterial model.pedantic ingredient.material)
                model.availableMaterials
         then
            []

         else
            [ strike ]
        )
        (text ingredient.material.name)


noneSelected : Model -> Element.Element Msg
noneSelected model =
    column [ spacing 20, paddingEach { edges | bottom = 40 }, alignTop ]
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
        , el []
            (Element.link
                [ Font.color
                    (if model.dark then
                        lightBlue

                     else
                        blue
                    )
                , Font.underline
                ]
                { url = "https://tommacwright.typeform.com/to/M7tx4u", label = text "👋 Feedback welcome!" }
            )
        , el []
            (Element.link
                [ Font.color
                    (if model.dark then
                        lightBlue

                     else
                        blue
                    )
                , Font.underline
                ]
                { url = "https://github.com/tmcw/flair", label = paragraph [] [ text "Pull requests welcome - this is open source on GitHub!" ] }
            )
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
            [ el [ alignTop ] (glassIcon recipe)
            , paragraph [] [ text ("Served in a " ++ glassName recipe.glass) ]
            ]
         , recipe.ingredients
            |> List.map
                (\ingredient ->
                    paragraph []
                        [ text
                            ("- "
                                ++ printQuantity ingredient.material.name ingredient.quantity model.units
                                ++ " "
                                ++ replacement model.pedantic ingredient
                                ++ (if ingredient.optional then
                                        " (optional)"

                                    else
                                        ""
                                   )
                            )
                        ]
                )
            |> column
                [ alignTop, spacing 8 ]
         , paragraph [ spacing 10, alignTop, width fill ] [ text recipe.description ]
         ]
            ++ (case recipe.video of
                    Nothing ->
                        []

                    Just (Epicurious time) ->
                        [ el [ paddingEach { edges | top = 20, bottom = 20 }, width fill ]
                            (details
                                []
                                [ summary [] [ Html.text "Video" ]
                                , iframe
                                    [ Html.Attributes.src ("https://www.youtube-nocookie.com/embed/b0IuTL3Z-kk?start=" ++ parseTime time)
                                    , Html.Attributes.style "width" "100%"
                                    , Html.Attributes.height 315
                                    , Html.Attributes.attribute "frameborder" "0"
                                    , Html.Attributes.attribute "allowfullscreen" "true"
                                    ]
                                    []
                                ]
                                |> html
                            )
                        ]
               )
            ++ (if List.isEmpty neighbors then
                    []

                else
                    title "NEIGHBORS"
                        :: List.map neighborBlock neighbors
               )
        )


replacement : Bool -> Ingredient -> String
replacement pedantic ingredient =
    if pedantic == False && ingredient.material.super /= SuperMaterial Nothing then
        " (or " ++ (aliasMaterial pedantic ingredient.material).name ++ ")"

    else
        ""


listRecipes : Model -> Element.Element Msg
listRecipes model =
    column [ spacing 10, width fill ]
        (List.map
            (recipeBlock model)
            model.recipes
        )


header : Model -> Element.Element Msg
header model =
    let
        leftItems =
            [ case model.device of
                Desktop ->
                    Input.radioRow
                        [ spacing 10
                        ]
                        { onChange = SetMode
                        , selected = Just model.mode
                        , label = Input.labelHidden "Mode"
                        , options =
                            [ Input.option Normal (text "List")
                            , Input.option Grid (text "Grid")
                            ]
                        }

                Mobile ->
                    Element.none
            , Input.checkbox
                []
                { onChange = SetSubsitute
                , icon = checkboxIconL
                , checked = model.pedantic
                , label =
                    Input.labelRight []
                        (text "Pedantic")
                }
            , Input.checkbox
                []
                { onChange = SetDark
                , icon = checkboxIconL
                , checked = model.dark
                , label =
                    Input.labelRight []
                        (text "Dark")
                }
            ]

        rightItems =
            [ row [ spacing 10 ]
                [ el
                    []
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
                ]
            , row [ spacing 10 ]
                [ el
                    []
                    (label [ Html.Attributes.for "units" ] [ Html.text "Units" ] |> html)
                , el []
                    (select
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
                    )
                ]
            ]
    in
    if model.device == Mobile then
        column
            [ paddingEach { edges | left = 20, right = 20 }
            , spacing 20
            ]
            (title "SETTINGS"
                :: leftItems
                ++ rightItems
            )

    else
        row [ width fill, paddingEach { edges | left = 20, right = 20, top = 20, bottom = 30 } ]
            [ row [ width shrink, Element.alignLeft, spacing 20 ]
                leftItems
            , row [ width shrink, Element.alignRight, spacing 20 ]
                rightItems
            ]



-- A fast check to see if a given recipe has an ingredient. Tries to skip
-- any allocations


hasMaterial : Bool -> Recipe -> Material -> Bool
hasMaterial pedantic recipe material =
    List.foldl
        (\i has ->
            if has then
                has

            else
                aliasMaterial pedantic i.material == material
        )
        False
        recipe.ingredients


renderDot : Material -> Recipe -> Html.Html Msg
renderDot material recipe =
    let
        on =
            hasMaterial False recipe material
    in
    svg
        [ Svg.Attributes.width "22"
        , Svg.Attributes.height "22"
        ]
        [ Svg.circle
            [ Svg.Attributes.cx "11"
            , Svg.Attributes.cy "11"
            , Svg.Attributes.fill "currentColor"
            , Svg.Attributes.r
                (if on then
                    "4"

                 else
                    "1"
                )
            ]
            []
        ]


getColumn : Material -> Html.Html Msg
getColumn material =
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
            , Svg.Attributes.transform "rotate(-90, 10, 8)"
            , Svg.Attributes.textAnchor "start"
            , Svg.Attributes.fill "currentColor"
            ]
            [ Svg.text material.name
            ]
        ]


gridView : Model -> Element.Element Msg
gridView model =
    let
        mod =
            model

        sortedMaterials =
            List.concatMap (\{ materials } -> materials) mod.countedMaterials
                |> List.map (\( _, _, material ) -> material)
    in
    Html.table
        [ Html.Attributes.class "grid"
        ]
        [ Html.thead []
            (Html.th []
                [ Html.text ""
                ]
                :: List.map
                    (\ingredient -> Html.th [] [ getColumn ingredient ])
                    sortedMaterials
            )
        , Html.tbody []
            (List.map
                (\recipe ->
                    Html.tr []
                        (Html.th [] [ Html.text recipe.name ]
                            :: List.map
                                (\material -> Html.td [] [ renderDot material recipe ])
                                sortedMaterials
                        )
                )
                model.recipes
            )
        ]
        |> html


view : Model -> Browser.Document Msg
view model =
    let
        mWidth : Int -> Element.Attribute Msg
        mWidth w =
            if model.device == Mobile then
                width fill

            else
                width (Element.px w)

        recipes =
            column
                [ alignTop
                , paddingEach
                    (if model.device == Desktop then
                        { edges | left = 20, right = 20 }

                     else
                        { edges | left = 10, right = 10 }
                    )
                , spacing 5
                , Element.Region.navigation
                , mWidth 360
                , height fill
                ]
                [ row
                    [ width fill
                    , spacing 10
                    ]
                    [ el
                        [ paddingEach { edges | left = 10 }
                        , width fill
                        ]
                        (title
                            "COCKTAILS"
                        )
                    ]
                , el
                    [ Element.scrollbarY, height fill ]
                    (listRecipes
                        model
                    )
                ]

        detail =
            column
                [ alignTop
                , paddingEach { edges | left = 20, right = 20 }
                , spacing 5
                , Element.Region.mainContent
                , width (Element.maximum 640 fill)
                , height fill
                , Element.scrollbarY
                ]
                [ case model.selectedRecipe of
                    Just r ->
                        displayRecipe model r

                    Nothing ->
                        noneSelected model
                ]

        materials =
            column
                [ spacing 5
                , paddingEach { edges | left = 20, right = 20 }
                , alignTop
                , mWidth 260
                , height
                    fill
                , Element.scrollbarY
                ]
                (listMaterials model.pedantic model.countedMaterials
                    :: (if model.syncing then
                            [ el
                                [ paddingEach { edges | top = 30 }
                                ]
                                (Element.link
                                    [ Font.color
                                        (if model.dark then
                                            lightBlue

                                         else
                                            blue
                                        )
                                    ]
                                    { url = "/api/signout", label = text "Sign out" }
                                )
                            ]

                        else if model.sentEmail then
                            [ paragraph
                                [ paddingEach { edges | bottom = 10, top = 30 }
                                ]
                                [ el [] (text "Check your email!") ]
                            ]

                        else
                            [ column
                                [ paddingEach { edges | top = 30, bottom = 50 }
                                , spacing 5
                                ]
                                [ paragraph
                                    [ paddingEach { edges | bottom = 10 }
                                    ]
                                    [ el [] (text "Sign in to save your ingredients") ]
                                , Input.text
                                    [ Html.Events.stopPropagationOn "keydown" (Decode.succeed ( Ignored, True ))
                                        |> Element.htmlAttribute
                                    ]
                                    { onChange = \email -> SetEmail email
                                    , text = model.email
                                    , placeholder = Just (Input.placeholder [] (text "Email"))
                                    , label = Input.labelHidden "Email"
                                    }
                                , Input.button
                                    [ Font.center
                                    , width fill
                                    ]
                                    { onPress = Just GetMagicLink
                                    , label = text "GET LINK"
                                    }
                                ]
                            ]
                       )
                )
    in
    { title =
        "Old Fashioned"
            ++ (model.selectedRecipe
                    |> Maybe.map (\r -> ": " ++ r.name)
                    |> Maybe.withDefault ""
               )
    , body =
        [ Element.layout
            [ Font.size 13
            , Font.color
                (if model.dark then
                    white

                 else
                    black
                )
            , Font.family
                [ Font.typeface "IBM Plex Mono"
                , Font.typeface "SFMono-Regular"
                , Font.typeface "Consolas"
                , Font.typeface "Liberation Mono"
                , Font.typeface "Menlo"
                , Font.monospace
                ]
            , width fill
            , height fill
            ]
            (column
                [ width fill
                , height fill
                , if model.device == Mobile then
                    spacing 20

                  else
                    spacing 0
                ]
                [ if model.device == Desktop then
                    header model

                  else
                    Element.none
                , if model.device == Mobile then
                    row
                        [ Border.widthEach { edges | bottom = 1 }
                        , Element.spaceEvenly
                        , padding 20
                        , width fill
                        ]
                        [ Input.button
                            [ Font.alignLeft
                            , if model.tab == TMaterials then
                                Font.underline

                              else
                                Font.unitalicized
                            ]
                            { onPress = Just (SetTab TMaterials)
                            , label = text "Ingredients"
                            }
                        , Input.button
                            [ Font.alignLeft
                            , if model.tab == TCocktails then
                                Font.underline

                              else
                                Font.unitalicized
                            ]
                            { onPress = Just (SetTab TCocktails)
                            , label = text "Cocktails"
                            }
                        , Input.button
                            [ Font.alignLeft
                            , if model.tab == TDetail then
                                Font.underline

                              else
                                Font.unitalicized
                            ]
                            { onPress = Just (SetTab TDetail)
                            , label = text "Detail"
                            }
                        , Input.button
                            [ Font.alignLeft
                            , if model.tab == TSettings then
                                Font.underline

                              else
                                Font.unitalicized
                            ]
                            { onPress = Just (SetTab TSettings)
                            , label = text "*"
                            }
                        ]

                  else
                    Element.none
                , if model.mode == Grid then
                    gridView model

                  else if model.device == Mobile then
                    el [ Element.scrollbarY, height fill, width fill ]
                        (case model.tab of
                            TMaterials ->
                                materials

                            TCocktails ->
                                recipes

                            TDetail ->
                                detail

                            TSettings ->
                                header model
                        )

                  else
                    row
                        [ width fill
                        , height fill
                        , Element.scrollbarY
                        ]
                        [ materials
                        , recipes
                        , detail
                        ]
                ]
            )
        ]
    }
