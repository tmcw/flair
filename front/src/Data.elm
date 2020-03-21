module Data exposing (Glass(..), Ingredient, Material, MaterialType(..), Recipe, SuperMaterial(..), recipes)

import Quantity exposing (Quantity(..))


type
    MaterialType
    -- Main alcohol types:
    = Base -- Fermented base: Sparkling wine, beer, cider, etc.
    | Fortified -- Fermented base with extra alcohol: Port, sherry, vermouth, americano, etc.
    | Liqueur -- Spirit is infused / macerated with herb, spice, fruit; Amari, crème, etc.
    | Spirit -- Fermented base is distilled: Whiskey, rum, vodka, gin, tequila, brandy, etc.
      -- Main non-alcoholic types:
    | Bitters -- Technically often high alcohol but used sparingly.
    | Fruit
    | Juice
    | Seasoning -- Salt, herbs, spices.
    | Syrup
    | Other


type Glass
    = -- Tumblers:
      Collins
    | Highball
    | OldFashioned
      -- | Shot
      -- | Table
      -- Stemware:
      -- | Absinthe
      -- | Chalice
      -- | ChampagneCoupe
    | ChampagneFlute
    | Cocktail
    | Hurricane
    | Margarita
      -- | Sherry
      -- | Snifter
    | Wine
      -- Other:
    | CopperMug
    | IrishCoffeeMug
    | SteelCup
    | ZombieGlass


type alias Material =
    { name : String
    , t : MaterialType
    , super : SuperMaterial
    }


type SuperMaterial
    = SuperMaterial (Maybe Material)


type alias Ingredient =
    { material : Material
    , quantity : Quantity
    }


material : String -> MaterialType -> Material
material name t =
    { name = name, t = t, super = SuperMaterial Nothing }


material3 : String -> MaterialType -> Material -> Material
material3 name t super =
    { name = name, t = t, super = SuperMaterial (Just super) }



-- Whiskey


whiskey : Material
whiskey =
    material "Whiskey" Spirit


scotchWhiskey : Material
scotchWhiskey =
    material3 "Scotch whiskey" Spirit whiskey


bourbonWhiskey : Material
bourbonWhiskey =
    material3 "Bourbon whiskey" Spirit whiskey


canadianWhiskey : Material
canadianWhiskey =
    material3 "Canadian whiskey" Spirit whiskey


ryeWhiskey : Material
ryeWhiskey =
    material3 "Rye whiskey" Spirit whiskey


irishWhiskey : Material
irishWhiskey =
    material3 "Irish whiskey" Spirit whiskey


drambuie : Material
drambuie =
    material "Drambuie" Liqueur


water : Material
water =
    material "Water" Other


sodaWater : Material
sodaWater =
    material "Soda water" Other


gin : Material
gin =
    material "Gin" Spirit


oldTomGin : Material
oldTomGin =
    material3 "Old tom gin" Spirit gin


londonDryGin : Material
londonDryGin =
    material3 "London dry gin" Spirit gin


whiteCremeDeMenthe : Material
whiteCremeDeMenthe =
    material "White crème de menthe" Liqueur


cremeDeMure : Material
cremeDeMure =
    material "Crème de mure" Liqueur


maraschino : Material
maraschino =
    material "Maraschino" Liqueur


brandy : Material
brandy =
    material "Brandy" Spirit


apricotBrandy : Material
apricotBrandy =
    material "Apricot brandy" Liqueur



-- `port` is a reserved word.


pport : Material
pport =
    material "Port" Fortified


calvados : Material
calvados =
    material "Calvados" Spirit


bitters : Material
bitters =
    material "Bitters" Bitters


peachBitters : Material
peachBitters =
    material3 "Peach bitters" Bitters bitters


orangeBitters : Material
orangeBitters =
    material3 "Orange bitters" Bitters bitters


angosturaBitters : Material
angosturaBitters =
    material3 "Angostura bitters" Bitters bitters


peychaudsBitters : Material
peychaudsBitters =
    material3 "Peychaud’s bitters" Bitters bitters


aromaticBitters : Material
aromaticBitters =
    material3 "Aromatic bitters" Bitters bitters


lemon : Material
lemon =
    material "Lemon" Fruit


blackberry : Material
blackberry =
    material "Blackberry" Fruit


cherry : Material
cherry =
    material "Cherry" Fruit


pineapple : Material
pineapple =
    material "Pineapple" Fruit


sweetRedVermouth : Material
sweetRedVermouth =
    material "Sweet red vermouth" Fortified


dryVermouth : Material
dryVermouth =
    material "Dry vermouth" Fortified


cognac : Material
cognac =
    material "Cognac" Spirit


tripleSec : Material
tripleSec =
    material "Triple sec" Liqueur


grenadine : Material
grenadine =
    material "Grenadine" Syrup


oj : Material
oj =
    material "Orange juice" Juice


pineappleJuice : Material
pineappleJuice =
    material "Pineapple juice" Juice


lime : Material
lime =
    material "Lime" Fruit


cachaca : Material
cachaca =
    material3 "Cachaça" Spirit rum


absinthe : Material
absinthe =
    material "Absinthe" Liqueur


campari : Material
campari =
    material "Campari" Liqueur


fernetBranca : Material
fernetBranca =
    material "Fernet Branca" Liqueur


gommeSyrup : Material
gommeSyrup =
    material "Gomme syrup" Syrup


raspberrySyrup : Material
raspberrySyrup =
    material "Raspberry syrup" Syrup


raspberryLiqueur : Material
raspberryLiqueur =
    material "Raspberry liqueur" Liqueur


orange : Material
orange =
    material "Orange" Fruit


eggYolk : Material
eggYolk =
    material "Egg yolk" Other


eggWhite : Material
eggWhite =
    material "Egg white" Other


champagne : Material
champagne =
    material "Champagne" Base


tequila : Material
tequila =
    material "Tequila" Spirit


rum : Material
rum =
    material "Rum" Spirit


whiteRum : Material
whiteRum =
    material3 "White rum" Spirit rum


