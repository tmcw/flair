module Data exposing (Ingredient, IngredientType(..), Material, Recipe, recipes)

import Quantity exposing (Quantity(..))


type IngredientType
    = Spirit
    | Garnish
    | Sweetener
    | Vermouth
    | Other
    | Bitters


type Glass
    = OldFashioned
    | Collins
    | Highball
    | ChampagneFlute
    | CopperMug
    | Cocktail


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


bourbonWhiskey : Material
bourbonWhiskey =
    { name = "Bourbon whiskey", t = Spirit }


canadianWhiskey : Material
canadianWhiskey =
    { name = "Canadian Whiskey", t = Spirit }


water : Material
water =
    { name = "Water", t = Other }


sodaWater : Material
sodaWater =
    { name = "Soda water", t = Other }


ryeWhiskey : Material
ryeWhiskey =
    { name = "Rye Whiskey", t = Spirit }


gin : Material
gin =
    { name = "Gin", t = Spirit }


brandy : Material
brandy =
    { name = "Brandy", t = Spirit }


peachBitters : Material
peachBitters =
    { name = "Peach bitters", t = Bitters }


angosturaBitters : Material
angosturaBitters =
    { name = "Angostura bitters", t = Bitters }


peychaudsBitters : Material
peychaudsBitters =
    { name = "Peychaud's bitters", t = Bitters }


citrusRind : Material
citrusRind =
    { name = "Citrus rind", t = Garnish }


sweetRedVermouth : Material
sweetRedVermouth =
    { name = "Sweet red vermouth", t = Vermouth }


dryVermouth : Material
dryVermouth =
    { name = "Dry vermouth", t = Vermouth }


cognac : Material
cognac =
    { name = "Cognac", t = Spirit }


tripleSec : Material
tripleSec =
    { name = "Triple sec", t = Spirit }


grenadine : Material
grenadine =
    { name = "Grenadine", t = Spirit }


oj : Material
oj =
    { name = "Orange Juice", t = Other }


lime : Material
lime =
    { name = "Lime", t = Garnish }


cachaca : Material
cachaca =
    { name = "Cachaça", t = Spirit }


whiteVermouth : Material
whiteVermouth =
    { name = "White vermouth", t = Vermouth }


sugar : Material
sugar =
    { name = "Sugar", t = Sweetener }


absinthe : Material
absinthe =
    { name = "Absinthe", t = Spirit }


campari : Material
campari =
    { name = "Campari", t = Spirit }


fernetBranca : Material
fernetBranca =
    { name = "Fernet Branca", t = Spirit }


simpleSyrup : Material
simpleSyrup =
    { name = "Simple syrup", t = Sweetener }


lemonPeel : Material
lemonPeel =
    { name = "Lemon peel", t = Garnish }


egg : Material
egg =
    { name = "Egg", t = Other }


cider : Material
cider =
    { name = "Cider", t = Spirit }


champagne : Material
champagne =
    { name = "Champagne", t = Spirit }


whiteRum : Material
whiteRum =
    { name = "White rum", t = Spirit }


darkRum : Material
darkRum =
    { name = "Dark rum", t = Spirit }


limeJuice : Material
limeJuice =
    { name = "Lime juice", t = Other }


cola : Material
cola =
    { name = "Cola", t = Other }


nutmeg : Material
nutmeg =
    { name = "Nutmeg", t = Other }


lemonJuice : Material
lemonJuice =
    { name = "Lemon juice", t = Other }


vodka : Material
vodka =
    { name = "Vodka", t = Spirit }


gingerBeer : Material
gingerBeer =
    { name = "Ginger beer", t = Other }


prosecco : Material
prosecco =
    { name = "Prosecco", t = Spirit }


mint : Material
mint =
    { name = "Mint", t = Garnish }


peachPuree : Material
peachPuree =
    { name = "Peach purée", t = Other }


coffeeLiqueur : Material
coffeeLiqueur =
    { name = "Coffee liqueur", t = Other }


lilletBlanc : Material
lilletBlanc =
    { name = "Lillet blan", t = Spirit }


type alias Recipe =
    { name : String
    , ingredients : List Ingredient
    , description : String
    , glass : Glass
    }


