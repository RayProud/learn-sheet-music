module LearnSheetMusic exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (div,button,label,text,input, Html, Attribute)
import Html.Attributes as HTMLAttr exposing (type_, attribute, style, checked)
import Html.Events exposing (onClick, onInput, on)
import Json.Decode as Decode exposing (field, int, Decoder, string)
import Random exposing (Generator)
import Svg exposing (path, rect, svg, g)
import Svg.Attributes exposing (d, fill, transform, viewBox)

bassKey : Html Msg
bassKey =
    g [ ] [
        path [ d "M331.3 854a24.3 24.3 0 01-8.3 18.79c-6.92 6.32-17.47 7.61-26.09 4.4a24.39 24.39 0 01-15.35-21c-.65-7.18 1.64-14.71 6.84-19.82a24.54 24.54 0 0119.29-7.34 24.28 24.28 0 0118.7 9.67 24.53 24.53 0 014.91 15.3z" ] []

         ,path [ d "M331.3 966.22a24.33 24.33 0 01-8.3 18.84c-6.92 6.32-17.47 7.62-26.09 4.4a24.39 24.39 0 01-15.35-21 25.24 25.24 0 016.83-19.8c4.8-5.35 12.17-7.79 19.24-7.37 9.29.26 17.73 6.59 21.58 14.89a24.07 24.07 0 012.09 10.04z" ]
                []

         ,path [ d "M249.05 932.08c.87 54.26-23.35 107-61.75 144.79-47.82 47.8-110.4 78.21-174.19 98.52-8.49 4.59-21.29-1.47-7.92-7.71C30.9 1156 57.59 1146 81.27 1130.2c52.3-32.33 96.44-83.26 107.15-145.28a279.71 279.71 0 00-5-114.12c-6.94-27.25-25.83-55.38-55.74-59.41a88.61 88.61 0 00-75.36 24.88c-5.1 5.16-15 19.46-13.38 35.86 11.57-9.08 10.78-8.07 20.26-12.3 21.84-9.74 50.81 4.11 56.25 28.15 5.81 22.1 1.32 50.22-20.49 62-22.77 12.38-56.37 7.25-69.08-17.12-21-37.55-9.47-88.89 24.54-114.94 34.64-28.75 85.19-29.87 126-15.12 42 15.61 67 59.1 71 102.17a223.22 223.22 0 011.63 27.11z" ]
                []

        ]