goldRum : Material
goldRum =
    material3 "Gold rum" Spirit rum


demeraraRum : Material
demeraraRum =
    material3 "Demerara rum" Spirit rum


darkRum : Material
darkRum =
    material3 "Dark rum" Spirit rum


limeJuice : Material
limeJuice =
    material "Lime juice" Juice


cream : Material
cream =
    material "Cream" Other


brownCremeDeCacao : Material
brownCremeDeCacao =
    material "Brown crème de cacao" Liqueur


whiteCremeDeCacao : Material
whiteCremeDeCacao =
    material "White crème de cacao" Liqueur


lightCream : Material
lightCream =
    material "Light cream" Other


orangeFlowerWater : Material
orangeFlowerWater =
    material "Orange flower water" Other


vanillaExtract : Material
vanillaExtract =
    material "Vanilla extract" Other


cola : Material
cola =
    material "Cola" Other


nutmeg : Material
nutmeg =
    material "Nutmeg" Seasoning


lemonJuice : Material
lemonJuice =
    material "Lemon juice" Juice


vodka : Material
vodka =
    material "Vodka" Spirit


gingerBeer : Material
gingerBeer =
    material "Ginger beer" Other


gingerAle : Material
gingerAle =
    material "Ginger ale" Other


prosecco : Material
prosecco =
    material "Prosecco" Base


mint : Material
mint =
    material "Mint" Seasoning


peachPuree : Material
peachPuree =
    material "Peach purée" Other


coffeeLiqueur : Material
coffeeLiqueur =
    material "Coffee liqueur" Liqueur


lilletBlanc : Material
lilletBlanc =
    material "Lillet blanc" Fortified


greenCremeDeMenthe : Material
greenCremeDeMenthe =
    material "Green crème de menthe" Liqueur


cremeDeCassis : Material
cremeDeCassis =
    material "Crème de cassis" Liqueur


amaretto : Material
amaretto =
    material "Amaretto" Liqueur


olive : Material
olive =
    material "Olive" Other


wine : Material
wine =
    material "Wine" Base


dryWhiteWine : Material
dryWhiteWine =
    material3 "Dry white wine" Base wine


sparklingWine : Material
sparklingWine =
    material3 "Sparkling wine" Base wine


peachSchnapps : Material
peachSchnapps =
    material "Peach schnapps" Liqueur


cherryLiqueur : Material
cherryLiqueur =
    material "Cherry liqueur" Liqueur


domBenedictine : Material
domBenedictine =
    material "DOM Bénédictine" Liqueur


oliveJuice : Material
oliveJuice =
    material "Olive juice" Juice


cranberryJuice : Material
cranberryJuice =
    material "Cranberry juice" Juice


grapefruitJuice : Material
grapefruitJuice =
    material "Grapefruit juice" Juice


tomatoJuice : Material
tomatoJuice =
    material "Tomato juice" Juice


pepper : Material
pepper =
    material "Pepper" Seasoning


salt : Material
salt =
    material "Salt" Seasoning


celerySalt : Material
celerySalt =
    material "Celery salt" Seasoning


sugar : Material
sugar =
    material "Sugar" Seasoning


simpleSyrup : Material
simpleSyrup =
    material3 "Simple syrup" Syrup sugar


caneSugar : Material
caneSugar =
    material3 "Cane sugar" Seasoning sugar


powderedSugar : Material
powderedSugar =
    material3 "Powdered sugar" Seasoning sugar


aperol : Material
aperol =
    material "Aperol" Liqueur


galliano : Material
galliano =
    material "Galliano" Liqueur


pisco : Material
pisco =
    material "Pisco" Spirit


orgeatSyrup : Material
orgeatSyrup =
    material "Orgeat (almond) syrup" Syrup


cinnamonSyrup : Material
cinnamonSyrup =
    material "Cinnamon syrup" Syrup


agaveNectar : Material
agaveNectar =
    material "Agave nectar" Syrup


coconutCream : Material
coconutCream =
    material "Coconut cream" Other


espresso : Material
espresso =
    material "Espresso" Other


coffee : Material
coffee =
    material "Coffee" Other


worcestershireSauce : Material
worcestershireSauce =
    material "Worcestershire sauce" Other


irishCream : Material
irishCream =
    material "Irish cream liqueur" Liqueur


falernum : Material
falernum =
    material "Falernum" Liqueur


tabasco : Material
tabasco =
    material "Tabasco" Other


celery : Material
celery =
    material "Celery" Other


