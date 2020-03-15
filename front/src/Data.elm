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


scotchWhiskey : Material
scotchWhiskey =
    { name = "Scotch whiskey", t = Spirit }


drambuie : Material
drambuie =
    { name = "Drambuie", t = Spirit }


bourbonWhiskey : Material
bourbonWhiskey =
    { name = "Bourbon whiskey", t = Spirit }


canadianWhiskey : Material
canadianWhiskey =
    { name = "Canadian whiskey", t = Spirit }


water : Material
water =
    { name = "Water", t = Other }


sodaWater : Material
sodaWater =
    { name = "Soda water", t = Other }


ryeWhiskey : Material
ryeWhiskey =
    { name = "Rye whiskey", t = Spirit }


gin : Material
gin =
    { name = "Gin", t = Spirit }


whiteCremeDeMenthe : Material
whiteCremeDeMenthe =
    { name = "White crème de menthe", t = Spirit }


cremeDeMure : Material
cremeDeMure =
    { name = "Creme de Mure", t = Spirit }


maraschino : Material
maraschino =
    { name = "Maraschino", t = Spirit }


brandy : Material
brandy =
    { name = "Brandy", t = Spirit }


apricotBrandy : Material
apricotBrandy =
    { name = "Apricot brandy", t = Spirit }


pport : Material
pport =
    { name = "Port", t = Spirit }


calvados : Material
calvados =
    { name = "Calvados", t = Spirit }


peachBitters : Material
peachBitters =
    { name = "Peach bitters", t = Bitters }


orangeBitters : Material
orangeBitters =
    { name = "Orange bitters", t = Bitters }


angosturaBitters : Material
angosturaBitters =
    { name = "Angostura bitters", t = Bitters }


peychaudsBitters : Material
peychaudsBitters =
    { name = "Peychaud's bitters", t = Bitters }


citrusRind : Material
citrusRind =
    { name = "Citrus rind", t = Garnish }


lemon : Material
lemon =
    { name = "Lemon", t = Garnish }


blackberries : Material
blackberries =
    { name = "Blackberries", t = Garnish }


cherry : Material
cherry =
    { name = "Cherry", t = Garnish }


pineapple : Material
pineapple =
    { name = "Pineapple", t = Garnish }


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
    { name = "Orange juice", t = Other }


pineappleJuice : Material
pineappleJuice =
    { name = "Pineapple juice", t = Other }


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


gommeSyrup : Material
gommeSyrup =
    { name = "Gomme syrup", t = Sweetener }


raspberrySyrup : Material
raspberrySyrup =
    { name = "Raspberry syrup", t = Sweetener }


raspberryLiqueur : Material
raspberryLiqueur =
    { name = "Raspberry liqueur", t = Sweetener }


lemonPeel : Material
lemonPeel =
    { name = "Lemon peel", t = Garnish }


limeSlice : Material
limeSlice =
    { name = "Lime slice", t = Garnish }


egg : Material
egg =
    { name = "Egg", t = Other }


eggYolk : Material
eggYolk =
    { name = "Egg yolk", t = Other }


eggWhite : Material
eggWhite =
    { name = "Egg white", t = Other }


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


cream : Material
cream =
    { name = "Cream", t = Other }


brownCremeDeCacao : Material
brownCremeDeCacao =
    { name = "Brown crème de cacao", t = Other }


lightCream : Material
lightCream =
    { name = "Light cream", t = Other }


orangeFlowerWater : Material
orangeFlowerWater =
    { name = "Orange flower water", t = Other }