trebleKey : Html Msg
trebleKey =
    path [ d "M136.38 1108.82c-8.78 2.44-16.7 7.9-24 16.23s-10.94 17.8-10.94 27.86c0 6.32 2.15 13.5 6.33 21.11a37.77 37.77 0 0018.72 17c2.73.57 4 2 4 4 0 .71-1 1.43-3.46 2a59.82 59.82 0 01-45.2-57.3 76.68 76.68 0 0113.38-41.22q13-19.17 33.26-27.15l-9.93-51c-22.17 18.38-40.17 37.48-54.13 57.59q-21 29.94-21.74 65.06a85.5 85.5 0 006.48 30.44 82.46 82.46 0 0018.14 27c16.26 16.23 37.43 24.71 63.2 25.57a155.16 155.16 0 0028.21-4.74zm10.36-1.44l22.46 110.44c22.17-8.9 33.26-28.29 33.26-57.88a66.34 66.34 0 00-9.07-26.71 51.51 51.51 0 00-19.15-19 54.23 54.23 0 00-27.5-6.85zM117.23 958c4.75-2.87 10.22-7.9 16.13-14.93a176 176 0 0017.13-24.27 150.69 150.69 0 0013.39-28.44 81.84 81.84 0 004.89-26.86 47.55 47.55 0 00-1-10.34c-.57-5.17-2.16-9.19-4.89-11.92a14.73 14.73 0 00-10.51-4q-13 0-23.32 15.94a128.62 128.62 0 00-13 32.46 159.5 159.5 0 00-5.44 37.36c.72 14.2 3.02 25.83 6.62 35zm-9.07 8.33a297 297 0 01-10.8-71.09 207.64 207.64 0 014.76-43.51 129.47 129.47 0 0112.52-35.19c5.33-10 11.52-17.66 18.43-22.83 6.19-4.6 10.65-7 13.1-7a7.12 7.12 0 014.89 2 58.26 58.26 0 015.62 6.32q25.69 36.4 25.77 87.75a179.73 179.73 0 01-6.45 47.81 178.06 178.06 0 01-18.57 44.52 161.59 161.59 0 01-29.52 36.77l11.67 56.58c6.33-.72 10.65-1.29 13.1-1.29a64.62 64.62 0 0129.8 6.89 69.76 69.76 0 0123.18 18.67 86.18 86.18 0 0114.68 26.72 100 100 0 015.18 31.45 84.27 84.27 0 01-13.39 46.38c-8.92 13.94-22.31 24.13-40.31 30.74 1.16 7 3.17 17.23 6.19 30.3s5 23.7 6.48 31.45a122.7 122.7 0 012 22.55 55.62 55.62 0 01-30.81 51 65.94 65.94 0 01-30.95 7.33c-15.84 0-29.66-4.45-41.46-13.22s-18.14-20.82-18.72-36a51.26 51.26 0 014.9-19.1 38.15 38.15 0 0111.8-14.65 30.66 30.66 0 0117.56-6.32 30.72 30.72 0 0116 4.59 36 36 0 0112 12.64 36.44 36.44 0 014.47 17.52 29.66 29.66 0 01-8.64 21.55c-5.76 5.88-13.1 8.9-21.88 8.9h-3.4c5.62 8.62 14.83 13.07 27.65 13.07a54.48 54.48 0 0019.72-4 52.23 52.23 0 0017.13-10.92c4.75-4.59 7.92-9.48 9.21-14.65 2.45-5.88 3.6-14.07 3.6-24.27a112.4 112.4 0 00-2-20.68c-1.3-6.75-3.31-15.79-6-27-2.73-11-4.75-19.67-5.9-25.56a110.83 110.83 0 01-26.92 3.3 104.68 104.68 0 01-44.49-9.62 116.49 116.49 0 01-36.85-26.85 128.33 128.33 0 01-24.62-39.07 125.75 125.75 0 01-8.93-45.52 128.21 128.21 0 018.5-41.94 178.86 178.86 0 0120-37.77 312.76 312.76 0 0125.48-32.17c8.88-9.56 20.54-21.77 35.22-36.56z", attribute "data-name" "path9", fill "#131516", attribute "fill-rule" "evenodd", attribute "stroke" "#131516", attribute "stroke-width" "3" ]
            []


drawnNote : Int -> Html Msg
drawnNote yCord =
    path [ transform ("translate(0 " ++ String.fromInt yCord ++ ")"), d "M732.22,1141.9c-31.52-19.32-48.18-41.24-48.18-63.39H648v138.91a92.58,92.58,0,0,0-24.36-3.13c-20.95,0-42.32,6.23-58.63,17.11-30.41,20.27-34.22,50.72-8.49,67.88,11.08,7.38,26.42,11.45,43.2,11.45,21,0,42.31-6.23,58.62-17.11,14.22-9.47,23.17-21.47,25.23-33.79a32,32,0,0,0,.42-5.23h0v-112a197.61,197.61,0,0,0,23.82,17c38.13,23.36,30.08,53.23,11.61,71.71l29.95,13.31c28.44-28.44,34.15-71.22-17.2-102.69Z" ] []

placeNote : Note -> Html Msg
placeNote note =
    drawnNote (-note.positionFromTheFirstLine * 60)

getClefSign : Clef -> Html Msg
getClefSign clef =
    case clef of
        Treble ->
            trebleKey

        Bass ->
            bassKey


drawStaff : Note -> Clef -> Html Msg
drawStaff note clef =
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
        , getClefSign clef
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