recipes : List Recipe
recipes =
    [ -- https://en.wikipedia.org/wiki/Old_fashioned_(cocktail)
      { name = "Old Fashioned"
      , ingredients =
            [ { material = whiskey, quantity = CL 4.5 }
            , { material = angosturaBitters, quantity = Dashes 2 }
            , { material = citrusRind, quantity = None }
            , { material = sugar, quantity = None }
            , { material = water, quantity = FewDashes }
            ]
      , description = """Place sugar cube in old-fashioned glass and saturate with bitters, add a dash of plain water.
Muddle until dissolve. Fill the glass with ice cubes and add whiskey. Garnish with orange slice and a cocktail cherry."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Manhattan_(cocktail)
    , { name = "Manhattan"
      , ingredients =
            [ { material = ryeWhiskey, quantity = CL 5 }
            , { material = sweetRedVermouth, quantity = CL 2 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass.Garnish with cocktail cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Toronto_(cocktail)
    , { name = "Toronto"
      , ingredients =
            [ { material = canadianWhiskey, quantity = CL 5.5 }
            , { material = fernetBranca, quantity = CL 0.75 }
            , { material = sugar, quantity = Tsp 0.25 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Stir in mixing glass with ice & strain."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Martini_(cocktail)
    , { name = "Martini"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = dryVermouth, quantity = CL 1 }
            ]
      , description = """\tStraight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Sazerac
    , { name = "Sazerac"
      , ingredients =
            [ { material = cognac, quantity = CL 5 }
            , { material = absinthe, quantity = CL 1 }
            , { material = sugar, quantity = Cube 1 }
            , { material = peychaudsBitters, quantity = Dashes 2 }
            ]
      , description = """Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Americano_(cocktail)
    , { name = "Americano"
      , ingredients =
            [ { material = campari, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = sodaWater, quantity = Splash }
            ]
      , description = """Pour the Campari and vermouth over ice into a highball glass, add a splash of soda water and garnish with half orange slice and a lemon twist."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Monkey_Gland
    , { name = "Monkey Gland"
      , ingredients =
            [ { material = gin, quantity = CL 5 }
            , { material = oj, quantity = CL 3 }
            , { material = absinthe, quantity = Drops 2 }
            , { material = grenadine, quantity = Drops 2 }
            ]
      , description = """Shake well over ice cubes in a shaker, strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/French_75_(cocktail)
    , { name = "French 75"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = simpleSyrup, quantity = Dashes 2 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = champagne, quantity = CL 6 }
            ]
      , description = """Pour all the ingredients, except Champagne, into a shaker. Shake well and strain into a Champagne flute. Top up with Champagne. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Rum_and_Coke
    , { name = "Cuba Libre"
      , ingredients =
            [ { material = cola, quantity = CL 12 }
            , { material = whiteRum, quantity = CL 5 }
            , { material = limeJuice, quantity = CL 1 }
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with lime wedge."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Moscow_mule
    , { name = "Moscow mule"
      , ingredients =
            [ { material = vodka, quantity = CL 4.5 }
            , { material = gingerBeer, quantity = CL 12 }
            , { material = limeJuice, quantity = CL 0.5 }
            ]
      , description = """Combine vodka and ginger beer in a highball glass filled with ice. Add lime juice. Stir gently. Garnish."""
      , glass = CopperMug
      }

    -- https://en.wikipedia.org/wiki/Mimosa_(cocktail)
    , { name = "Mimosa"
      , ingredients =
            [ { material = champagne, quantity = CL 7.5 }
            , { material = oj, quantity = CL 7.5 }
            ]
      , description = """Ensure both ingredients are well chilled, then mix into the glass. Serve cold."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Bellini_(cocktail)
    , { name = "Bellini"
      , ingredients =
            [ { material = prosecco, quantity = CL 10 }
            , { material = peachPuree, quantity = CL 5 }
            ]
      , description = """Pour peach purée into chilled glass, add sparkling wine. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Black_Russian
    , { name = "Black russian"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = coffeeLiqueur, quantity = CL 2 }
            ]
      , description = """Pour the ingredients into an old fashioned glass filled with ice cubes. Stir gently."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Caipirinha
    , { name = "Caipirinha"
      , ingredients =
            [ { material = cachaca, quantity = CL 5 }
            , { material = lime, quantity = Custom "Half, in four wedges" }
            , { material = sugar, quantity = Tsp 2 }
            ]
      , description = """Place lime and sugar into old fashioned glass and muddle (mash the two ingredients together using a muddler or a wooden spoon). Fill the glass with ice and add the Cachaça."""
      , glass = OldFashioned
      }
    , { name = "Mojito"
      , ingredients =
            [ { material = whiteRum, quantity = CL 4 }
            , { material = limeJuice, quantity = CL 3 }
            , { material = mint, quantity = Sprigs 6 }
            , { material = sugar, quantity = Tsp 2 }
            , { material = sodaWater, quantity = None }
            ]
      , description = """Muddle mint springs with sugar and lime juice. Add splash of soda water and fill glass with cracked ice. Pour rum and top with soda water. Garnish with spring of mint leaves and lemon slice. Serve with straw."""
      , glass = Collins
      }
    , { name = "Dark 'n' Stormy"
      , ingredients =
            [ { material = darkRum, quantity = CL 6 }
            , { material = gingerBeer, quantity = CL 10 }
            , { material = lime, quantity = None }
            ]
      , description = """Fill glass with ice, add rum and top with ginger beer. Garnish with lime wedge."""
      , glass = Highball
      }
    , { name = "Negroni"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = campari, quantity = CL 3 }
            ]
      , description = """Stir into glass over ice, garnish and serve."""
      , glass = OldFashioned
      }
    , { name = "Vesper"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = vodka, quantity = CL 1.5 }
            , { material = lilletBlanc, quantity = CL 0.75 }
            ]
      , description = """Shake and strain into a chilled cocktail glass. Add the garnish."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Derby_(cocktail)
    , { name = "Derby"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = peachBitters, quantity = Dashes 2 }
            , { material = mint, quantity = Custom "2 leaves" }
            ]
      , description = """Shake and strain into a chilled cocktail glass. Add the garnish."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Screwdriver_(cocktail)
    , { name = "Screwdriver"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = oj, quantity = CL 10 }
            ]
      , description = """Mix in a highball glass with ice. Garnish and serve."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Screwdriver_(cocktail)
    , { name = "Sidecar"
      , ingredients =
            [ { material = cognac, quantity = CL 5 }
            , { material = tripleSec, quantity = CL 2 }
            , { material = lemonJuice, quantity = CL 2 }
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Whiskey_sour
    , { name = "Whiskey sour"
      , ingredients =
            [ { material = bourbonWhiskey, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            ]
      , description = """Shake with ice. Strain into chilled glass, garnish and serve."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Sour_(cocktail)#White_Lady
    , { name = "White lady"
      , ingredients =
            [ { material = gin, quantity = CL 4 }
            , { material = tripleSec, quantity = CL 3 }
            , { material = lemonJuice, quantity = CL 2 }
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Boulevardier_(cocktail)
    , { name = "Boulevardier"
      , ingredients =
            [ { material = bourbonWhiskey, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = campari, quantity = CL 3 }
            ]
      , description = """Stir with ice, strain, garnish and serve."""
      , glass = OldFashioned
      }
    ]