vanillaExtract : Material
vanillaExtract =
    { name = "Vanilla extract", t = Other }


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
    [ -- https://en.wikipedia.org/wiki/Toronto_(cocktail)
      { name = "Toronto"
      , ingredients =
            [ { material = canadianWhiskey, quantity = CL 5.5 }
            , { material = fernetBranca, quantity = CL 0.75 }
            , { material = sugar, quantity = Tsp 0.25 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Stir in mixing glass with ice & strain."""
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

    -- 'NEW ERA DRINKS' -----------------------------
    , { name = "Bramble"
      , ingredients =
            [ { material = gin, quantity = CL 4 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = simpleSyrup, quantity = CL 1 }
            , { material = cremeDeMure, quantity = CL 1.5 }
            , { material = lemon, quantity = Custom "slice" }
            , { material = blackberries, quantity = Custom "2" }
            ]
      , description = """Fill glass with crushed ice. Build gin, lemon juice and simple syrup over. Stir, and then pour blackberry liqueur over in a circular fashion to create marbling effect. Garnish with two blackberries and lemon slice."""
      , glass = OldFashioned
      }
    , { name = "French martini"
      , ingredients =
            [ { material = vodka, quantity = CL 4 }
            , { material = raspberryLiqueur, quantity = CL 1.5 }
            , { material = pineappleJuice, quantity = CL 1 }
            , { material = lemonPeel, quantity = None }
            ]
      , description = """Pour all ingredients into shaker with ice cubes. Shake well and strain into a chilled cocktail glass. Squeeze oil from lemon peel onto the drink."""
      , glass = Cocktail
      }
    , { name = "Kamikaze"
      , ingredients =
            [ { material = vodka, quantity = CL 3 }
            , { material = tripleSec, quantity = CL 3 }
            , { material = limeJuice, quantity = CL 3 }
            , { material = limeSlice, quantity = None }
            ]
      , description = """Shake all ingredients together with ice. Strain into glass, garnish and serve."""
      , glass = Cocktail
      }
    , { name = "Lemon drop"
      , ingredients =
            [ { material = vodka, quantity = CL 2.5 }
            , { material = tripleSec, quantity = CL 2 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = sugar, quantity = None }
            ]
      , description = """Shake and strain into a chilled cocktail glass rimmed with sugar."""
      , glass = Cocktail
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

    -- 'THE UNFORGETTABLES' --------------------------------------------
    -- https://en.wikipedia.org/wiki/Angel_Face_(cocktail)
    , { name = "Alexander"
      , ingredients =
            [ { material = cognac, quantity = CL 3 }
            , { material = brownCremeDeCacao, quantity = CL 3 }
            , { material = lightCream, quantity = CL 3 }
            , { material = nutmeg, quantity = None }
            ]
      , description = """Shake all ingredients with ice and strain contents into a cocktail glass. Sprinkle nutmeg on top and serve."""
      , glass = Cocktail
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

    -- https://en.wikipedia.org/wiki/Angel_Face_(cocktail)
    , { name = "Angel face"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = apricotBrandy, quantity = CL 3 }
            , { material = calvados, quantity = CL 3 }
            ]
      , description = """Shake all ingredients with ice and strain contents into a cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Aviation_(cocktail)
    , { name = "Aviation"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = maraschino, quantity = CL 1.5 }
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass. Garnish with a cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Bacardi_cocktail
    , { name = "Bacardi cocktail"
      , ingredients =
            [ { material = whiteRum, quantity = CL 4.5 }
            , { material = limeJuice, quantity = CL 2 }
            , { material = grenadine, quantity = CL 1 }
            ]
      , description = """Shake together with ice. Strain into glass and serve"""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Between_the_Sheets_(cocktail)
    , { name = "Between the sheets"
      , ingredients =
            [ { material = whiteRum, quantity = CL 3 }
            , { material = cognac, quantity = CL 3 }
            , { material = tripleSec, quantity = CL 3 }
            , { material = lemonJuice, quantity = CL 2 }
            ]
      , description = """Pour all ingredients into shaker with ice cubes, shake, strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Casino_(cocktail)
    , { name = "Casino"
      , ingredients =
            [ { material = gin, quantity = CL 4 }
            , { material = maraschino, quantity = CL 1 }
            , { material = orangeBitters, quantity = CL 1 }
            , { material = lemonJuice, quantity = CL 1 }
            ]
      , description = """Pour all ingredients into shaker with ice cubes, shake, strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Clover_Club_Cocktail
    , { name = "Clover club"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = raspberrySyrup, quantity = CL 1.5 }
            , { material = eggWhite, quantity = CL 1 }
            ]
      , description = """Dry shake ingredients to emulsify, add ice, shake and served straight up."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Daiquiri
    , { name = "Daiquiri"
      , ingredients =
            [ { material = whiteRum, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 2.5 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            ]
      , description = """Pour all ingredients into shaker with ice cubes. Shake well. Double Strain in chilled cocktail glass."""
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

    -- https://en.wikipedia.org/wiki/Martini_(cocktail)
    , { name = "Martini"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = dryVermouth, quantity = CL 1 }
            ]
      , description = """Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Gin_fizz
    , { name = "Gin fizz"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = gommeSyrup, quantity = CL 1 }
            , { material = sodaWater, quantity = CL 8 }
            ]
      , description = """Shake all ingredients with ice cubes, except soda water. Pour into glass. Top with soda water."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/John_Collins_(cocktail)
    , { name = "John collins"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            , { material = sodaWater, quantity = CL 6 }
            , { material = angosturaBitters, quantity = Dashes 1 }
            ]
      , description = """Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish. Add a dash of Angostura bitters."""
      , glass = Collins
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

    -- https://en.wikipedia.org/wiki/Mary_Pickford_(cocktail)
    , { name = "Mary pickford"
      , ingredients =
            [ { material = whiteRum, quantity = CL 6 }
            , { material = pineappleJuice, quantity = CL 6 }
            , { material = grenadine, quantity = CL 1 }
            , { material = maraschino, quantity = CL 1 }
            ]
      , description = """Shake and strain into a chilled large cocktail glass"""
      , glass = Cocktail
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
    , { name = "Negroni"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = campari, quantity = CL 3 }
            ]
      , description = """Stir into glass over ice, garnish and serve."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Old_fashioned_(cocktail)
    , { name = "Old Fashioned"
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

    -- https://en.wikipedia.org/wiki/Paradise_(cocktail)
    , { name = "Paradise"
      , ingredients =
            [ { material = gin, quantity = CL 3.5 }
            , { material = apricotBrandy, quantity = CL 2 }
            , { material = oj, quantity = CL 1.5 }
            ]
      , description = """Shake together over ice. Strain into cocktail glass and serve chilled."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Planter%27s_punch
    , { name = "Planter's punch"
      , ingredients =
            [ { material = darkRum, quantity = CL 4.5 }
            , { material = oj, quantity = CL 3.5 }
            , { material = pineappleJuice, quantity = CL 3.5 }
            , { material = lemonJuice, quantity = CL 2 }
            , { material = grenadine, quantity = CL 1 }
            , { material = simpleSyrup, quantity = CL 1 }
            , { material = angosturaBitters, quantity = Dashes 3 }
            , { material = cherry, quantity = None }
            , { material = pineapple, quantity = None }
            ]
      , description = """Pour all ingredients, except the bitters, into shaker filled with ice. Shake well. Pour into large glass, filled with ice. Add dash Angostura bitters. Garnish with cocktail cherry and pineapple."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Porto_flip
    , { name = "Porto Flip"
      , ingredients =
            [ { material = brandy, quantity = CL 1.5 }
            , { material = pport, quantity = CL 4.5 }
            , { material = eggYolk, quantity = CL 1 }
            , { material = nutmeg, quantity = None }
            ]
      , description = """Shake ingredients together in a mixer with ice. Strain into glass, garnish and serve"""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Ramos_gin_fizz
    , { name = "Ramos fizz"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = simpleSyrup, quantity = CL 3 }
            , { material = cream, quantity = CL 6 }
            , { material = eggWhite, quantity = Custom "1" }
            , { material = orangeFlowerWater, quantity = Dashes 3 }
            , { material = vanillaExtract, quantity = Drops 2 }
            , { material = sodaWater, quantity = None }
            ]
      , description = """All ingredients except the soda are poured in a mixing glass, dry shaken (no ice) for two minutes, then ice is added and shaken hard for another minute. Strain into a highball glass without ice and topped with soda."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Rusty_Nail_(cocktail)
    , { name = "Rusty nail"
      , ingredients =
            [ { material = scotchWhiskey, quantity = CL 4.5 }
            , { material = drambuie, quantity = CL 2.5 }
            ]
      , description = """Pour all ingredients directly into old-fashioned glass filled with ice. Stir gently. Garnish with a lemon twist. Serve."""
      , glass = OldFashioned
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

    -- https://en.wikipedia.org/wiki/Stinger_(cocktail)
    , { name = "Stringer"
      , ingredients =
            [ { material = cognac, quantity = CL 5 }
            , { material = whiteCremeDeMenthe, quantity = CL 2 }
            ]
      , description = """Pour in a mixing glass with ice, stir and strain into a cocktail glass. May also be served on rocks in a rocks glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Tuxedo_(cocktail)
    , { name = "Tuxedo"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = dryVermouth, quantity = CL 3 }
            , { material = maraschino, quantity = Tsp 0.5 }
            , { material = absinthe, quantity = Tsp 0.25 }
            , { material = orangeBitters, quantity = Dashes 3 }
            ]
      , description = """Stir all ingredients with ice and strain into a cocktail glass. Garnish with a cherry and a twist of lemon zest."""
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
    ]
