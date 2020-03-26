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
    | Soda -- Cola, ginger beer, etc.
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
    , optional : Bool
    }


ingredient : Material -> Quantity -> Ingredient
ingredient mat quantity =
    { material = mat
    , quantity = quantity
    , optional = False
    }


optionalIngredient : Material -> Quantity -> Ingredient
optionalIngredient mat quantity =
    { material = mat
    , quantity = quantity
    , optional = True
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
    material "Soda water" Soda


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


raspberry : Material
raspberry =
    material "Raspberry" Fruit


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
    material3 "Cognac" Spirit brandy


tripleSec : Material
tripleSec =
    material "Triple sec" Liqueur


grandMarnier : Material
grandMarnier =
    material3 "Grand Marnier" Liqueur tripleSec


cointreau : Material
cointreau =
    material3 "Cointreau" Liqueur tripleSec


curacao : Material
curacao =
    material3 "Curaçao" Liqueur tripleSec


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
    material3 "Champagne" Base sparklingWine


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
    material "Vanilla extract" Bitters


cola : Material
cola =
    material "Cola" Soda


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
    material "Ginger beer" Soda


gingerAle : Material
gingerAle =
    material "Ginger ale" Soda


prosecco : Material
prosecco =
    material3 "Prosecco" Base sparklingWine


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
    material "Olive" Fruit


wine : Material
wine =
    material "Wine" Base


dryWhiteWine : Material
dryWhiteWine =
    material3 "Dry white wine" Base wine


sparklingWine : Material
sparklingWine =
    material "Sparkling wine" Base


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
    material "Simple syrup" Syrup


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
    material3 "Pisco" Spirit brandy


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


cremeDeViolette : Material
cremeDeViolette =
    material "Crème de violette" Liqueur


cubanAguardiente : Material
cubanAguardiente =
    material3 "Cuban aguardiente" Spirit rum


honeySyrup : Material
honeySyrup =
    material "Honey syrup" Syrup


honey : Material
honey =
    material "Honey" Other


grapefruitSoda : Material
grapefruitSoda =
    material "Grapefruit soda" Soda


amaroNonino : Material
amaroNonino =
    material "Amaro Nonino" Liqueur


blendedScotchWhiskey : Material
blendedScotchWhiskey =
    material3 "Blended Scotch whiskey" Spirit whiskey


islaySingleMaltScotch : Material
islaySingleMaltScotch =
    material3 "Islay Single Malt Scotch whiskey" Spirit whiskey


ginger : Material
ginger =
    material "Ginger" Other


candiedGinger : Material
candiedGinger =
    material "Candied ginger" Other


elderflowerSyrup : Material
elderflowerSyrup =
    material "Elderflower syrup" Syrup


grappa : Material
grappa =
    material3 "Grappa" Spirit brandy


whiteGrape : Material
whiteGrape =
    material "White grape" Fruit


mezcal : Material
mezcal =
    material "Mezcal" Spirit


overproofWhiteRum : Material
overproofWhiteRum =
    material3 "Overproof white rum" Spirit rum


yellowChartreuse : Material
yellowChartreuse =
    material "Yellow Chartreuse" Liqueur


redWine : Material
redWine =
    material3 "Red wine" Base wine


redChiliPepper : Material
redChiliPepper =
    material "Red chili pepper" Fruit


chamomileSyrup : Material
chamomileSyrup =
    material "Chamomile syrup" Syrup


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
            [ ingredient canadianWhiskey (CL 5.5)
            , ingredient fernetBranca (CL 0.75)
            , ingredient sugar (Tsp 0.25)
            , ingredient angosturaBitters (Dash 1)
            , ingredient orange (Slice 1)
            ]
      , description = """Stir in mixing glass with ice & strain. Garnish with orange slice."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/French_75_(cocktail)
    -- https://iba-world.com/cocktails/french-75/
    , { name = "French 75"
      , ingredients =
            [ ingredient gin (CL 3)
            , ingredient simpleSyrup (CL 1.5)
            , ingredient lemonJuice (CL 1.5)
            , ingredient champagne (CL 6)
            ]
      , description = """Pour all the ingredients, except Champagne, into a shaker. Shake well and strain into a Champagne flute. Top up with Champagne. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Rum_and_Coke
    -- https://iba-world.com/cocktails/cuba-libre/
    , { name = "Cuba Libre"
      , ingredients =
            [ ingredient cola (CL 12)
            , ingredient whiteRum (CL 5)
            , ingredient limeJuice (CL 1)
            , ingredient lime (Wedge 1)
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with lime wedge."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Moscow_mule
    -- https://iba-world.com/cocktails/moscow-mule/
    , { name = "Moscow mule"
      , ingredients =
            [ ingredient vodka (CL 4.5)
            , ingredient gingerBeer (CL 12)
            , ingredient limeJuice (CL 1)
            , ingredient lime (Slice 1)
            ]
      , description = """Combine vodka and ginger beer in a highball glass filled with ice. Add lime juice. Stir gently. Garnish with a lime slice."""
      , glass = CopperMug
      }

    -- https://en.wikipedia.org/wiki/Mimosa_(cocktail)
    -- https://iba-world.com/cocktails/mimosa/
    , { name = "Mimosa"
      , ingredients =
            [ ingredient champagne (CL 7.5)
            , ingredient oj (CL 7.5)
            , optionalIngredient orange (Custom "twist")
            ]
      , description = """Ensure both ingredients are well chilled, then mix into the glass. Garnish with orange twist (optional)."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Bellini_(cocktail)
    -- https://iba-world.com/cocktails/bellini/
    , { name = "Bellini"
      , ingredients =
            [ ingredient prosecco (CL 10)
            , ingredient peachPuree (CL 5)
            ]
      , description = """Pour peach purée into chilled glass, add sparkling wine. Stir gently."""
      , glass = ChampagneFlute
      }

    -- https://en.wikipedia.org/wiki/Black_Russian
    -- https://iba-world.com/cocktails/black-russian/
    , { name = "Black russian"
      , ingredients =
            [ ingredient vodka (CL 5)
            , ingredient coffeeLiqueur (CL 2)
            ]
      , description = """Pour the ingredients into an old fashioned glass filled with ice cubes. Stir gently."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Caipirinha
    -- https://iba-world.com/cocktails/caipirinha/
    , { name = "Caipirinha"
      , ingredients =
            [ ingredient cachaca (CL 6)
            , ingredient lime (Whole 1)
            , ingredient caneSugar (Tsp 4)
            ]
      , description = """Place small lime wedges from one lime and sugar into old fashioned glass and muddle (mash the two ingredients together using a muddler or a wooden spoon). Fill the glass with ice and add the Cachaça. Use vodka instead of cachaça for a caipiroska; rum instead of cachaça for a caipirissima;"""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/mojito/
    , { name = "Mojito"
      , ingredients =
            [ ingredient whiteRum (CL 4.5)
            , ingredient limeJuice (CL 2)
            , ingredient mint (Sprig 6)
            , ingredient caneSugar (Tsp 2)
            , ingredient lemon (Slice 1)
            , ingredient sodaWater (Splash 1)
            ]
      , description = """Muddle mint springs with sugar and lime juice. Add splash of soda water and fill glass with cracked ice. Pour rum and top with soda water. Garnish with sprig of mint leaves and lemon slice. Serve with straw."""
      , glass = Collins
      }

    -- https://iba-world.com/new-era-drinks/dark-n-stormy/
    , { name = "Dark ’n’ Stormy"
      , ingredients =
            [ ingredient darkRum (CL 6)
            , ingredient gingerBeer (CL 10)
            , ingredient lime (Wedge 1)
            ]
      , description = """Fill glass with ice, add rum and top with ginger beer. Garnish with lime wedge."""
      , glass = Highball
      }

    -- 'NEW ERA DRINKS' -----------------------------
    -- https://iba-world.com/new-era-drinks/bramble-2/
    , { name = "Bramble"
      , ingredients =
            [ ingredient gin (CL 4)
            , ingredient lemonJuice (CL 1.5)
            , ingredient simpleSyrup (CL 1)
            , ingredient cremeDeMure (CL 1.5)
            , ingredient lemon (Slice 1)
            , ingredient blackberry (Whole 2)
            ]
      , description = """Fill glass with crushed ice. Build gin, lemon juice and simple syrup over. Stir, and then pour blackberry liqueur over in a circular fashion to create marbling effect. Garnish with two blackberries and lemon slice."""
      , glass = OldFashioned
      }
    , { name = "French martini"
      , ingredients =
            [ ingredient vodka (CL 4)
            , ingredient raspberryLiqueur (CL 1.5)
            , ingredient pineappleJuice (CL 1)
            , ingredient lemon (Custom "peel")
            ]
      , description = """Pour all ingredients into shaker with ice cubes. Shake well and strain into a chilled cocktail glass. Squeeze oil from lemon peel onto the drink."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/kamikaze-2/
    , { name = "Kamikaze"
      , ingredients =
            [ ingredient vodka (CL 3)
            , ingredient tripleSec (CL 3)
            , ingredient limeJuice (CL 3)
            , ingredient lime (Slice 1)
            ]
      , description = """Shake all ingredients together with ice. Strain into glass. Garnish with lime slice."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/lemon-drop-martini/
    , { name = "Lemon drop martini"
      , ingredients =
            [ ingredient vodka (CL 2.5)
            , ingredient tripleSec (CL 2)
            , ingredient lemonJuice (CL 1.5)
            , ingredient sugar None
            , ingredient lime (Slice 1)
            ]
      , description = """Shake and strain into a chilled cocktail glass rimmed with sugar, garnish with a slice of lemon."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/vesper-2/
    , { name = "Vesper"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient vodka (CL 1.5)
            , ingredient lilletBlanc (CL 0.75)
            , ingredient lemon (Custom "zest")
            ]
      , description = """Shake and strain into a chilled cocktail glass. Add the garnish."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Boulevardier_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/boulevardier/
    , { name = "Boulevardier"
      , ingredients =
            [ ingredient bourbonWhiskey (CL 4.5)
            , ingredient sweetRedVermouth (CL 3)
            , ingredient campari (CL 3)
            , ingredient orange (Custom "peel")
            , optionalIngredient lemon (Custom "zest")
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with a orange zest, optionally a lemon zest."""
      , glass = OldFashioned
      }

    -- 'THE UNFORGETTABLES' --------------------------------------------
    -- https://en.wikipedia.org/wiki/Alexander_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/alexander/
    , { name = "Alexander"
      , ingredients =
            [ ingredient cognac (CL 3)
            , ingredient brownCremeDeCacao (CL 3)
            , ingredient lightCream (CL 3)
            , ingredient nutmeg None
            ]
      , description = """Shake all ingredients with ice and strain contents into a cocktail glass. Sprinkle ground nutmeg on top and serve."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Americano_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/americano/
    , { name = "Americano"
      , ingredients =
            [ ingredient campari (CL 3)
            , ingredient sweetRedVermouth (CL 3)
            , ingredient sodaWater (Splash 1)
            , ingredient orange (Slice 0.5)
            , ingredient lemon (Custom "twist")
            ]
      , description = """Pour the Campari and vermouth over ice into a highball glass, add a splash of soda water and garnish with half orange slice and a lemon twist."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Angel_Face_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/angel-face/
    , { name = "Angel face"
      , ingredients =
            [ ingredient gin (CL 3)
            , ingredient apricotBrandy (CL 3)
            , ingredient calvados (CL 3)
            ]
      , description = """Shake all ingredients with ice and strain contents into a cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Aviation_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/aviation/
    , { name = "Aviation"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient lemonJuice (CL 1.5)
            , ingredient maraschino (CL 1.5)
            , ingredient cremeDeViolette (Tsp 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass. Garnish with a cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Bacardi_cocktail
    -- https://iba-world.com/iba-official-cocktails/bacardi/
    , { name = "Bacardi cocktail"
      , ingredients =
            [ ingredient whiteRum (CL 4.5)
            , ingredient limeJuice (CL 2)
            , ingredient grenadine (CL 1)
            ]
      , description = """Shake together with ice. Strain into glass and serve."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Between_the_Sheets_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/between-the-sheets/
    , { name = "Between the sheets"
      , ingredients =
            [ ingredient whiteRum (CL 3)
            , ingredient cognac (CL 3)
            , ingredient tripleSec (CL 3)
            , ingredient lemonJuice (CL 2)
            ]
      , description = """Pour all ingredients into shaker with ice cubes, shake, strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Casino_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/casino/
    , { name = "Casino"
      , ingredients =
            [ ingredient oldTomGin (CL 4)
            , ingredient maraschino (CL 1)
            , ingredient orangeBitters (CL 1)
            , ingredient lemonJuice (CL 1)
            , ingredient lemon (Custom "twist")
            , ingredient cherry (Whole 1)
            ]
      , description = """Pour all ingredients into shaker with ice cubes, shake well. Strain into chilled cocktail glass and garnish with a lemon twist and a marachino cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Clover_Club_Cocktail
    -- https://iba-world.com/iba-official-cocktails/clover-club/
    , { name = "Clover club"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient lemonJuice (CL 1.5)
            , ingredient raspberrySyrup (CL 1.5)
            , ingredient eggWhite FewDrops
            , ingredient raspberry (Whole 2)
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well. Strain into cocktail glass. Garnish with fresh raspberries."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Daiquiri
    -- https://iba-world.com/iba-official-cocktails/daiquiri/
    , { name = "Daiquiri"
      , ingredients =
            [ ingredient whiteRum (CL 4.5)
            , ingredient lemonJuice (CL 2.5)
            , ingredient simpleSyrup (CL 1.5)
            ]
      , description = """Pour all ingredients into shaker with ice cubes. Shake well. Double Strain in chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Derby_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/derby/
    , { name = "Derby"
      , ingredients =
            [ ingredient gin (CL 6)
            , ingredient peachBitters (Drop 2)
            , ingredient mint (Custom "leaves")
            ]
      , description = """Pour all ingredients into a mixing glass with ice. Stir. Strain into a cocktail glass. Garnish with fresh mint leaves in the drink."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Martini_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/dry-martini/
    , { name = "Dry martini"
      , ingredients =
            [ ingredient gin (CL 6)
            , ingredient dryVermouth (CL 1)
            , ingredient lemon (Custom "peel")
            , ingredient olive (Whole 1)
            ]
      , description = """Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Gin_fizz
    -- https://iba-world.com/iba-official-cocktails/gin-fizz/
    , { name = "Gin fizz"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient lemonJuice (CL 3)
            , ingredient simpleSyrup (CL 1)
            , ingredient sodaWater (CL 8)
            , ingredient lemon (Slice 1)
            ]
      , description = """Shake all ingredients with ice cubes, except soda water. Pour into tumbler. Top with soda water. Garnish with lemon slice."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/John_Collins_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/john-collins/
    , { name = "John collins"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient lemonJuice (CL 3)
            , ingredient simpleSyrup (CL 1.5)
            , ingredient sodaWater (CL 6)
            , ingredient angosturaBitters (Dash 1)
            , ingredient lemon (Slice 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish with lemon slice and maraschino cherry. Add a dash of Angostura bitters."""
      , glass = Collins
      }

    -- https://en.wikipedia.org/wiki/Manhattan_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/manhattan/
    , { name = "Manhattan"
      , ingredients =
            [ ingredient ryeWhiskey (CL 5)
            , ingredient sweetRedVermouth (CL 2)
            , ingredient angosturaBitters (Dash 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with cocktail cherry."""
      , glass = Cocktail
      }

    -- https://iba-world.com/iba-official-cocktails/mary-pickford/
    -- https://en.wikipedia.org/wiki/Mary_Pickford_(cocktail)
    , { name = "Mary pickford"
      , ingredients =
            [ ingredient whiteRum (CL 6)
            , ingredient pineappleJuice (CL 6)
            , ingredient grenadine (CL 1)
            , ingredient maraschino (CL 1)
            ]
      , description = """Shake and strain into a chilled large cocktail glass"""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Monkey_Gland
    -- https://iba-world.com/iba-official-cocktails/monkey-gland/
    , { name = "Monkey gland"
      , ingredients =
            [ ingredient gin (CL 5)
            , ingredient oj (CL 3)
            , ingredient absinthe (Drop 2)
            , ingredient grenadine (Drop 2)
            ]
      , description = """Shake well over ice cubes in a shaker, strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/iba-official-cocktails/negroni/
    , { name = "Negroni"
      , ingredients =
            [ ingredient gin (CL 3)
            , ingredient sweetRedVermouth (CL 3)
            , ingredient campari (CL 3)
            , ingredient orange (Slice 0.5)
            ]
      , description = """Pour all ingredients directly into old-fashioned glass filled with ice. Stir gently. Garnish with half orange slice."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Old_fashioned_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/old-fashioned/
    , { name = "Old fashioned"
      , ingredients =
            [ ingredient whiskey (CL 4.5)
            , ingredient angosturaBitters (Dash 2)
            , ingredient sugar (Cube 1)
            , ingredient water FewDashes
            , ingredient orange (Slice 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Place sugar cube in old-fashioned glass and saturate with bitters, add a dash of plain water. Muddle until dissolve. Fill the glass with ice cubes and add whiskey. Garnish with orange slice and a cocktail cherry."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Paradise_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/paradise/
    , { name = "Paradise"
      , ingredients =
            [ ingredient gin (CL 3.5)
            , ingredient apricotBrandy (CL 2)
            , ingredient oj (CL 1.5)
            ]
      , description = """Shake together over ice. Strain into cocktail glass and serve chilled."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Planter%27s_punch
    -- https://iba-world.com/iba-official-cocktails/planters-punch/
    , { name = "Planter’s punch"
      , ingredients =
            [ ingredient darkRum (CL 4.5)
            , ingredient oj (CL 3.5)
            , ingredient pineappleJuice (CL 3.5)
            , ingredient lemonJuice (CL 2)
            , ingredient grenadine (CL 1)
            , ingredient simpleSyrup (CL 1)
            , ingredient angosturaBitters (Dash 3)
            , ingredient cherry (Whole 1)
            , ingredient pineapple (Slice 1)
            ]
      , description = """Pour all ingredients, except the bitters, into shaker filled with ice. Shake well. Pour into large glass, filled with ice. Add dash Angostura bitters. Garnish with cocktail cherry and pineapple."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Porto_flip
    -- https://iba-world.com/iba-official-cocktails/porto-flip/
    , { name = "Porto flip"
      , ingredients =
            [ ingredient brandy (CL 1.5)
            , ingredient pport (CL 4.5)
            , ingredient eggYolk (CL 1)
            , ingredient nutmeg None
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well. Strain into cocktail glass. Sprinkle with fresh ground nutmeg."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Fizz_(cocktail)#Ramos_gin_fizz
    -- https://iba-world.com/iba-official-cocktails/ramos-fizz/
    , { name = "Ramos fizz"
      , ingredients =
            [ ingredient gin (CL 4.5)
            , ingredient cream (CL 6)
            , ingredient simpleSyrup (CL 3)
            , ingredient limeJuice (CL 1.5)
            , ingredient lemonJuice (CL 1.5)
            , ingredient eggWhite (Whole 1)
            , ingredient orangeFlowerWater (Dash 3)
            , ingredient vanillaExtract (Drop 2)
            , ingredient sodaWater None
            ]
      , description = """Pour all ingredients (except soda) in a mixing glass, dry shake (no ice) for two minutes, add ice and hard shake for another minute. Strain into a highball glass without ice, top with soda."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Rusty_Nail_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/rusty-nail/
    , { name = "Rusty nail"
      , ingredients =
            [ ingredient scotchWhiskey (CL 4.5)
            , ingredient drambuie (CL 2.5)
            , ingredient lemon (Custom "twist")
            ]
      , description = """Pour all ingredients directly into old-fashioned glass filled with ice. Stir gently. Garnish with a lemon twist."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Sazerac
    -- https://iba-world.com/iba-official-cocktails/sazerac/
    , { name = "Sazerac"
      , ingredients =
            [ ingredient cognac (CL 5)
            , ingredient absinthe (CL 1)
            , ingredient sugar (Cube 1)
            , ingredient peychaudsBitters (Dash 2)
            , ingredient lemon (Custom "peel")
            ]
      , description = """Rinse a chilled old-fashioned glass with the absinthe, add crushed ice and set it aside. Stir the remaining ingredients over ice and set it aside. Discard the ice and any excess absinthe from the prepared glass, and strain the drink into the glass. Add the Lemon peel for garnish. Note: The original recipe changed after the American Civil War, rye whiskey substituted cognac as it became hard to obtain."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Screwdriver_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/screwdriver/
    , { name = "Screwdriver"
      , ingredients =
            [ ingredient vodka (CL 5)
            , ingredient oj (CL 10)
            , ingredient orange (Slice 1)
            ]
      , description = """Pour all ingredients into a highball glass filled with ice. Stir gently. Garnish with an orange slice."""
      , glass = Highball
      }

    -- https://iba-world.com/iba-official-cocktails/sidecar/
    , { name = "Sidecar"
      , ingredients =
            [ ingredient cognac (CL 5)
            , ingredient tripleSec (CL 2)
            , ingredient lemonJuice (CL 2)
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice. Shake well and strain into cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Stinger_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/stinger/
    , { name = "Stinger"
      , ingredients =
            [ ingredient cognac (CL 5)
            , ingredient whiteCremeDeMenthe (CL 2)
            ]
      , description = """Pour in a mixing glass with ice, stir and strain into a cocktail glass. May also be served on rocks in a rocks glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Tuxedo_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/tuxedo/
    , { name = "Tuxedo"
      , ingredients =
            [ ingredient oldTomGin (CL 3)
            , ingredient dryVermouth (CL 3)
            , ingredient maraschino (Tsp 0.5)
            , ingredient absinthe (Tsp 0.25)
            , ingredient orangeBitters (Dash 3)
            , ingredient cherry (Whole 1)
            , ingredient lemon (Custom "twist")
            ]
      , description = """Stir all ingredients with ice and strain into cocktail glass. Garnish with a cocktail cherry and a lemon zest twist."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Whiskey_sour
    -- https://iba-world.com/iba-official-cocktails/whiskey-sour/
    , { name = "Whiskey sour"
      , ingredients =
            [ ingredient bourbonWhiskey (CL 4.5)
            , ingredient lemonJuice (CL 3)
            , ingredient simpleSyrup (CL 1.5)
            , optionalIngredient eggWhite (Dash 1)
            , ingredient cherry (Whole 1)
            , ingredient orange (Slice 0.5)
            ]
      , description = """Egg white is optional. Pour all ingredients into cocktail shaker filled with ice. Shake well (a little harder if using egg white). Strain in cocktail glass. Garnish with half orange slice and maraschino cherry."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Sour_(cocktail)#White_Lady
    -- https://iba-world.com/iba-official-cocktails/white-lady/
    , { name = "White lady"
      , ingredients =
            [ ingredient gin (CL 4)
            , ingredient tripleSec (CL 3)
            , ingredient lemonJuice (CL 2)
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/french-connection/
    , { name = "French connection"
      , ingredients =
            [ ingredient cognac (CL 3.5)
            , ingredient amaretto (CL 3.5)
            ]
      , description = """Pour all ingredients directly into old fashioned glass filled with ice cubes. Stir gently."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/mint-julep/
    , { name = "Mint julep"
      , ingredients =
            [ ingredient bourbonWhiskey (CL 6)
            , ingredient mint (Sprig 5)
            , ingredient water (Tsp 2)
            , ingredient powderedSugar (Tsp 1)
            ]
      , description = """In steel cup gently muddle 4 mint sprigs with sugar and water. Fill the glass with cracked ice, add the Bourbon and stir well until the cup frosts. Garnish with a mint sprig."""
      , glass = SteelCup
      }

    -- https://en.wikipedia.org/wiki/White_Russian_(cocktail)
    , { name = "White russian"
      , ingredients =
            [ ingredient vodka (CL 5)
            , ingredient coffeeLiqueur (CL 2)
            , ingredient cream (CL 3)
            ]
      , description = """Pour vodka and coffee liqueur into an old fashioned glass filled with ice cubes. Float fresh cream on the top and stir in slowly.."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/cocktails/bloody-mary/
    , { name = "Bloody Mary"
      , ingredients =
            [ ingredient vodka (CL 4.5)
            , ingredient tomatoJuice (CL 9)
            , ingredient lemonJuice (CL 1.5)
            , ingredient worcestershireSauce (Dash 2)
            , ingredient tabasco None
            , ingredient celerySalt None
            , ingredient pepper None
            , ingredient celery None
            , ingredient lemon (Wedge 1)
            ]
      , description = """Stir gently all the ingredients in a mixing glass with ice. Add tabasco, celery salt, pepper to taste. Pour into rocks glass. Garnish with celery and lemon wedge. If requested served with ice, pour into highball glass."""
      , glass = Highball
      }

    -- https://iba-world.com/cocktails/champagne-cocktail/
    , { name = "Champagne cocktail"
      , ingredients =
            [ ingredient champagne (CL 9)
            , ingredient cognac (CL 1)
            , ingredient angosturaBitters (Dash 2)
            , ingredient sugar (Cube 1)
            , optionalIngredient grandMarnier FewDrops
            , ingredient orange (Custom "zest")
            , ingredient cherry (Whole 1)
            ]
      , description = """Place the sugar cube with 2 dashes of bitters in a large Champagne glass, add the cognac. Optionally add a few drops of Grand Marnier. Pour gently chilled Champagne. Garnish with orange zest and cherry."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/kir/
    , { name = "Kir"
      , ingredients =
            [ ingredient dryWhiteWine (CL 9)
            , ingredient cremeDeCassis (CL 1)
            ]
      , description = """Pour Crème de Cassis into glass, top up with white wine."""
      , glass = Wine
      }
    , { name = "Kir royal"
      , ingredients =
            [ ingredient champagne (CL 9)
            , ingredient cremeDeCassis (CL 1)
            ]
      , description = """Pour Crème de Cassis into glass, top up with Champagne."""
      , glass = Wine
      }

    -- https://iba-world.com/cocktails/long-island-iced-tea/
    , { name = "Long island iced tea"
      , ingredients =
            [ ingredient vodka (CL 1.5)
            , ingredient tequila (CL 1.5)
            , ingredient whiteRum (CL 1.5)
            , ingredient gin (CL 1.5)
            , ingredient cointreau (CL 1.5)
            , ingredient lemonJuice (CL 2.5)
            , ingredient simpleSyrup (CL 3)
            , ingredient cola None
            , ingredient lemon (Slice 1)
            ]
      , description = """Add all ingredients into highball glass filled with ice. Top with cola. Stir gently. Garnish with lemon slice."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Mai_Tai
    -- https://iba-world.com/cocktails/mai-tai/
    , { name = "Mai-tai"
      , ingredients =
            [ ingredient whiteRum (CL 3) -- “Amber Jamaican Rum”
            , ingredient darkRum (CL 3) -- “Martinique Molasses Rhum”
            , ingredient curacao (CL 1.5)
            , ingredient orgeatSyrup (CL 1.5)
            , ingredient limeJuice (CL 3)
            , ingredient simpleSyrup (CL 0.75)
            , ingredient pineapple (Custom "spear")
            , ingredient mint (Custom "leaves")
            , ingredient lime (Custom "peel")
            ]
      , description = """Add all ingredients into a shaker with ice. Shake and pour into a double rocks glass or an highball glass. Garnish with pineapple spear, mint leaves, and lime peel."""
      , glass = Highball
      }

    -- https://iba-world.com/cocktails/margarita/
    , { name = "Margarita"
      , ingredients =
            [ ingredient tequila (CL 5)
            , ingredient tripleSec (CL 2)
            , ingredient limeJuice (CL 1.5)
            , optionalIngredient salt None
            ]
      , description = """Add all ingredients into a shaker with ice. Shake and strain into a chilled cocktail glass. Garnish with a half salt rim (optional)."""
      , glass = Margarita
      }

    -- https://iba-world.com/new-era-drinks/tommys-margarita/
    , { name = "Tommy’s margarita"
      , ingredients =
            [ ingredient tequila (CL 4.5)
            , ingredient limeJuice (CL 1.5)
            , ingredient agaveNectar (Tsp 2)
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Margarita
      }

    -- https://iba-world.com/new-era-drinks/b52-2/
    , { name = "B52"
      , ingredients =
            [ ingredient coffeeLiqueur (CL 2)
            , ingredient tripleSec (CL 2)
            , ingredient irishCream (CL 2)
            ]
      , description = """Layer ingredients one at a time starting with coffee liqueur, followed by irish cream and top with triple sec. Flame the triple sec, serve while the flame is still on, accompanied with a straw on side plate."""
      , glass = OldFashioned
      }

    -- https://en.wikipedia.org/wiki/Barracuda_(cocktail)
    -- https://iba-world.com/new-era-drinks/barracuda/
    , { name = "Barracuda"
      , ingredients =
            [ ingredient goldRum (CL 4.5)
            , ingredient galliano (CL 1.5)
            , ingredient pineappleJuice (CL 6)
            , ingredient limeJuice (Dash 1)
            , ingredient prosecco None
            ]
      , description = """Shake together with ice. Strain into glass and serve."""
      , glass = Margarita
      }

    -- https://iba-world.com/cocktails/corpse-reviver-2-all-day/
    , { name = "Corpse reviver #2"
      , ingredients =
            [ ingredient gin (CL 3)
            , ingredient cointreau (CL 3)
            , ingredient lilletBlanc (CL 3)
            , ingredient lemonJuice (CL 3)
            , ingredient absinthe (Dash 1)
            , ingredient orange (Custom "zest")
            ]
      , description = """Pour all ingredients into shaker with ice. Shake well and strain in chilled cocktail glass. Garnish with orange zest."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/cosmopolitan/
    , { name = "Cosmopolitan"
      , ingredients =
            [ ingredient vodka (CL 4) -- Vodka citron
            , ingredient cointreau (CL 1.5)
            , ingredient limeJuice (CL 1.5)
            , ingredient cranberryJuice (CL 3)
            , ingredient lemon (Custom "twist")
            ]
      , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass. Garnish with lemon twist."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/dirty-martini/
    , { name = "Dirty martini"
      , ingredients =
            [ ingredient vodka (CL 6)
            , ingredient dryVermouth (CL 1)
            , ingredient oliveJuice (CL 1)
            , ingredient olive (Whole 1)
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain in chilled martini glass. Garnish with green olive."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/espresso-martini/
    , { name = "Espresso martini"
      , ingredients =
            [ ingredient vodka (CL 5)
            , ingredient coffeeLiqueur (CL 1)
            , ingredient simpleSyrup None
            , ingredient espresso (Custom "1 shot")
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/golden-dream/
    , { name = "Golden dream"
      , ingredients =
            [ ingredient tripleSec (CL 2)
            , ingredient galliano (CL 2)
            , ingredient oj (CL 2)
            , ingredient cream (CL 1)
            ]
      , description = """Pour all ingredients into shaker filled with ice. Shake briskly for few seconds. Strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/grasshopper/
    , { name = "Grasshopper"
      , ingredients =
            [ ingredient whiteCremeDeCacao (CL 2)
            , ingredient greenCremeDeMenthe (CL 2)
            , ingredient cream (CL 2)
            , optionalIngredient mint (Custom "1 leave")
            ]
      , description = """Pour all ingredients into shaker filled with ice. Shake briskly for few seconds. Strain into chilled cocktail glass. Garnish with mint leaf (optional)."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/hemingway-special/
    , { name = "Hemingway special"
      , ingredients =
            [ ingredient whiteRum (CL 6) -- IBA doesn’t specify “white”
            , ingredient grapefruitJuice (CL 4)
            , ingredient maraschino (CL 1.5)
            , ingredient limeJuice (CL 1.5)
            ]
      , description = """Pour all ingredients into a shaker with ice. Shake well and strain into a large cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/cocktails/horses-neck/
    , { name = "Horse’s neck"
      , ingredients =
            [ ingredient cognac (CL 4)
            , ingredient gingerAle (CL 12)
            , ingredient angosturaBitters FewDashes
            , ingredient lemon (Custom "peel")
            ]
      , description = """Pour Cognac and ginger ale directly into highball glass with ice cubes. Stir gently. If preferred, add dashes of Angostura Bitter. Garnish with rind of one lemon spiral."""
      , glass = Collins
      }

    -- https://iba-world.com/cocktails/irish-coffee/
    , { name = "Irish coffee"
      , ingredients =
            [ ingredient irishWhiskey (CL 5)
            , ingredient coffee (CL 12)
            , ingredient cream (CL 5)
            , ingredient sugar (Tsp 1)
            ]
      , description = """Warm black coffee is poured into a pre-heated Irish coffee glass. Whiskey and at least one teaspoon of sugar is added and stirred until dissolved. Fresh thick chilled cream is carefully poured over the back of a spoon held just above the surface of the coffee. The layer of cream will float on the coffee without mixing. Plain sugar can be replaced with sugar syrup."""
      , glass = IrishCoffeeMug
      }
    , { name = "Tom collins"
      , ingredients =
            [ ingredient oldTomGin (CL 4.5)
            , ingredient lemonJuice (CL 3)
            , ingredient simpleSyrup (CL 1.5)
            , ingredient sodaWater (CL 6)
            , ingredient angosturaBitters (Dash 1)
            , ingredient lemon (Slice 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Pour all ingredients directly into highball glass filled with ice. Stir gently. Garnish with lemon slice and maraschino cherry. Add a dash of Angostura bitters."""
      , glass = Collins
      }

    -- https://iba-world.com/cocktails/pina-colada/
    , { name = "Pina Colada"
      , ingredients =
            [ ingredient whiteRum (CL 5)
            , ingredient coconutCream (CL 3)
            , ingredient pineappleJuice (CL 5)
            , ingredient pineapple (Slice 1)
            , ingredient cherry (Whole 1)
            ]
      , description = """Blend all the ingredients with ice in a electric blender, pour into a large glass and serve with straws. Garnish with a slice of pineapple with a cocktail cherry. 4 slices of fresh pineapple can be used instead of juice. Historically a few drops of fresh lime juice was added to taste."""
      , glass = Hurricane
      }

    -- https://iba-world.com/new-era-drinks/pisco-sour/
    -- https://iba-world.com/cocktails/pisco-sour-2/
    , { name = "Pisco Sour"
      , ingredients =
            [ ingredient pisco (CL 4.5)
            , ingredient simpleSyrup (CL 2)
            , ingredient lemonJuice (CL 3)
            , ingredient eggWhite (Whole 1)
            , ingredient angosturaBitters (Dash 1)
            ]
      , description = """Shake and strain into a chilled champagne flute. Dash some Angostura bitters on top."""
      , glass = ChampagneFlute
      }

    -- https://iba-world.com/new-era-drinks/russian-spring-punch/
    , { name = "Russian spring punch"
      , ingredients =
            [ ingredient vodka (CL 2.5)
            , ingredient lemonJuice (CL 2.5)
            , ingredient cremeDeCassis (CL 1.5)
            , ingredient simpleSyrup (CL 1)
            , ingredient sparklingWine None
            , ingredient lemon (Slice 1)
            , ingredient blackberry (Whole 1)
            ]
      , description = """Shake the ingredients and pour into highball glass. Top with Sparkling wine. Garnish with a lemon slice and a blackberry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Sea_Breeze_(cocktail)
    -- https://iba-world.com/cocktails/sea-breeze/
    , { name = "Sea breeze"
      , ingredients =
            [ ingredient vodka (CL 4)
            , ingredient cranberryJuice (CL 12)
            , ingredient grapefruitJuice (CL 3)
            , ingredient orange (Custom "zest")
            , ingredient cherry (Whole 1)
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with an orange zest and cherry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Sex_on_the_Beach
    -- https://iba-world.com/cocktails/sex-on-the-beach/
    , { name = "Sex on the beach"
      , ingredients =
            [ ingredient vodka (CL 4)
            , ingredient peachSchnapps (CL 2)
            , ingredient oj (CL 4)
            , ingredient cranberryJuice (CL 4)
            , ingredient grapefruitJuice (CL 3)
            , ingredient orange (Slice 0.5)
            ]
      , description = """Build all ingredients in a highball glass filled with ice. Garnish with an orange zest and cherry."""
      , glass = Highball
      }

    -- https://en.wikipedia.org/wiki/Singapore_Sling
    -- https://iba-world.com/cocktails/singapore-sling/
    , { name = "Singapore sling"
      , ingredients =
            [ ingredient gin (CL 3)
            , ingredient cherryLiqueur (CL 1.5)
            , ingredient cointreau (CL 0.75)
            , ingredient domBenedictine (CL 0.75)
            , ingredient pineappleJuice (CL 12)
            , ingredient limeJuice (CL 1.5)
            , ingredient grenadine (CL 1)
            , ingredient angosturaBitters (Dash 1)
            , ingredient cherry (Whole 1)
            , ingredient pineapple (Slice 1)
            ]
      , description = """Pour all ingredients into cocktail shaker filled with ice cubes. Shake well. Strain into Hurricane glass. Garnish with pineapple and maraschino cherry."""
      , glass = Hurricane
      }

    -- https://en.wikipedia.org/wiki/Spritz_Veneziano
    -- https://iba-world.com/cocktails/tequila-sunrise/
    , { name = "Tequila sunrise"
      , ingredients =
            [ ingredient tequila (CL 4.5)
            , ingredient oj (CL 9)
            , ingredient grenadine (CL 1.5)
            , ingredient orange (Slice 0.5)
            ]
      , description = """Pour tequila and orange juice directly into highball glass filled with ice cubes. Add the grenadine syrup to create chromatic effect (sunrise), do not stir. Garnish with half orange slice or an orange zest."""
      , glass = Collins
      }

    -- https://en.wikipedia.org/wiki/Yellow_Bird_(cocktail)
    -- https://iba-world.com/new-era-drinks/yellow-bird/
    -- https://open.spotify.com/track/5ced30fVo8XlDpmoVnUZqp
    , { name = "Yellow bird"
      , ingredients =
            [ ingredient whiteRum (CL 3)
            , ingredient galliano (CL 1.5)
            , ingredient tripleSec (CL 1.5)
            , ingredient limeJuice (CL 1.5)
            ]
      , description = """Shake and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Zombie_(cocktail)
    -- https://iba-world.com/cocktails/zombie/
    , { name = "Zombie"
      , ingredients =
            [ ingredient darkRum (CL 4.5) -- Jamaican dark rum
            , ingredient goldRum (CL 4.5) -- Gold Puerto Rican rum
            , ingredient demeraraRum (CL 3) -- Rum from guyana
            , ingredient limeJuice (CL 2)
            , ingredient falernum (CL 1.5)
            , ingredient grapefruitJuice (CL 1) -- With cinnamon syrup making up “Donn’s mix”.
            , ingredient cinnamonSyrup (CL 0.5)
            , ingredient grenadine (Tsp 1)
            , ingredient angosturaBitters (Dash 1)
            , ingredient absinthe (Dash 2)
            , ingredient mint (Custom "leaves")
            ]
      , description = """Add all ingredients into an electric blender with 170 grams of cracked ice. With pulse bottom blend for a few seconds. Serve in a tall tumbler glass. Garnish with mint leaves."""
      , glass = ZombieGlass
      }

    -- https://iba-world.com/iba-official-cocktails/brandy-crusta/
    , { name = "Brandy crusta"
      , ingredients =
            [ ingredient brandy (CL 5.25)
            , ingredient lemonJuice (CL 1.5)
            , ingredient maraschino (CL 0.75)
            , ingredient curacao (Tsp 1)
            , ingredient simpleSyrup (Tsp 1)
            , ingredient aromaticBitters (Dash 2)
            , ingredient orange (Slice 1)
            , ingredient powderedSugar (Tsp 1)
            ]
      , description = """Mix together all ingredients with ice cubes in a mixing glass and strain into prepared slim cocktail glass. Rub a slice of orange (or lemon) around the rim of the glass and dip it in pulverized white sugar, so that the sugar will adhere to the edge of the glass. Carefully curling place the orange/lemon peel around the inside of the glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Hanky-Panky_cocktail
    -- https://iba-world.com/iba-official-cocktails/hanky-panky/
    , { name = "Hanky panky"
      , ingredients =
            [ ingredient londonDryGin (CL 4.5)
            , ingredient sweetRedVermouth (CL 4.5)
            , ingredient fernetBranca (CL 0.75)
            , ingredient orange (Custom "zest")
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with orange zest."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Last_Word_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/last-word/
    , { name = "Last word"
      , ingredients =
            [ ingredient gin (CL 2.25)
            , ingredient greenChartreuse (CL 2.25)
            , ingredient maraschino (CL 2.25)
            , ingredient limeJuice (CL 2.25)
            ]
      , description = """Add all ingredients into a cocktail shaker. Shake with ice and strain into a chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Martinez_(cocktail)
    -- https://iba-world.com/iba-official-cocktails/martinez/
    , { name = "Martinez"
      , ingredients =
            [ ingredient londonDryGin (CL 4.5)
            , ingredient sweetRedVermouth (CL 4.5)
            , ingredient maraschino (Tsp 1)
            , ingredient orangeBitters (Dash 2)
            , ingredient lemon (Custom "zest")
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with Lemon zest."""
      , glass = Cocktail
      }

    -- https://iba-world.com/iba-official-cocktails/vieux-carre/
    , { name = "Vieux carré"
      , ingredients =
            [ ingredient ryeWhiskey (CL 3)
            , ingredient cognac (CL 3)
            , ingredient sweetRedVermouth (CL 3)
            , ingredient domBenedictine (Tsp 1)
            , ingredient peychaudsBitters (Dash 2)
            , ingredient orange (Custom "zest")
            , ingredient cherry (Whole 1)
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass. Garnish with orange zest and maraschino cherry."""
      , glass = Cocktail
      }

    -- https://en.wikipedia.org/wiki/Bee's_Knees_(cocktail)
    -- https://iba-world.com/new-era-drinks/bees-knees/
    , { name = "Bee’s nees"
      , ingredients =
            [ ingredient londonDryGin (CL 5.25) -- Just “dry gin”
            , ingredient honeySyrup (Tsp 2)
            , ingredient lemonJuice (CL 2.25)
            , ingredient oj (CL 2.25)
            , optionalIngredient orange (Custom "zest")
            ]
      , description = """Stir honey with lemon and orange juices until it dissolves, add gin and shake with ice. Strain into a chilled cocktail glass. Optionally garnish with a lemon or orange zest."""
      , glass = Cocktail
      }

    -- https://iba-world.com/news/cachanchara/
    , { name = "Cachanchara"
      , ingredients =
            [ ingredient cubanAguardiente (CL 6)
            , ingredient lemonJuice (CL 1.5)
            , ingredient honey (CL 1.5)
            , ingredient water (CL 5)
            , ingredient lime (Wedge 1)
            ]
      , description = """Mix honey with water and lime juice and spread the mixture on the bottom and sides of the glass. Add cracked ice, and then the rum. End by energetically stirring from bottom to top. Garnish with Lime wedge."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/new-era-drinks/fernandito/
    , { name = "Fernandito"
      , ingredients =
            [ ingredient fernetBranca (CL 5)
            , ingredient cola None
            ]
      , description = """Pour the Fernet Branca into a double old fashioned glass with ice, fill the glass up with Cola. Gently stir."""
      , glass = Highball -- Double old fashioned?
      }

    -- https://iba-world.com/new-era-drinks/old-cuban/
    , { name = "Old cuban"
      , ingredients =
            [ ingredient rum (CL 4.5) -- “Aged rum”
            , ingredient sparklingWine (CL 6) -- “Brut champagne or prosecco”
            , ingredient limeJuice (CL 2.25)
            , ingredient simpleSyrup (CL 3)
            , ingredient angosturaBitters (Dash 2)
            , ingredient mint (Sprig 3)
            ]
      , description = """Pour all ingredients into cocktail shaker except the wine, shake well with ice, strain into chilled elegant cocktail glass. Top up with the sparkling wine. Garnish with mint springs."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/paloma/
    , { name = "Paloma"
      , ingredients =
            [ ingredient tequila (CL 5) -- “100% Agave Tequila”
            , ingredient grapefruitSoda (CL 10) -- Pink Grapefruit Soda
            , ingredient limeJuice (Tsp 2)
            , ingredient salt None
            , ingredient lime (Slice 1)
            ]
      , description = """Poor the tequila into a highball glass, squeeze the lime juice. Add ice and salt, fill up pink grapefruit soda. Stir gently. Garnish with a slice of lime."""
      , glass = Highball
      }

    -- https://iba-world.com/new-era-drinks/paper-plane/
    , { name = "Paper plane"
      , ingredients =
            [ ingredient bourbonWhiskey (CL 3)
            , ingredient amaroNonino (CL 3)
            , ingredient aperol (CL 3)
            , ingredient lemonJuice (CL 3)
            ]
      , description = """Pour all ingredients into cocktail shaker, shake well with ice, strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/penicillin/
    , { name = "Penicillin"
      , ingredients =
            [ ingredient blendedScotchWhiskey (CL 6) -- “Blended Scotch Whisky”
            , ingredient islaySingleMaltScotch (CL 0.75) -- “Lagavulin 16y”
            , ingredient lemonJuice (CL 2.25)
            , ingredient honeySyrup (CL 2.25)
            , ingredient ginger (Slice 3)
            , ingredient candiedGinger (Whole 1)
            ]
      , description = """Muddle fresh ginger in a shaker and add the remaining ingredients, except for the Islay single malt whiskey. Fill the shaker with ice and shake. Double-strain into a chilled old fashioned glass with ice. Float the single malt whisky on top. Garnish with a candied ginger."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/new-era-drinks/southside/
    , { name = "Southside"
      , ingredients =
            [ ingredient londonDryGin (CL 6)
            , ingredient lemonJuice (CL 3)
            , ingredient simpleSyrup (CL 1.5)
            , ingredient mint (Sprig 2)
            , optionalIngredient eggWhite (CL 3)
            ]
      , description = """Egg white optional. Pour all ingredients into a cocktail shaker, shake well with ice, double-strain into chilled cocktail glass. If egg white is used shake vigorously. Garnish with mint springs."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/spicy-fifty/
    , { name = "Spicy fifty"
      , ingredients =
            [ ingredient vodka (CL 5)
            , ingredient elderflowerSyrup (CL 1.5) -- “Elder flower cordial”
            , ingredient lemonJuice (CL 1.5)
            , ingredient honeySyrup (CL 1) -- “Monin Honey Syrup”
            , ingredient vanillaExtract (Drop 1) -- “Vodka Vanilla” is used by IBA, so I instead added a drop of extract.
            , ingredient redChiliPepper None
            ]
      , description = """Pour all ingredients (including 2 thin slices of pepper) into a cocktail shaker, shake well with ice, double-strain into chilled cocktail glass. Garnish with a red chili pepper."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/suffering-bastard/
    , { name = "Suffering bastard"
      , ingredients =
            [ ingredient brandy (CL 3)
            , ingredient gin (CL 3)
            , ingredient limeJuice (CL 1.5)
            , ingredient angosturaBitters (Dash 2)
            , ingredient gingerBeer None
            , ingredient mint (Sprig 1)
            , optionalIngredient orange (Slice 1)
            ]
      , description = """Pour all ingredients into cocktail shaker except the ginger beer, shake well with ice, Pour unstrained into a Collins glass or in the original S. Bastard mug and top up with ginger beer. Garnish with mint sprig and optionally an orange slice as well."""
      , glass = Collins
      }

    -- https://iba-world.com/new-era-drinks/tipperary/
    , { name = "Tipperary"
      , ingredients =
            [ ingredient irishWhiskey (CL 5)
            , ingredient sweetRedVermouth (CL 2.5)
            , ingredient greenChartreuse (CL 1.5)
            , ingredient angosturaBitters (Dash 2)
            , ingredient orange (Slice 1)
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled martini cocktail glass. Garnish with a slice of orange."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/trinidad-sour/
    , { name = "Trinidad sour"
      , ingredients =
            [ ingredient angosturaBitters (CL 4.5)
            , ingredient orgeatSyrup (CL 3)
            , ingredient lemonJuice (CL 2.25)
            , ingredient ryeWhiskey (CL 1.5)
            ]
      , description = """Pour all ingredients into mixing glass with ice cubes. Stir well. Strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/ve-n-to/
    , { name = "Ve.n.to"
      , ingredients =
            [ ingredient grappa (CL 4.5) -- “White smooth grappa”
            , ingredient lemonJuice (CL 2.25)
            , ingredient honeySyrup (CL 1.5) -- “Honey mix”
            , ingredient chamomileSyrup (CL 1.5) -- “Chamomile cordial”
            , ingredient honeySyrup (CL 1.5) -- “Honey mix”
            , optionalIngredient eggWhite (CL 3)
            , ingredient lemon (Custom "zest")
            , ingredient whiteGrape (Whole 3)
            ]
      , description = """Egg white optional. Pour all ingredients into the shaker. Shake vigorously with ice. Strain into a chilled small tumbler glass filled with ice. Garnish with lemon zest and white grapes."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/new-era-drinks/illegal/
    , { name = "Illegal"
      , ingredients =
            [ ingredient mezcal (CL 3) -- “Espadin Mezcal”
            , ingredient overproofWhiteRum (CL 1.5) -- “Jamaica Overproof White Rum”
            , ingredient limeJuice (CL 2.25)
            , ingredient falernum (CL 1.5)
            , ingredient simpleSyrup (CL 1.5)
            , ingredient maraschino (Tsp 1)
            , optionalIngredient eggWhite (CL 3)
            ]
      , description = """Egg white optional. Pour all ingredients into the shaker. Shake vigorously with ice. Strain into a chilled cocktail glass, or “on the rocks” in a traditional clay or terracotta mug."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/naked-and-famous/
    , { name = "Naked and famous"
      , ingredients =
            [ ingredient mezcal (CL 2.25)
            , ingredient yellowChartreuse (CL 2.25)
            , ingredient aperol (CL 2.25)
            , ingredient limeJuice (CL 2.25)
            ]
      , description = """Pour all ingredients into cocktail shaker, shake well with ice, strain into chilled cocktail glass."""
      , glass = Cocktail
      }

    -- https://iba-world.com/new-era-drinks/new-york-sour/
    , { name = "New York sour"
      , ingredients =
            [ ingredient ryeWhiskey (CL 6) -- Or bourbon
            , ingredient lemonJuice (CL 3)
            , ingredient eggWhite (CL 3)
            , ingredient simpleSyrup (CL 2.25)
            , ingredient redWine (CL 1.5) -- “Shiraz or Malbech”
            , ingredient lemon (Custom "zest")
            , ingredient cherry (Whole 1)
            ]
      , description = """Bourbon can be used instead of rye. Pour all ingredients into the shaker. Shake vigorously with ice. Strain into a chilled rocks glass filled with ice. Float the wine on top. Garnish with lemon or orange zest with cherry."""
      , glass = OldFashioned
      }

    -- https://iba-world.com/new-era-drinks/spritz/
    , { name = "Spritz"
      , ingredients =
            [ ingredient prosecco (CL 9)
            , ingredient aperol (CL 6)
            , ingredient sodaWater (Splash 1)
            , ingredient orange (Slice 1)
            ]
      , description = """Build all ingredients into a wine glass filled with ice. Stir gently. Garnish with a slice of orange."""
      , glass = Wine
      }
    ]
