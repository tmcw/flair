module Data exposing (Ingredient, IngredientType(..), Material, Recipe, recipes)

import Quantity exposing (Quantity(..))


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


bitters : Material
bitters =
    { name = "Bitters", t = Spirit }


angosturaBitters : Material
angosturaBitters =
    { name = "Angostura Bitters", t = Spirit }


peychaudsBitters : Material
peychaudsBitters =
    { name = "Peychaud's Bitters", t = Spirit }


citrusRind : Material
citrusRind =
    { name = "Citrus rind", t = Spirit }


sweetRedVermouth : Material
sweetRedVermouth =
    { name = "Sweet red vermouth", t = Spirit }


dryVermouth : Material
dryVermouth =
    { name = "Dry vermouth", t = Spirit }


cognac : Material
cognac =
    { name = "Cognac", t = Spirit }


grenadine : Material
grenadine =
    { name = "Grenadine", t = Spirit }


oj : Material
oj =
    { name = "Orange Juice", t = Other }


lime : Material
lime =
    { name = "Lime", t = Other }


cachaca : Material
cachaca =
    { name = "Cachaça", t = Spirit }


whiteVermouth : Material
whiteVermouth =
    { name = "White vermouth", t = Spirit }


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
    { name = "Egg", t = Garnish }


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
    { name = "Mint", t = Other }


peachPuree : Material
peachPuree =
    { name = "Peach purée", t = Other }


coffeeLiqueur : Material
coffeeLiqueur =
    { name = "Coffee liqueur", t = Other }


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
    , { name = "Martini"
      , ingredients =
            [ { material = gin, quantity = Cl 6 }
            , { material = dryVermouth, quantity = Cl 1 }
            ]
      , description = """\tStraight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      }
    , { name = "Sazerac"
      , ingredients =
            [ { material = cognac, quantity = Cl 5 }
            , { material = absinthe, quantity = Cl 1 }
            , { material = sugar, quantity = Cube 1 }
            , { material = peychaudsBitters, quantity = Dashes 2 }
            ]
      , description = """Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      }
    , { name = "Americano"
      , ingredients =
            [ { material = campari, quantity = Cl 3 }
            , { material = sweetRedVermouth, quantity = Cl 3 }
            , { material = sodaWater, quantity = Splash }
            ]
      , description = """Pour the Campari and vermouth over ice into a highball glass, add a splash of soda water and garnish with half orange slice and a lemon twist."""
      }
    , { name = "Monkey Gland"
      , ingredients =
            [ { material = gin, quantity = Cl 5 }
            , { material = oj, quantity = Cl 3 }
            , { material = absinthe, quantity = Drops 2 }
            , { material = grenadine, quantity = Drops 2 }
            ]
      , description = """Shake well over ice cubes in a shaker, strain into a chilled cocktail glass."""
      }
    , { name = "French 75"
      , ingredients =
            [ { material = gin, quantity = Cl 3 }
            , { material = simpleSyrup, quantity = Dashes 2 }
            , { material = lemonJuice, quantity = Cl 1.5 }
            , { material = champagne, quantity = Cl 6 }
            ]
      , description = """Pour all the ingredients, except Champagne, into a shaker. Shake well and strain into a Champagne flute. Top up with Champagne. Stir gently."""
      }
    , { name = "Cuba Libre"
      , ingredients =
            [ { material = cola, quantity = Cl 12 }
            , { material = whiteRum, quantity = Cl 5 }
            , { material = limeJuice, quantity = Cl 1 }
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with lime wedge."""
      }
    , { name = "Moscow mule"
      , ingredients =
            [ { material = vodka, quantity = Cl 4.5 }
            , { material = gingerBeer, quantity = Cl 12 }
            , { material = limeJuice, quantity = Cl 0.5 }
            ]
      , description = """Combine vodka and ginger beer in a highball glass filled with ice. Add lime juice. Stir gently. Garnish."""
      }
    , { name = "Mimosa"
      , ingredients =
            [ { material = champagne, quantity = Cl 7.5 }
            , { material = oj, quantity = Cl 7.5 }
            ]
      , description = """Ensure both ingredients are well chilled, then mix into the glass. Serve cold."""
      }
    , { name = "Bellini"
      , ingredients =
            [ { material = prosecco, quantity = Cl 10 }
            , { material = peachPuree, quantity = Cl 5 }
            ]
      , description = """Pour peach purée into chilled glass, add sparkling wine. Stir gently."""
      }
    , { name = "Black russian"
      , ingredients =
            [ { material = vodka, quantity = Cl 5 }
            , { material = coffeeLiqueur, quantity = Cl 2 }
            ]
      , description = """Pour the ingredients into an old fashioned glass filled with ice cubes. Stir gently."""
      }
    , { name = "Caipirinha"
      , ingredients =
            [ { material = cachaca, quantity = Cl 5 }
            , { material = lime, quantity = Custom "Half, in four wedges" }
            , { material = sugar, quantity = Tsp 2 }
            ]
      , description = """Place lime and sugar into old fashioned glass and muddle (mash the two ingredients together using a muddler or a wooden spoon). Fill the glass with ice and add the Cachaça."""
      }
    , { name = "Mojito"
      , ingredients =
            [ { material = whiteRum, quantity = Cl 4 }
            , { material = limeJuice, quantity = Cl 3 }
            , { material = mint, quantity = Sprigs 6 }
            , { material = sugar, quantity = Tsp 2 }
            , { material = sodaWater, quantity = None }
            ]
      , description = """Muddle mint springs with sugar and lime juice. Add splash of soda water and fill glass with cracked ice. Pour rum and top with soda water. Garnish with spring of mint leaves and lemon slice. Serve with straw."""
      }
    , { name = "Dark 'n' Stormy"
      , ingredients =
            [ { material = darkRum, quantity = Cl 6 }
            , { material = gingerBeer, quantity = Cl 10 }
            , { material = lime, quantity = None }
            ]
      , description = """Fill glass with ice, add rum and top with ginger beer. Garnish with lime wedge."""
      }
    ]
