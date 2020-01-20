module LearnSheetMusic exposing (..)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (type_, attribute, style)
import Html.Events exposing (onClick, onInput)
import List.Extra exposing (initialize)
import Random exposing (Generator)
import Svg exposing (circle, g, path, rect, svg)
import Svg.Attributes exposing (cx, cy, d, fill, height, r, stroke, strokeWidth, transform, viewBox, width, x, y)
import Debug


bassKey : Html Msg
bassKey =
    svg []
        [ path [ d "M95 0C46.286 0 20 35.035 20 68c0 16.393 5.134 30.499 14.848 40.794C44.851 119.396 58.736 125 75 125c16.569 0 30-13.431 30-30S91.569 65 75 65c-9.828 0-18.551 4.726-24.023 12.028C50.234 73.834 50 70.676 50 68c0-18.884 15.457-38 45-38 37.664 0 65 35.748 65 85 0 47.058-20.573 76.48-37.831 92.875C100.995 227.991 72.146 240 45 240v30c35.164 0 70.822-14.716 97.831-40.375C173.248 200.729 190 160.02 190 115c0-31.97-9.544-61.113-26.874-82.062C145.554 11.698 121.36 0 95 0z" ] []
        , circle [ cx "235", cy "60", r "15" ] []
        , circle [ cx "235", cy "120", r "15" ] []
        ]


trebleKey : Html Msg
trebleKey =
    svg []
        [ path [ d "M289.859 218.165c-12.238-12.083-28.92-18.736-46.975-18.736-.739 0-1.469.011-2.191.034-4.751-18.989-9.194-34.531-12.219-44.64a758.83 758.83 0 01-3.54-12.192c13.877-15.22 26.345-29.841 33.266-44.593 19.623-41.823 10.708-66.709 3.647-77.821C253.684 7.369 240.237 0 224.955 0c-13.893 0-25.356 5.533-33.149 16-15.284 20.528-15.407 58.521-.127 118.479-29.22 31.773-60.724 67.762-60.724 112.562 0 47.333 25.917 70.548 47.66 81.688 22.534 11.546 45.015 12.242 45.961 12.266l.379.005c3.073 0 6.112-.127 9.109-.378l.103 1.491c1.335 19.236 2.489 35.849.003 50.352-2.37 13.822-11.714 18.001-19.006 17.382-3.07-.261-10.21-1.744-10.21-9.848h-30c0 21.169 15.841 37.883 37.666 39.74 1.33.113 2.656.17 3.98.17a46.432 46.432 0 0027.914-9.306c10.179-7.647 16.827-19.082 19.225-33.069 3.095-18.055 1.826-36.334.356-57.5l-.317-4.583c-.043-.64-.088-1.279-.135-1.919 6.901-2.901 13.235-6.612 18.807-11.07 17.339-13.872 26.504-33.742 26.504-57.463.001-18.043-6.781-34.676-19.095-46.834zM215.868 33.916c1.515-2.034 3.663-3.916 9.086-3.916 3.451 0 8.261 1.094 11.573 6.307 2.361 3.716 8.945 18.232-5.486 48.989-3.165 6.746-8.459 14.108-14.908 21.894-10.675-50.874-4.268-67.898-.265-73.274zM225.237 311c-1.764-.087-18.08-1.109-33.732-9.38-20.557-10.862-30.55-28.715-30.55-54.579 0-27.928 19.13-54.306 40.316-78.423a1018.638 1018.638 0 0110.722 39.708c-12.94 9.11-19.038 23.895-19.038 38.007 0 11.36 4.616 21.066 12.997 27.331 6.43 4.806 14.077 6.893 21.186 7.503a682.259 682.259 0 014.186 29.57 77.704 77.704 0 01-6.087.263zm35.152-9.649c-3.197-25.015-7.776-49.574-12.6-71.639 18.327 2.149 31.166 16.328 31.166 35.288 0 17.468-7.698 29.136-18.566 36.351z" ] []
        ]


drawnNote : Int -> Html Msg
drawnNote yCord =
    path [ transform ("translate(0 " ++ String.fromInt yCord ++ ")"), d "M732.22,1141.9c-31.52-19.32-48.18-41.24-48.18-63.39H648v138.91a92.58,92.58,0,0,0-24.36-3.13c-20.95,0-42.32,6.23-58.63,17.11-30.41,20.27-34.22,50.72-8.49,67.88,11.08,7.38,26.42,11.45,43.2,11.45,21,0,42.31-6.23,58.62-17.11,14.22-9.47,23.17-21.47,25.23-33.79a32,32,0,0,0,.42-5.23h0v-112a197.61,197.61,0,0,0,23.82,17c38.13,23.36,30.08,53.23,11.61,71.71l29.95,13.31c28.44-28.44,34.15-71.22-17.2-102.69Z" ] []

type StaffMargin
    = Zero
    | Positive Int
    | Negative Int