possibleBassNotes : List Note
possibleBassNotes =
    [ { name = "G", positionFromTheFirstLine = 14 }
    , { name = "F", positionFromTheFirstLine = 13 }
    , { name = "E", positionFromTheFirstLine = 12 }
    , { name = "D", positionFromTheFirstLine = 11 }
    , { name = "C", positionFromTheFirstLine = 10 }
    , { name = "B", positionFromTheFirstLine = 9 }
    , { name = "A", positionFromTheFirstLine = 8 }
    , { name = "G", positionFromTheFirstLine = 7 }
    , { name = "F", positionFromTheFirstLine = 6 }
    , { name = "E", positionFromTheFirstLine = 5 }
    , { name = "D", positionFromTheFirstLine = 4 }
    , { name = "C", positionFromTheFirstLine = 3 }
    , { name = "B", positionFromTheFirstLine = 2 }
    , { name = "A", positionFromTheFirstLine = 1 }
    , { name = "G", positionFromTheFirstLine = 0 }
    , { name = "F", positionFromTheFirstLine = -1 }
    , { name = "E", positionFromTheFirstLine = -2 }
    , { name = "D", positionFromTheFirstLine = -3 }
    , { name = "C", positionFromTheFirstLine = -4 }
    , { name = "B", positionFromTheFirstLine = -5 }
    , { name = "A", positionFromTheFirstLine = -6 }
    ]

getCurrentNoteList : Clef -> List Note
getCurrentNoteList clef =
    case clef of
        Treble ->
            possibleTrebleNotes

        Bass ->
            possibleBassNotes


notesArray : Clef -> Array Note
notesArray clef =
    Array.fromList (getCurrentNoteList clef)


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
                upperedNote = String.toUpper usersAnswer
                info =
                    if note == upperedNote then
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
        , label [] [text "Treble", input [onClick (SetClef Treble),type_ "radio", HTMLAttr.name "clef", HTMLAttr.value "Treble", checked (model.clef == Treble)] []]
        , label [] [text "Bass", input [onClick (SetClef Bass), type_ "radio", HTMLAttr.name "clef", HTMLAttr.value "Bass", checked (model.clef == Bass)] []]
        ]

showGamePage : Note -> Clef -> Html Msg
showGamePage note clef =
    div []
        [ text "What is this note?"
        , div []
            [ input [ HTMLAttr.autofocus True, type_ "text", onInput SetAnswer, onKeyUp (OnKeyUp note.name) ] []
            , button [ onClick (SubmitAnswer note.name) ] [ text "Submit Answer" ]
            ]
        , drawStaff note clef
        ]

type alias NoteAndKey =
    { keyCode : Int
    , value : String
    }

keyupDecoder : (NoteAndKey -> Msg) -> Decoder Msg
keyupDecoder msg =
    Decode.map2 NoteAndKey
        (field "keyCode" int)
        (field "currentTarget" (field "value" string))
            |> Decode.map msg


onKeyUp : (NoteAndKey -> Msg) -> Attribute Msg
onKeyUp msg =
    on "keyup" (keyupDecoder msg)

view : Model -> Html Msg
view model =
    case model.status of
        StartAndShowPreviousAnswer _ ->
            showStartPage model

        NoteIsShown note ->
            showGamePage note model.clef


initialModel : Model
initialModel =
    { status = StartAndShowPreviousAnswer ""
    , clef = Treble
    , usersAnswer = ""
    }


type Msg
    = SetNote Int
    | StartGame
    | SubmitAnswer String
    | SetAnswer String
    | OnKeyUp String NoteAndKey
    | SetClef Clef


noteGenerator : Clef -> Generator Int
noteGenerator clef =
    Random.int 0 (Array.length (notesArray clef))


getNote : Clef -> Int -> Note
getNote clef position =
    let
        maybeNote =
            Array.get position (notesArray clef)
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
            ( model, Random.generate SetNote (noteGenerator model.clef) )

        SetNote randomNumber ->

            ( { model | status = NoteIsShown (getNote model.clef randomNumber) }, Cmd.none )

        SubmitAnswer note ->
            ( { model | status = StartAndShowPreviousAnswer note }, Cmd.none )

        SetAnswer answer ->
            ( { model | usersAnswer = answer }, Cmd.none )

        OnKeyUp rightAnswer {keyCode, value} ->
            let
                isEnter = keyCode == 13
            in
            if isEnter && value /= "" then ( { model | usersAnswer = value, status = StartAndShowPreviousAnswer rightAnswer }, Cmd.none ) else (model, Cmd.none)

        SetClef clef ->
            ({model | clef = clef}, Cmd.none)

main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