greenChartreuse : Material
greenChartreuse =
    material "Green Chartreuse" Liqueur


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
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = orange, quantity = Slice 1 }
            ]
      , description = """Stir in mixing glass with ice & strain. Garnish with orange slice."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/French_75_(cocktail)
    -- https://iba-world.com/cocktails/french-75/
    , { name = "French 75"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = champagne, quantity = CL 6 }
            ]
      , description = """Pour all the ingredients, except Champagne, into a shaker. Shake well and strain into a Champagne flute. Top up with Champagne. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Rum_and_Coke
    -- https://iba-world.com/cocktails/cuba-libre/
    , { name = "Cuba Libre"
      , ingredients =
            [ { material = cola, quantity = CL 12 }
            , { material = whiteRum, quantity = CL 5 }
            , { material = limeJuice, quantity = CL 1 }
            , { material = lime, quantity = Wedge 1 }
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with lime wedge."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Moscow_mule
    -- https://iba-world.com/cocktails/moscow-mule/
    , { name = "Moscow mule"
      , ingredients =
            [ { material = vodka, quantity = CL 4.5 }
            , { material = gingerBeer, quantity = CL 12 }
            , { material = limeJuice, quantity = CL 1 }
            , { material = lime, quantity = Slice 1 }
            ]
      , description = """Combine vodka and ginger beer in a highball glass filled with ice. Add lime juice. Stir gently. Garnish with a lime slice."""
      , glass = CopperMug
      }

    -- https://en.wikipedia.org/wiki/Mimosa_(cocktail)
    -- https://iba-world.com/cocktails/mimosa/
    , { name = "Mimosa"
      , ingredients =
            [ { material = champagne, quantity = CL 7.5 }
            , { material = oj, quantity = CL 7.5 }
            , { material = orange, quantity = Custom "twist" }
            ]
      , description = """Ensure both ingredients are well chilled, then mix into the glass. Garnish with orange twist (optional)."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Bellini_(cocktail)
    -- https://iba-world.com/cocktails/bellini/
    , { name = "Bellini"
      , ingredients =
            [ { material = prosecco, quantity = CL 10 }
            , { material = peachPuree, quantity = CL 5 }
            ]
      , description = """Pour peach purée into chilled glass, add sparkling wine. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Black_Russian
    -- https://iba-world.com/cocktails/black-russian/
    , { name = "Black russian"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = coffeeLiqueur, quantity = CL 2 }
            ]
      , description = """Pour the ingredients into an old fashioned glass filled with ice cubes. Stir gently."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Caipirinha
    -- https://iba-world.com/cocktails/caipirinha/
    , { name = "Caipirinha"
      , ingredients =
            [ { material = cachaca, quantity = CL 6 }
            , { material = lime, quantity = Whole 1 }
            , { material = caneSugar, quantity = Tsp 4 }
            ]
      , description = """Place small lime wedges from one lime and sugar into old fashioned glass and muddle (mash the two ingredients together using a muddler or a wooden spoon). Fill the glass with ice and add the Cachaça. Use vodka instead of cachaça for a caipiroska; rum instead of cachaça for a caipirissima;"""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/mojito/
    , { name = "Mojito"
      , ingredients =
            [ { material = whiteRum, quantity = CL 4.5 }
            , { material = limeJuice, quantity = CL 2 }
            , { material = mint, quantity = Sprig 6 }
            , { material = caneSugar, quantity = Tsp 2 }
            , { material = lemon, quantity = Slice 1 }
            , { material = sodaWater, quantity = Splash 1 }
            ]
      , description = """Muddle mint springs with sugar and lime juice. Add splash of soda water and fill glass with cracked ice. Pour rum and top with soda water. Garnish with sprig of mint leaves and lemon slice. Serve with straw."""
      , glass = Collins
      }

    -- https://iba-world.com/new-era-drinks/dark-n-stormy/
    , { name = "Dark ’n’ Stormy"
      , ingredients =
            [ { material = darkRum, quantity = CL 6 }
            , { material = gingerBeer, quantity = CL 10 }
            , { material = lime, quantity = Wedge 1 }
            ]
      , description = """Fill glass with ice, add rum and top with ginger beer. Garnish with lime wedge."""
      , glass = Highball
      }

    -- 'NEW ERA DRINKS' -----------------------------
    -- https://iba-world.com/new-era-drinks/bramble-2/
    , { name = "Bramble"
      , ingredients =
            [ { material = gin, quantity = CL 4 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = simpleSyrup, quantity = CL 1 }
            , { material = cremeDeMure, quantity = CL 1.5 }
            , { material = lemon, quantity = Slice 1 }
            , { material = blackberry, quantity = Whole 2 }
            ]
      , description = """Fill glass with crushed ice. Build gin, lemon juice and simple syrup over. Stir, and then pour blackberry liqueur over in a circular fashion to create marbling effect. Garnish with two blackberries and lemon slice."""
      , glass = OldFashioned
      }
    , { name = "French martini"
      , ingredients =
            [ { material = vodka, quantity = CL 4 }
            , { material = raspberryLiqueur, quantity = CL 1.5 }
            , { material = pineappleJuice, quantity = CL 1 }
            , { material = lemon, quantity = Custom "peel" }
            ]
      , description = """Pour all ingredients into shaker with ice cubes. Shake well and strain into a chilled cocktail glass. Squeeze oil from lemon peel onto the drink."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/kamikaze-2/
    , { name = "Kamikaze"
      , ingredients =
            [ { material = vodka, quantity = CL 3 }
            , { material = tripleSec, quantity = CL 3 }
            , { material = limeJuice, quantity = CL 3 }
            , { material = lime, quantity = Slice 1 }
            ]
      , description = """Shake all ingredients together with ice. Strain into glass. Garnish with lime slice."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/lemon-drop-martini/
    , { name = "Lemon drop martini"
      , ingredients =
            [ { material = vodka, quantity = CL 2.5 }
            , { material = tripleSec, quantity = CL 2 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = sugar, quantity = None }
            , { material = lime, quantity = Slice 1 }
            ]
      , description = """Shake and strain into a chilled cocktail glass rimmed with sugar, garnish with a slice of lemon."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/vesper-2/
    , { name = "Vesper"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = vodka, quantity = CL 1.5 }
            , { material = lilletBlanc, quantity = CL 0.75 }
            , { material = lemon, quantity = Custom "zest" }
            ]
      , description = """Shake and strain into a chilled cocktail glass. Add the garnish."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Boulevardier_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/boulevardier/
    , { name = "Boulevardier"
      , ingredients =
            [ { material = bourbonWhiskey, quantity = CL 4.5 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = campari, quantity = CL 3 }
            , { material = orange, quantity = Custom "peel" }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with a orange zest, optionally a lemon zest."""
      , glass = OldFashioned
      }

    -- 'THE UNFORGETTABLES' --------------------------------------------
    -- https://en.wikipedia.org/wiki/Alexander_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/alexander/
    , { name = "Alexander"
      , ingredients =
            [ { material = cognac, quantity = CL 3 }
            , { material = brownCremeDeCacao, quantity = CL 3 }
            , { material = lightCream, quantity = CL 3 }
            , { material = nutmeg, quantity = None }
            ]
      , description = """Shake all ingredients with ice and strain contents into a cocktail glass. Sprinkle ground nutmeg on top and serve."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Americano_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/americano/
    , { name = "Americano"
      , ingredients =
            [ { material = campari, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = sodaWater, quantity = Splash 1 }
            , { material = orange, quantity = Slice 0.5 }
            , { material = lemon, quantity = Custom "twist" }
            ]
      , description = """Pour the Campari and vermouth over ice into a highball glass, add a splash of soda water and garnish with half orange slice and a lemon twist."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Angel_Face_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/angel-face/
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
    -- https://iba-world.com/iba-official-cocktails/aviation/
    , { name = "Aviation"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = maraschino, quantity = CL 1.5 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass. Garnish with a cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Bacardi_cocktail
    -- https://iba-world.com/iba-official-cocktails/bacardi/
    , { name = "Bacardi cocktail"
      , ingredients =
            [ { material = whiteRum, quantity = CL 4.5 }
            , { material = limeJuice, quantity = CL 2 }
            , { material = grenadine, quantity = CL 1 }
            ]
      , description = """Shake together with ice. Strain into glass and serve."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Between_the_Sheets_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/between-the-sheets/
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
    -- https://iba-world.com/iba-official-cocktails/casino/
    , { name = "Casino"
      , ingredients =
            [ { material = oldTomGin, quantity = CL 4 }
            , { material = maraschino, quantity = CL 1 }
            , { material = orangeBitters, quantity = CL 1 }
            , { material = lemonJuice, quantity = CL 1 }
            , { material = lemon, quantity = Custom "twist" }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients into shaker with ice cubes, shake well. Strain into chilled cocktail glass and garnish with a lemon twist and a marachino cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Clover_Club_Cocktail
    -- https://iba-world.com/iba-official-cocktails/clover-club/
    , { name = "Clover club"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = raspberrySyrup, quantity = CL 1.5 }
            , { material = eggWhite, quantity = FewDrops }
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well. Strain into cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Daiquiri
    -- https://iba-world.com/iba-official-cocktails/daiquiri/
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
    -- https://iba-world.com/iba-official-cocktails/derby/
    , { name = "Derby"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = peachBitters, quantity = Drop 2 }
            , { material = mint, quantity = Custom "leaves" }
            ]
      , description = """Pour all ingredients into a mixing glass with ice. Stir. Strain into a cocktail glass. Garnish with fresh mint leaves in the drink."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Martini_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/dry-martini/
    , { name = "Dry martini"
      , ingredients =
            [ { material = gin, quantity = CL 6 }
            , { material = dryVermouth, quantity = CL 1 }
            , { material = lemon, quantity = Custom "peel" }
            , { material = olive, quantity = Whole 1 }
            ]
      , description = """Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Gin_fizz
    -- https://iba-world.com/iba-official-cocktails/gin-fizz/
    , { name = "Gin fizz"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = gommeSyrup, quantity = CL 1 }
            , { material = sodaWater, quantity = CL 8 }
            , { material = lemon, quantity = Slice 1 }
            ]
      , description = """Shake all ingredients with ice cubes, except soda water. Pour into tumbler. Top with soda water. Garnish with lemon slice."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/John_Collins_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/john-collins/
    , { name = "John collins"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            , { material = sodaWater, quantity = CL 6 }
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = lemon, quantity = Slice 1 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish with lemon slice and maraschino cherry. Add a dash of Angostura bitters."""
      , glass = Collins
      }

    -- https://en.wikipedia.org/wiki/Manhattan_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/manhattan/
    , { name = "Manhattan"
      , ingredients =
            [ { material = ryeWhiskey, quantity = CL 5 }
            , { material = sweetRedVermouth, quantity = CL 2 }
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with cocktail cherry."""
      , glass = Cocktail
      }

    -- https://iba-world.com/iba-official-cocktails/mary-pickford/
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
    -- https://iba-world.com/iba-official-cocktails/monkey-gland/
    , { name = "Monkey Gland"
      , ingredients =
            [ { material = gin, quantity = CL 5 }
            , { material = oj, quantity = CL 3 }
            , { material = absinthe, quantity = Drop 2 }
            , { material = grenadine, quantity = Drop 2 }
            ]
      , description = """Shake well over ice cubes in a shaker, strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/iba-official-cocktails/negroni/
    , { name = "Negroni"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = sweetRedVermouth, quantity = CL 3 }
            , { material = campari, quantity = CL 3 }
            , { material = orange, quantity = Slice 0.5 }
            ]
      , description = """Pour all ingredients directly into old-fashioned glass filled with ice. Stir gently. Garnish with half orange slice."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Old_fashioned_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/old-fashioned/
    , { name = "Old fashioned"
      , ingredients =
            [ { material = whiskey, quantity = CL 4.5 }
            , { material = angosturaBitters, quantity = Dash 2 }
            , { material = sugar, quantity = Cube 1 }
            , { material = water, quantity = FewDashes }
            , { material = orange, quantity = Slice 1 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Place sugar cube in old-fashioned glass and saturate with bitters, add a dash of plain water. Muddle until dissolve. Fill the glass with ice cubes and add whiskey. Garnish with orange slice and a cocktail cherry."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Paradise_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/paradise/
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
    -- https://iba-world.com/iba-official-cocktails/planters-punch/
    , { name = "Planter’s punch"
      , ingredients =
            [ { material = darkRum, quantity = CL 4.5 }
            , { material = oj, quantity = CL 3.5 }
            , { material = pineappleJuice, quantity = CL 3.5 }
            , { material = lemonJuice, quantity = CL 2 }
            , { material = grenadine, quantity = CL 1 }
            , { material = simpleSyrup, quantity = CL 1 }
            , { material = angosturaBitters, quantity = Dash 3 }
            , { material = cherry, quantity = Whole 1 }
            , { material = pineapple, quantity = Slice 1 }
            ]
      , description = """Pour all ingredients, except the bitters, into shaker filled with ice. Shake well. Pour into large glass, filled with ice. Add dash Angostura bitters. Garnish with cocktail cherry and pineapple."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Porto_flip
    -- https://iba-world.com/iba-official-cocktails/porto-flip/
    , { name = "Porto flip"
      , ingredients =
            [ { material = brandy, quantity = CL 1.5 }
            , { material = pport, quantity = CL 4.5 }
            , { material = eggYolk, quantity = CL 1 }
            , { material = nutmeg, quantity = None }
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well. Strain into cocktail glass. Sprinkle with fresh ground nutmeg."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Ramos_gin_fizz
    -- https://iba-world.com/iba-official-cocktails/ramos-fizz/
    , { name = "Ramos fizz"
      , ingredients =
            [ { material = gin, quantity = CL 4.5 }
            , { material = cream, quantity = CL 6 }
            , { material = simpleSyrup, quantity = CL 3 }
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = eggWhite, quantity = Whole 1 }
            , { material = orangeFlowerWater, quantity = Dash 3 }
            , { material = vanillaExtract, quantity = Drop 2 }
            , { material = sodaWater, quantity = None }
            ]
      , description = """Pour all ingredients (except soda) in a mixing glass, dry shake (no ice) for two minutes, add ice and hard shake for another minute. Strain into a highball glass without ice, top with soda."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Rusty_Nail_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/rusty-nail/
    , { name = "Rusty nail"
      , ingredients =
            [ { material = scotchWhiskey, quantity = CL 4.5 }
            , { material = drambuie, quantity = CL 2.5 }
            , { material = lemon, quantity = Custom "twist" }
            ]
      , description = """Pour all ingredients directly into old-fashioned glass filled with ice. Stir gently. Garnish with a lemon twist."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Sazerac
    -- https://iba-world.com/iba-official-cocktails/sazerac/
    , { name = "Sazerac"
      , ingredients =
            [ { material = cognac, quantity = CL 5 }
            , { material = absinthe, quantity = CL 1 }
            , { material = sugar, quantity = Cube 1 }
            , { material = peychaudsBitters, quantity = Dash 2 }
            , { material = lemon, quantity = Custom "peel" }
            ]
      , description = """Rinse a chilled old-fashioned glass with the absinthe, add crushed ice and set it aside. Stir the remaining ingredients over ice and set it aside. Discard the ice and any excess absinthe from the prepared glass, and strain the drink into the glass. Add the Lemon peel for garnish. Note: The original recipe changed after the American Civil War, rye whiskey substituted cognac as it became hard to obtain."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Screwdriver_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/screwdriver/
    , { name = "Screwdriver"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = oj, quantity = CL 10 }
            , { material = orange, quantity = Slice 1 }
            ]
      , description = """Pour all ingredients into a highball glass filled with ice. Stir gently. Garnish with an orange slice."""
      , glass = Highball
      }

    -- https://iba-world.com/iba-official-cocktails/sidecar/
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
    -- https://iba-world.com/iba-official-cocktails/stinger/
    , { name = "Stinger"
      , ingredients =
            [ { material = cognac, quantity = CL 5 }
            , { material = whiteCremeDeMenthe, quantity = CL 2 }
            ]
      , description = """Pour in a mixing glass with ice, stir and strain into a cocktail glass. May also be served on rocks in a rocks glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Tuxedo_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/tuxedo/
    , { name = "Tuxedo"
      , ingredients =
            [ { material = oldTomGin, quantity = CL 3 }
            , { material = dryVermouth, quantity = CL 3 }
            , { material = maraschino, quantity = Tsp 0.5 }
            , { material = absinthe, quantity = Tsp 0.25 }
            , { material = orangeBitters, quantity = Dash 3 }
            , { material = cherry, quantity = Whole 1 }
            , { material = lemon, quantity = Custom "twist" }
            ]
      , description = """Stir all ingredients with ice and strain into cocktail glass. Garnish with a cocktail cherry and a lemon zest twist."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Whiskey_sour
    -- https://iba-world.com/iba-official-cocktails/whiskey-sour/
    , { name = "Whiskey sour"
      , ingredients =
            [ { material = bourbonWhiskey, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            , { material = eggWhite, quantity = Dash 1 }
            , { material = cherry, quantity = Whole 1 }
            , { material = orange, quantity = Slice 0.5 }
            ]
      , description = """Egg white is optional. Pour all ingredients into cocktail shaker filled with ice. Shake well (a little harder if using egg white). Strain in cocktail glass. Garnish with half orange slice and maraschino cherry."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Sour_(cocktail)#White_Lady
    -- https://iba-world.com/iba-official-cocktails/white-lady/
    , { name = "White lady"
      , ingredients =
            [ { material = gin, quantity = CL 4 }
            , { material = tripleSec, quantity = CL 3 }
            , { material = lemonJuice, quantity = CL 2 }
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/french-connection/
    , { name = "French connection"
      , ingredients =
            [ { material = cognac, quantity = CL 3.5 }
            , { material = amaretto, quantity = CL 3.5 }
            ]
      , description = """Pour all ingredients directly into old fashioned glass filled with ice cubes. Stir gently."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/mint-julep/
    , { name = "Mint julep"
      , ingredients =
            [ { material = bourbonWhiskey, quantity = CL 6 }
            , { material = mint, quantity = Sprig 5 }
            , { material = water, quantity = Tsp 2 }
            , { material = powderedSugar, quantity = Tsp 1 }
            ]
      , description = """In steel cup gently muddle 4 mint sprigs with sugar and water. Fill the glass with cracked ice, add the Bourbon and stir well until the cup frosts. Garnish with a mint sprig."""
      , glass = SteelCup
      }

    -- https://en.wikipedia.org/wiki/White_Russian_(cocktail)
    , { name = "White russian"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = coffeeLiqueur, quantity = CL 2 }
            , { material = cream, quantity = CL 3 }
            ]
      , description = """Pour vodka and coffee liqueur into an old fashioned glass filled with ice cubes. Float fresh cream on the top and stir in slowly.."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/bloody-mary/
    , { name = "Bloody Mary"
      , ingredients =
            [ { material = vodka, quantity = CL 4.5 }
            , { material = tomatoJuice, quantity = CL 9 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = worcestershireSauce, quantity = Dash 2 }
            , { material = tabasco, quantity = None }
            , { material = celerySalt, quantity = None }
            , { material = pepper, quantity = None }
            , { material = celery, quantity = None }
            , { material = lemon, quantity = Wedge 1 }
            ]
      , description = """Stir gently all the ingredients in a mixing glass with ice. Add tabasco, celery salt, pepper to taste. Pour into rocks glass. Garnish with celery and lemon wedge. If requested served with ice, pour into highball glass."""
      , glass = Highball
      }

    -- https://iba-world.com/cocktails/champagne-cocktail/
    , { name = "Champagne cocktail"
      , ingredients =
            [ { material = champagne, quantity = CL 9 }
            , { material = cognac, quantity = CL 1 }
            , { material = angosturaBitters, quantity = Dash 2 }
            , { material = sugar, quantity = Cube 1 }
            , { material = tripleSec, quantity = FewDrops } -- Optional
            , { material = orange, quantity = Custom "zest" }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Place the sugar cube with 2 dashes of bitters in a large Champagne glass, add the cognac. Optionally add a few drops of triple sec. Pour gently chilled Champagne. Garnish with orange zest and cherry."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/kir/
    , { name = "Kir"
      , ingredients =
            [ { material = dryWhiteWine, quantity = CL 9 }
            , { material = cremeDeCassis, quantity = CL 1 }
            ]
      , description = """Pour Crème de Cassis into glass, top up with white wine."""
      , glass = Wine
      }
    , { name = "Kir royal"
      , ingredients =
            [ { material = champagne, quantity = CL 9 }
            , { material = cremeDeCassis, quantity = CL 1 }
            ]
      , description = """Pour Crème de Cassis into glass, top up with Champagne."""
      , glass = Wine
      }

    -- https://iba-world.com/cocktails/long-island-iced-tea/
    , { name = "Long island iced tea"
      , ingredients =
            [ { material = vodka, quantity = CL 1.5 }
            , { material = tequila, quantity = CL 1.5 }
            , { material = whiteRum, quantity = CL 1.5 }
            , { material = gin, quantity = CL 1.5 }
            , { material = tripleSec, quantity = CL 1.5 }
            , { material = lemonJuice, quantity = CL 2.5 }
            , { material = simpleSyrup, quantity = CL 3 }
            , { material = cola, quantity = None }
            , { material = lemon, quantity = Slice 1 }
            ]
      , description = """Add all ingredients into highball glass filled with ice. Top with cola. Stir gently. Garnish with lemon slice."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Mai_Tai
    -- https://iba-world.com/cocktails/mai-tai/
    , { name = "Mai-tai"
      , ingredients =
            [ { material = whiteRum, quantity = CL 3 } -- “Amber Jamaican Rum”
            , { material = darkRum, quantity = CL 3 } -- “Martinique Molasses Rhum”
            , { material = tripleSec, quantity = CL 1.5 } -- “Orange Curacao”
            , { material = orgeatSyrup, quantity = CL 1.5 }
            , { material = limeJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 0.75 }
            , { material = pineapple, quantity = Custom "spear" }
            , { material = mint, quantity = Custom "leaves" }
            , { material = lime, quantity = Custom "peel" }
            ]
      , description = """Add all ingredients into a shaker with ice. Shake and pour into a double rocks glass or an highball glass. Garnish with pineapple spear, mint leaves, and lime peel."""
      , glass = Highball
      }

    -- https://iba-world.com/cocktails/margarita/
    , { name = "Margarita"
      , ingredients =
            [ { material = tequila, quantity = CL 5 }
            , { material = tripleSec, quantity = CL 2 }
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = salt, quantity = None }
            ]
      , description = """Add all ingredients into a shaker with ice. Shake and strain into a chilled cocktail glass. Garnish with a half salt rim (optional)."""
      , glass = Margarita
      }

    -- https://iba-world.com/new-era-drinks/tommys-margarita/
    , { name = "Tommy’s margarita"
      , ingredients =
            [ { material = tequila, quantity = CL 4.5 }
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = agaveNectar, quantity = Tsp 2 }
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Margarita
      }

    -- https://iba-world.com/new-era-drinks/b52-2/
    , { name = "B52"
      , ingredients =
            [ { material = coffeeLiqueur, quantity = CL 2 }
            , { material = tripleSec, quantity = CL 2 }
            , { material = irishCream, quantity = CL 2 }
            ]
      , description = """Layer ingredients one at a time starting with coffee liqueur, followed by irish cream and top with triple sec. Flame the triple sec, serve while the flame is still on, accompanied with a straw on side plate."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Barracuda_(cocktail)
    -- https://iba-world.com/new-era-drinks/barracuda/
    , { name = "Barracuda"
      , ingredients =
            [ { material = goldRum, quantity = CL 4.5 }
            , { material = galliano, quantity = CL 1.5 }
            , { material = pineappleJuice, quantity = CL 6 }
            , { material = limeJuice, quantity = Dash 1 }
            , { material = prosecco, quantity = None }
            ]
      , description = """Shake together with ice. Strain into glass and serve."""
      , glass = Margarita
      }

    -- https://iba-world.com/cocktails/corpse-reviver-2-all-day/
    , { name = "Corpse reviver #2"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = tripleSec, quantity = CL 3 } -- Cointreau
            , { material = lilletBlanc, quantity = CL 3 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = absinthe, quantity = Dash 1 }
            , { material = orange, quantity = Custom "zest" }
            ]
      , description = """Pour all ingredients into shaker with ice. Shake well and strain in chilled cocktail glass. Garnish with orange zest."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/cosmopolitan/
    , { name = "Cosmopolitan"
      , ingredients =
            [ { material = vodka, quantity = CL 4 } -- Vodka citron
            , { material = tripleSec, quantity = CL 1.5 } -- Cointreau
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = cranberryJuice, quantity = CL 3 }
            , { material = lemon, quantity = Custom "twist" }
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass. Garnish with lemon twist."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/dirty-martini/
    , { name = "Dirty martini"
      , ingredients =
            [ { material = vodka, quantity = CL 6 }
            , { material = dryVermouth, quantity = CL 1 }
            , { material = oliveJuice, quantity = CL 1 }
            , { material = olive, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain in chilled martini glass. Garnish with green olive."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/espresso-martini/
    , { name = "Espresso martini"
      , ingredients =
            [ { material = vodka, quantity = CL 5 }
            , { material = coffeeLiqueur, quantity = CL 1 }
            , { material = simpleSyrup, quantity = None }
            , { material = espresso, quantity = Custom "1 shot" }
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/golden-dream/
    , { name = "Golden dream"
      , ingredients =
            [ { material = tripleSec, quantity = CL 2 }
            , { material = galliano, quantity = CL 2 }
            , { material = oj, quantity = CL 2 }
            , { material = cream, quantity = CL 1 }
            ]
      , description = """Pour all ingredients into shaker filled with ice. Shake briskly for few seconds. Strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/grasshopper/
    , { name = "Grasshopper"
      , ingredients =
            [ { material = whiteCremeDeCacao, quantity = CL 2 }
            , { material = greenCremeDeMenthe, quantity = CL 2 }
            , { material = cream, quantity = CL 2 }
            , { material = mint, quantity = Custom "1 leave" }
            ]
      , description = """Pour all ingredients into shaker filled with ice. Shake briskly for few seconds. Strain into chilled cocktail glass. Garnish with mint leave (optional)."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/hemingway-special/
    , { name = "Hemingway special"
      , ingredients =
            [ { material = whiteRum, quantity = CL 6 } -- IBA doesn’t specify “white”
            , { material = grapefruitJuice, quantity = CL 4 }
            , { material = maraschino, quantity = CL 1.5 }
            , { material = limeJuice, quantity = CL 1.5 }
            ]
      , description = """Pour all ingredients into a shaker with ice. Shake well and strain into a large cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/horses-neck/
    , { name = "Horse’s neck"
      , ingredients =
            [ { material = cognac, quantity = CL 4 }
            , { material = gingerAle, quantity = CL 12 }
            , { material = angosturaBitters, quantity = FewDashes }
            , { material = lemon, quantity = Custom "peel" }
            ]
      , description = """Pour Cognac and ginger ale directly into highball glass with ice cubes. Stir gently. If preferred, add dashes of Angostura Bitter. Garnish with rind of one lemon spiral."""
      , glass = Collins
      }

    -- https://iba-world.com/cocktails/irish-coffee/
    , { name = "Irish coffee"
      , ingredients =
            [ { material = irishWhiskey, quantity = CL 5 }
            , { material = coffee, quantity = CL 12 }
            , { material = cream, quantity = CL 5 }
            , { material = sugar, quantity = Tsp 1 }
            ]
      , description = """Warm black coffee is poured into a pre-heated Irish coffee glass. Whiskey and at least one teaspoon of sugar is added and stirred until dissolved. Fresh thick chilled cream is carefully poured over the back of a spoon held just above the surface of the coffee. The layer of cream will float on the coffee without mixing. Plain sugar can be replaced with sugar syrup."""
      , glass = IrishCoffeeMug
      }
    , { name = "Tom collins"
      , ingredients =
            [ { material = oldTomGin, quantity = CL 4.5 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = simpleSyrup, quantity = CL 1.5 }
            , { material = sodaWater, quantity = CL 6 }
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = lemon, quantity = Slice 1 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish with lemon slice and maraschino cherry. Add a dash of Angostura bitters."""
      , glass = Collins
      }

    -- https://iba-world.com/cocktails/pina-colada/
    , { name = "Pina Colada"
      , ingredients =
            [ { material = whiteRum, quantity = CL 5 }
            , { material = coconutCream, quantity = CL 3 }
            , { material = pineappleJuice, quantity = CL 5 }
            , { material = pineapple, quantity = Slice 1 }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Blend all the ingredients with ice in a electric blender, pour into a large glass and serve with straws. Garnish with a slice of pineapple with a cocktail cherry. 4 slices of fresh pineapple can be used instead of juice. Historically a few drops of fresh lime juice was added to taste."""
      , glass = Hurricane
      }

    -- https://iba-world.com/new-era-drinks/pisco-sour/
    -- https://iba-world.com/cocktails/pisco-sour-2/
    , { name = "Pisco Sour"
      , ingredients =
            [ { material = pisco, quantity = CL 4.5 }
            , { material = simpleSyrup, quantity = CL 2 }
            , { material = lemonJuice, quantity = CL 3 }
            , { material = eggWhite, quantity = Whole 1 }
            , { material = angosturaBitters, quantity = Dash 1 }
            ]
      , description = """Shake and strain into a chilled champagne flute. Dash some Angostura bitters on top."""
      , glass = ChampagneFlute
      }

    -- https://iba-world.com/new-era-drinks/russian-spring-punch/
    , { name = "Russian spring punch"
      , ingredients =
            [ { material = vodka, quantity = CL 2.5 }
            , { material = lemonJuice, quantity = CL 2.5 }
            , { material = cremeDeCassis, quantity = CL 1.5 }
            , { material = simpleSyrup, quantity = CL 1 }
            , { material = sparklingWine, quantity = None }
            , { material = lemon, quantity = Slice 1 }
            , { material = blackberry, quantity = Whole 1 }
            ]
      , description = """Shake the ingredients and pour into highball glass. Top with Sparkling wine. Garnish with a lemon slice and a blackberry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Sea_Breeze_(cocktail)
    -- https://iba-world.com/cocktails/sea-breeze/
    , { name = "Sea breeze"
      , ingredients =
            [ { material = vodka, quantity = CL 4 }
            , { material = cranberryJuice, quantity = CL 12 }
            , { material = grapefruitJuice, quantity = CL 3 }
            , { material = orange, quantity = Custom "zest" }
            , { material = cherry, quantity = Whole 1 }
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with an orange zest and cherry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Sex_on_the_Beach
    -- https://iba-world.com/cocktails/sex-on-the-beach/
    , { name = "Sex on the beach"
      , ingredients =
            [ { material = vodka, quantity = CL 4 }
            , { material = peachSchnapps, quantity = CL 2 }
            , { material = oj, quantity = CL 4 }
            , { material = cranberryJuice, quantity = CL 4 }
            , { material = grapefruitJuice, quantity = CL 3 }
            , { material = orange, quantity = Slice 0.5 }
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with an orange zest and cherry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Singapore_Sling
    -- https://iba-world.com/cocktails/singapore-sling/
    , { name = "Singapore sling"
      , ingredients =
            [ { material = gin, quantity = CL 3 }
            , { material = cherryLiqueur, quantity = CL 1.5 }
            , { material = tripleSec, quantity = CL 0.75 } -- Cointreau
            , { material = domBenedictine, quantity = CL 0.75 }
            , { material = pineappleJuice, quantity = CL 12 }
            , { material = limeJuice, quantity = CL 1.5 }
            , { material = grenadine, quantity = CL 1 }
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = cherry, quantity = Whole 1 }
            , { material = pineapple, quantity = Slice 1 }
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice cubes. Shake well. Strain into Hurricane glass. Garnish with pineapple and maraschino cherry."""
      , glass = Hurricane
      }

    -- https://en.wikipedia.org/wiki/Spritz_Veneziano
    -- https://iba-world.com/new-era-drinks/spritz-veneziano/
    , { name = "Spritz Veneziano"
      , ingredients =
            [ { material = prosecco, quantity = CL 6 }
            , { material = aperol, quantity = CL 4 }
            , { material = sodaWater, quantity = Splash 1 }
            , { material = orange, quantity = Slice 0.5 }
            ]
      , description = """Build into an old-fashioned glass filled with ice. Top with a splash of soda water. Garnish with half orange slice."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Spritz_Veneziano
    -- https://iba-world.com/cocktails/tequila-sunrise/
    , { name = "Tequila sunrise"
      , ingredients =
            [ { material = tequila, quantity = CL 4.5 }
            , { material = oj, quantity = CL 9 }
            , { material = grenadine, quantity = CL 1.5 }
            , { material = orange, quantity = Slice 0.5 }
            ]
      , description = """Pour tequila and orange juice directly into highball glass filled with ice cubes. Add the grenadine syrup to create chromatic effect (sunrise), do not stir. Garnish with half orange slice or an orange zest."""
      , glass = Collins
      }

    -- https://en.wikipedia.org/wiki/Yellow_Bird_(cocktail)
    -- https://iba-world.com/new-era-drinks/yellow-bird/
    -- https://open.spotify.com/track/5ced30fVo8XlDpmoVnUZqp
    , { name = "Yellow bird"
      , ingredients =
            [ { material = whiteRum, quantity = CL 3 }
            , { material = galliano, quantity = CL 1.5 }
            , { material = tripleSec, quantity = CL 1.5 }
            , { material = limeJuice, quantity = CL 1.5 }
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Zombie_(cocktail)
    -- https://iba-world.com/cocktails/zombie/
    , { name = "Zombie"
      , ingredients =
            [ { material = darkRum, quantity = CL 4.5 } -- Jamaican dark rum
            , { material = goldRum, quantity = CL 4.5 } -- Gold Puerto Rican rum
            , { material = demeraraRum, quantity = CL 3 } -- Rum from guyana
            , { material = limeJuice, quantity = CL 2 }
            , { material = falernum, quantity = CL 1.5 }
            , { material = grapefruitJuice, quantity = CL 1 } -- With cinnamon syrup making up “Donn’s mix”.
            , { material = cinnamonSyrup, quantity = CL 0.5 }
            , { material = grenadine, quantity = Tsp 1 }
            , { material = angosturaBitters, quantity = Dash 1 }
            , { material = absinthe, quantity = Dash 2 }
            , { material = mint, quantity = Custom "leaves" }
            ]
      , description = """Add all ingredients into an electric blender with 170 grams of cracked ice. With pulse bottom blend for a few seconds. Serve in a tall tumbler glass. Garnish with mint leaves."""
      , glass = ZombieGlass
      }

    -- https://iba-world.com/iba-official-cocktails/brandy-crusta/
    , { name = "Brandy crusta"
      , ingredients =
            [ { material = brandy, quantity = CL 5.25 }
            , { material = lemonJuice, quantity = CL 1.5 }
            , { material = maraschino, quantity = CL 0.75 }
            , { material = tripleSec, quantity = Tsp 1 }
            , { material = simpleSyrup, quantity = Tsp 1 }
            , { material = aromaticBitters, quantity = Dash 2 }
            , { material = orange, quantity = Slice 1 }
            , { material = powderedSugar, quantity = Tsp 1 }
            ]
      , description = """Mix together all ingredients with ice cubes in a mixing glass and strain into prepared slim cocktail glass. Rub a slice of orange (or lemon) around the rim of the glass and dip it in pulverized white sugar, so that the sugar will adhere to the edge of the glass. Carefully curling place the orange/lemon peel around the inside of the glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Hanky-Panky_cocktail
    -- https://iba-world.com/iba-official-cocktails/hanky-panky/
    , { name = "Hanky panky"
      , ingredients =
            [ { material = londonDryGin, quantity = CL 4.5 }
            , { material = sweetRedVermouth, quantity = CL 4.5 }
            , { material = fernetBranca, quantity = CL 0.75 }
            , { material = orange, quantity = Custom "zest" }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with orange zest."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Last_Word_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/last-word/
    , { name = "Last word"
      , ingredients =
            [ { material = gin, quantity = CL 2.25 }
            , { material = greenChartreuse, quantity = CL 2.25 }
            , { material = maraschino, quantity = CL 2.25 }
            , { material = limeJuice, quantity = CL 2.25 }
            ]
      , description = """Add all ingredients into a cocktail shaker. Shake with ice and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Martinez_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/martinez/
    , { name = "Martinez"
      , ingredients =
            [ { material = londonDryGin, quantity = CL 4.5 }
            , { material = sweetRedVermouth, quantity = CL 4.5 }
            , { material = maraschino, quantity = Tsp 1 }
            , { material = orangeBitters, quantity = Dash 2 }
            , { material = lemon, quantity = Custom "zest" }
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with Lemon zest."""
      , glass = Cocktail
      }
    ]