getMargin : Int -> StaffMargin
getMargin position =
    if position > 0 && position < 8 then
        Zero

    else if position > 8 then
        Positive (position - 8)

    else
        Negative (abs position)


getPositiveLines : Int -> Html Msg
getPositiveLines index =
    let
        step =
            120

        start =
            153
    in
    rect [ width "584", height "5", x "0", y (String.fromInt (start - step * index)) ] []


getNegativeLines : Int -> Html Msg
getNegativeLines index =
    let
        step =
            120

        start =
            633
    in
    rect [ width "584", height "5", x "0", y (String.fromInt (start + step * index)) ] []

placeNote : Note -> Html Msg
placeNote note =
    drawnNote (-note.positionFromTheFirstLine * 60)

drawStaff : Note -> Html Msg
drawStaff note =
    svg [ style "width" "500px", viewBox "0 0 1200 2000", attribute "xmlns" "http://www.w3.org/2000/svg" ]
        [ path [ d "M8.32 1030.78h1187.36m-1187.36 240h1187.36m-1187.36-120h1187.36M8.32 910.78h1187.36M8.32 790.78h1187.36", attribute "stroke" "#131516", attribute "stroke-width" "6.89" ]
            []
        , path [ d "M1129.37 789.32v482.93", attribute "stroke" "#000", attribute "stroke-width" "6.53" ]
            []
        , rect [ attribute "height" "488", attribute "width" "41.05", attribute "x" "1158.84", attribute "y" "786.78" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "788" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "668" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "548" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "428" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "308" ]
            []
        , rect [ attribute "height" "5", attribute "width" "876", attribute "x" "2", attribute "y" "188" ]
            []
        , path [ d "M7 1623.74h1187.37M7 1863.74h1187.37M7 1743.74h1187.37M7 1503.74h1187.37M7 1383.74h1187.37", attribute "stroke" "#131516", attribute "stroke-width" "6.89" ]
            []
        , path [ d "M136.38 1108.82c-8.78 2.44-16.7 7.9-24 16.23s-10.94 17.8-10.94 27.86c0 6.32 2.15 13.5 6.33 21.11a37.77 37.77 0 0018.72 17c2.73.57 4 2 4 4 0 .71-1 1.43-3.46 2a59.82 59.82 0 01-45.2-57.3 76.68 76.68 0 0113.38-41.22q13-19.17 33.26-27.15l-9.93-51c-22.17 18.38-40.17 37.48-54.13 57.59q-21 29.94-21.74 65.06a85.5 85.5 0 006.48 30.44 82.46 82.46 0 0018.14 27c16.26 16.23 37.43 24.71 63.2 25.57a155.16 155.16 0 0028.21-4.74zm10.36-1.44l22.46 110.44c22.17-8.9 33.26-28.29 33.26-57.88a66.34 66.34 0 00-9.07-26.71 51.51 51.51 0 00-19.15-19 54.23 54.23 0 00-27.5-6.85zM117.23 958c4.75-2.87 10.22-7.9 16.13-14.93a176 176 0 0017.13-24.27 150.69 150.69 0 0013.39-28.44 81.84 81.84 0 004.89-26.86 47.55 47.55 0 00-1-10.34c-.57-5.17-2.16-9.19-4.89-11.92a14.73 14.73 0 00-10.51-4q-13 0-23.32 15.94a128.62 128.62 0 00-13 32.46 159.5 159.5 0 00-5.44 37.36c.72 14.2 3.02 25.83 6.62 35zm-9.07 8.33a297 297 0 01-10.8-71.09 207.64 207.64 0 014.76-43.51 129.47 129.47 0 0112.52-35.19c5.33-10 11.52-17.66 18.43-22.83 6.19-4.6 10.65-7 13.1-7a7.12 7.12 0 014.89 2 58.26 58.26 0 015.62 6.32q25.69 36.4 25.77 87.75a179.73 179.73 0 01-6.45 47.81 178.06 178.06 0 01-18.57 44.52 161.59 161.59 0 01-29.52 36.77l11.67 56.58c6.33-.72 10.65-1.29 13.1-1.29a64.62 64.62 0 0129.8 6.89 69.76 69.76 0 0123.18 18.67 86.18 86.18 0 0114.68 26.72 100 100 0 015.18 31.45 84.27 84.27 0 01-13.39 46.38c-8.92 13.94-22.31 24.13-40.31 30.74 1.16 7 3.17 17.23 6.19 30.3s5 23.7 6.48 31.45a122.7 122.7 0 012 22.55 55.62 55.62 0 01-30.81 51 65.94 65.94 0 01-30.95 7.33c-15.84 0-29.66-4.45-41.46-13.22s-18.14-20.82-18.72-36a51.26 51.26 0 014.9-19.1 38.15 38.15 0 0111.8-14.65 30.66 30.66 0 0117.56-6.32 30.72 30.72 0 0116 4.59 36 36 0 0112 12.64 36.44 36.44 0 014.47 17.52 29.66 29.66 0 01-8.64 21.55c-5.76 5.88-13.1 8.9-21.88 8.9h-3.4c5.62 8.62 14.83 13.07 27.65 13.07a54.48 54.48 0 0019.72-4 52.23 52.23 0 0017.13-10.92c4.75-4.59 7.92-9.48 9.21-14.65 2.45-5.88 3.6-14.07 3.6-24.27a112.4 112.4 0 00-2-20.68c-1.3-6.75-3.31-15.79-6-27-2.73-11-4.75-19.67-5.9-25.56a110.83 110.83 0 01-26.92 3.3 104.68 104.68 0 01-44.49-9.62 116.49 116.49 0 01-36.85-26.85 128.33 128.33 0 01-24.62-39.07 125.75 125.75 0 01-8.93-45.52 128.21 128.21 0 018.5-41.94 178.86 178.86 0 0120-37.77 312.76 312.76 0 0125.48-32.17c8.88-9.56 20.54-21.77 35.22-36.56z", attribute "data-name" "path9", fill "#131516", attribute "fill-rule" "evenodd", attribute "stroke" "#131516", attribute "stroke-width" "3" ]
            []
        , placeNote note
        ]

