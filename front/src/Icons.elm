module Icons exposing (champagneFluteIcon, cocktailIcon, collinsIcon, copperMugIcon, oldFashionedIcon)

import Element exposing (html)
import Svg exposing (line, path, svg)
import Svg.Attributes exposing (d, fill, height, stroke, strokeWidth, viewBox, width, x1, x2, y1, y2)


sw : String
sw =
    "2"


oldFashionedIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 50 50" ]
        [ path [ d "M34.109 13H15v23.375c1.39.5 5.906 1.497 10.539 1.497 4.632 0 7.643-.998 8.57-1.497V13zM15 25.649h19.109", stroke "#000", strokeWidth sw ]
            []
        ]
        |> html


cocktailIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 50 50" ]
        [ path [ d "M23.7678 24.1659L13 9.15166L37.7204 9L27.1043 24.1659V39.0284H33.7773V41.455H17.0948V39.0284H23.7678V24.1659Z", stroke "#000", strokeWidth sw ]
            []
        , line [ x1 "15.5782", y1 "13.1564", x2 "34.6872", y2 "13.1564", stroke "black", strokeWidth sw ] []
        ]
        |> html


copperMugIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 50 50" ]
        [ path [ d "M31.109 13H12V36.3751C13.3897 36.8741 17.9064 37.872 22.5389 37.872C27.1714 37.872 30.1825 36.8741 31.109 36.3751V13Z", stroke "#000", strokeWidth sw ]
            []
        , path [ d "M31.109 19.0663H37.782V29.0758H31.109", stroke "#000", strokeWidth sw ]
            []
        ]
        |> html


champagneFluteIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 50 50" ]
        [ path [ d "M22.791 43.066V28.204L19 17.89 20.213 5h8.341l.91 12.891-3.336 10.313v14.862h3.943v2.427H19v-2.427h3.791zM19 10.521h10.009", stroke "#000", strokeWidth sw ]
            []
        ]
        |> html


collinsIcon =
    svg
        [ width "20", height "20", fill "none", viewBox "0 0 50 50" ]
        [ path [ d "M33.896 5H16v36.773c1.302.785 5.531 2.355 9.87 2.355 4.338 0 7.158-1.57 8.026-2.355V5zM16 25.232h17.896", stroke "#000", strokeWidth sw ]
            []
        ]
        |> html



-- <svg width="50" height="50" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="" stroke="#000" stroke-width="2"/></svg>
-- <svg width="50" height="50" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M22.791 43.066V28.204L19 17.89 20.213 5h8.341l.91 12.891-3.336 10.313v14.862h3.943v2.427H19v-2.427h3.791zM19 10.521h10.009" stroke="#000" stroke-width="2"/></svg>
-- <svg width="50" height="50" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="" stroke="#000" stroke-width="2"/></svg>
-- <svg width="50" height="50" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="" stroke="#000" stroke-width="2"/></svg>
