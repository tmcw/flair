# Old Fashioned

This is the software behind oldfashioned.tech. Given the, um, fast pace of development, there's
a little sawdust on the shop floor, so to speak. So, the application is in `/front`.

It's written in [Elm](https://elm-lang.org/), a lovely new language, and importantly uses [elm-ui](https://github.com/mdgriffith/elm-ui),
a very futuristic UI library. So it's a little different than most web apps, but **on the bright side**,
this _really_ fits into the Elm model super well, and also the data representation is super approachable.

## Set up

To get set up:

- You need [Node.js](https://nodejs.org/en/) installe:

Then install create-elm-app globally:

```
npm install create-elm-app -g
```

Then, once you've cloned this git repository, go into the `front` directory, and run

```
elm-app start
```

## The lay of the land

There's a smidge of 'modularization', in this case, basically moving things into files. The files are:

- `Main.elm`: the interface
- `Quantity.elm`: a system for representing quantities
- `Icons.elm`: um… icons
- `Data.elm`: all the recipes and stuff

A few concepts to get out of the way:

I refer to substances, like "Vodka", as Materials. This is because just "Vodka" is not an ingredient:
  6 Cl of Vodka is an ingredient.

Quantities are kind of fancy, they use Elm types! Some example quantities:

```
Dashes 2
FewDashes
CL 2
```

Same with glasses - there's a type for each kind of glass.

Note that all of the 'liquid' quantities are measured in CL, or Centiliters, because that's what
Wikipedia uses. We convert to all the other measures on the frontend.

So a recipe looks like this, and goes in a long list in Data.elm

```elm
-- https://en.wikipedia.org/wiki/Sour_(cocktail)#White_Lady
{ name = "White lady"
  , ingredients =
        [ { material = gin, quantity = CL 4 }
        , { material = tripleSec, quantity = CL 3 }
        , { material = lemonJuice, quantity = CL 2 }
        ]
  , description = """Add all ingredients into cocktail shaker filled with ice. Shake well and strain into large cocktail glass."""
  , glass = Cocktail
  }
```

Really, making recipes, Elm will usually tell you exactly what's wrong, which is really neat.