possibleTrebleNotes : List Note
possibleTrebleNotes =
    [ { name = "E", positionFromTheFirstLine = 14 }
    , { name = "D", positionFromTheFirstLine = 13 }
    , { name = "C", positionFromTheFirstLine = 12 }
    , { name = "B", positionFromTheFirstLine = 11 }
    , { name = "A", positionFromTheFirstLine = 10 }
    , { name = "G", positionFromTheFirstLine = 9 }
    , { name = "F", positionFromTheFirstLine = 8 }
    , { name = "E", positionFromTheFirstLine = 7 }
    , { name = "D", positionFromTheFirstLine = 6 }
    , { name = "C", positionFromTheFirstLine = 5 }
    , { name = "B", positionFromTheFirstLine = 4 }
    , { name = "A", positionFromTheFirstLine = 3 }
    , { name = "G", positionFromTheFirstLine = 2 }
    , { name = "F", positionFromTheFirstLine = 1 }
    , { name = "E", positionFromTheFirstLine = 0 }
    , { name = "D", positionFromTheFirstLine = -1 }
    , { name = "C", positionFromTheFirstLine = -2 }
    , { name = "B", positionFromTheFirstLine = -3 }
    , { name = "A", positionFromTheFirstLine = -4 }
    , { name = "G", positionFromTheFirstLine = -5 }
    , { name = "F", positionFromTheFirstLine = -6 }
    ]


notesArray : Array Note
notesArray =
    Array.fromList possibleTrebleNotes


type alias Note =
    { name : String
    , positionFromTheFirstLine : Int
    }


type Status
    = StartAndShowPreviousAnswer String
    | NoteIsShown Note


type Clef
    = Treble
    | Bass


type alias Model =
    { status : Status
    , clef : Clef
    , usersAnswer : String
    }


showPreviousAnswer : Status -> String -> Html Msg
showPreviousAnswer status usersAnswer =
    case status of
        StartAndShowPreviousAnswer note ->
            let
                info =
                    if note == usersAnswer then
                        "Hooray!"

                    else
                        "You lose, the note was " ++ note
            in
            div [] [ text info ]

        _ ->
            text ""


showStartPage : Model -> Html Msg
showStartPage model =
    div []
        [ showPreviousAnswer model.status model.usersAnswer
        , button [ onClick StartGame ] [ text "Start Game" ]
        ]

type alias SubmitEvent =
    { target : String
    }


showGamePage : Note -> Html Msg
showGamePage note =
    div []
        [ text ("What is this note?")
        , div []
            [ input [ type_ "text", onInput SetAnswer ] []
            , button [ onClick (SubmitAnswer note.name) ] [ text "Submit Answer" ]
            ]
        , drawStaff note
        ]


view : Model -> Html Msg
view model =
    case model.status of
        StartAndShowPreviousAnswer _ ->
            showStartPage model

        NoteIsShown note ->
            showGamePage note


initialModel : Model
initialModel =
    { status = StartAndShowPreviousAnswer ""
    , clef = Treble
    , usersAnswer = ""
    }


type Msg
    = SetNote Int
    | StartGame
      --| BackToStart String
    | SubmitAnswer String
    | SetAnswer String


noteGenerator : Generator Int
noteGenerator =
    Random.int 0 (Array.length notesArray)


getNote : Int -> Note
getNote position =
    let
        maybeNote =
            Array.get position notesArray
    in
    case maybeNote of
        Just note ->
            note

        Nothing ->
            { name = "E", positionFromTheFirstLine = 14 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartGame ->
            ( model, Random.generate SetNote noteGenerator )

        SetNote randomNumber ->
            ( { model | status = NoteIsShown (getNote randomNumber) }, Cmd.none )

        SubmitAnswer note ->
            ( { model | status = StartAndShowPreviousAnswer note }, Cmd.none )

        SetAnswer answer ->
            ( { model | usersAnswer = answer }, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
