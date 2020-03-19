module Icons exposing (champagneFluteIcon, cocktailIcon, collinsIcon, copperMugIcon, highballIcon, hurricaneIcon, irishCoffeeIcon, margaritaIcon, oldFashionedIcon, steelCupIcon, wineIcon)

import Element exposing (html)
import Svg exposing (line, path, svg)
import Svg.Attributes exposing (d, fill, height, stroke, strokeWidth, viewBox, width, x1, x2, y1, y2)


champagneFluteIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9.25 17v-5.616L8 7.5 8.5 3h3l.5 4.5-1.25 3.884V17H12v.63H8V17h1.25zM8 4.856h3.616", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


cocktailIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9 9.5L5.5 4h9l-3.501 5.5v4.75H13v1.25H7v-1.25h2.056L9 9.5zM6.5 5.5h7", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


collinsIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M13 4H7v12.5c.5.25 1.5.5 3 .5s2.712-.24 3-.5V4zM7 10.554l6-.054", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


copperMugIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M13 5H5v9.973c.593.213 2.024.527 4 .527s3.605-.314 4-.527V5zM13 7.5h3V12h-3", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


highballIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M13 4H6v11c.512.239 1.792.5 3.5.5s3.158-.261 3.5-.5V4zM6 10h7", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


hurricaneIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9.25 17.5V14L7.5 12.5 7 10l.5-1.75.25-1.75-.25-1.75L7 3h6l-.5 1.75-.25 1.75.25 1.75L13 10l-.5 2.5-1.75 1.5v3.5h1.582v.5H7.196v-.5H9.25z", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


irishCoffeeIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9 15v-2l-1-1-1-.5V4h6v7.5l-1 .5-1 1v2l1.332.5v.5H7.196v-.5L9 15zM13 5.5h2.5V9L13 10M7 6.5h6", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


margaritaIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9.25 16.5V9L7.8 8l-.3-1.5L5 5.25 4.5 3h11L15 5.25 12.5 6.5 12.2 8l-1.45 1v7.5h1.582v.5H7.196v-.5H9.25z", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


oldFashionedIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M14 5H6v10c.582.209 2.06.5 4 .5s3.612-.291 4-.5V5zM6 10h8", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


steelCupIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M14.5 4h-9L7 14.5c.5.25.75.5 3 .5 1.75 0 2.75-.25 3-.5L14.5 4zM6 6h8", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html


wineIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 20 20" ]
        [ path [ d "M9.25 16.5v-6L7.8 9 7 7l1-4h4l1 4-.8 2-1.45 1.5v6h1.582v.5H7.196v-.5H9.25z", stroke "#000", strokeWidth "1" ]
            []
        ]
        |> html
