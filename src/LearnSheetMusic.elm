module LearnSheetMusic exposing (..)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (type_)
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
    svg []
        [ path [ transform ("scale(0.8) translate(400 " ++ String.fromInt yCord ++ ")"), d "M209.329 79.238C183.062 55.09 169.178 27.69 169.178 0h-30v173.645c-6.239-2.564-13.111-3.921-20.305-3.921-17.458 0-35.266 7.796-48.857 21.388-25.344 25.343-28.516 63.407-7.072 84.853 9.232 9.232 22.016 14.316 35.995 14.316 17.458 0 35.266-7.796 48.857-21.388 11.843-11.843 19.308-26.842 21.018-42.234.244-2.198.354-4.379.354-6.537h.01V80.106c5.808 7.304 12.425 14.394 19.848 21.218 31.772 29.21 25.067 66.542 9.671 89.637l24.962 16.641c23.698-35.548 28.458-89.026-14.33-128.364z" ] []
        ]


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
    let
        offset = note.positionFromTheFirstLine * 75
        _ = Debug.log "offset" offset
    in
    drawnNote (550 - offset)

generateAdditionalLines : Note -> List (Html Msg)
generateAdditionalLines note =
    let
        margin =
            getMargin note.positionFromTheFirstLine
        _ = Debug.log "margin" margin
    in
    case margin of
        Zero ->
            [text ""]

        Positive amount ->
            initialize amount getPositiveLines

        Negative amount ->
            initialize amount getNegativeLines


drawStaff : Note -> Html Msg
drawStaff note =
    svg [ viewBox "0 0 1200 1200" ]
        [ g [ transform "matrix(1.5 0 0 1 0 200)" ] (List.append
            [ path [ stroke "#131516", strokeWidth "6.885", d "M4.216 395.784h791.568M4.216 635.784h791.568M4.216 515.784h791.568M4.216 275.784h791.568M4.216 155.784h791.568" ] []
            , path [ stroke "#000", strokeWidth "6.532", d "M751.579 154.322v482.924" ] []
            , rect [ width "41.053", height "488", x "1156.839", y "351.784", transform "matrix(.66667 0 0 1 0 -200)" ] []
            , placeNote note
            ] (generateAdditionalLines note))
        , path [ fill "#131516", stroke "#131516", strokeWidth ".602", d "M201.68 653.122c-12.467 2.557-24.02 9.398-35.048 20.294-11.042 11.097-16.952 23.754-17.918 37.758-.608 8.802 1.71 19.011 6.794 30.015 5.07 11.204 13.355 19.614 24.44 25.404 3.755 1.063 5.422 3.188 5.229 5.989-.07 1-1.542 1.903-5.006 2.468-17.931-5.86-32.295-16.7-42.918-32.106-10.61-15.606-15.466-32.824-14.542-52.056 2.024-20.563 9.565-39.339 22.611-56.126 13.26-16.974 29.57-28.511 48.931-34.612l-8.936-71.971c-32.649 23.475-59.55 48.351-80.935 75.015-21.37 26.464-33.48 55.98-36.532 88.531-.607 14.631 1.42 29.042 6.097 43.032 4.663 14.19 12.23 27.175 22.672 39.352 21.1 24.169 49.764 38.005 85.576 41.682 12.288.044 25.474-1.257 39.76-3.89L201.68 653.123zm14.576-1.004l20.669 155.993c31.737-10.272 49.042-36.213 51.885-77.422-.852-13.928-4.007-26.607-10.066-38.08-5.845-11.66-14.06-21.07-24.849-28.246-10.788-7.176-23.2-11.249-37.639-12.245zm-26.753-210.883c6.893-3.544 14.996-10.02 23.895-19.255 8.884-9.035 17.692-19.884 26.195-32.16 8.718-12.464 15.846-25.238 21.383-38.323 5.523-12.885 8.598-25.335 9.399-36.938.345-5 .289-10.03-.41-14.5-.305-7.257-2.125-13.01-5.672-17.074-3.562-3.864-8.237-6.196-14.253-6.611-12.032-.83-23.37 5.824-34.018 19.963-8.303 12.291-15.568 27.066-21.167 43.965-5.813 17.086-9.607 34.11-11.209 51.486-.364 19.873 1.727 36.298 5.857 49.447zm-13.434 10.731a414.791 414.791 0 01-8.208-100.06c1.691-21.59 5.291-41.643 10.8-60.157 5.308-18.527 12.241-34.33 20.828-47.807 8.386-13.49 17.74-23.498 27.862-30.036 9.065-5.806 15.516-8.778 18.925-8.543 2.607.18 4.744 1.332 6.625 3.271 1.88 1.939 4.28 5.12 7.213 9.342 21.53 35.454 30.747 77.093 27.462 124.704-1.56 22.605-6.086 44.402-13.62 65.992-7.32 21.403-17.379 41.613-30.148 60.229-12.983 18.802-27.793 34.865-44.642 48.375l10.804 79.938c8.893-.391 14.964-.776 18.373-.541 15.24 1.051 28.656 5.193 40.847 12.466 12.192 7.273 22.427 16.622 30.491 28.233 8.078 11.412 14.04 24.285 17.887 38.62 3.646 14.321 5.245 29.105 4.196 44.308-1.628 23.605-9.335 44.781-23.107 63.327-13.772 18.547-33.401 31.463-59.103 38.936.928 9.913 2.756 24.31 5.71 42.804 2.742 18.681 4.742 33.492 6.002 44.433 1.26 10.94 1.344 21.398.64 31.6-1.09 15.804-5.867 29.544-14.342 41.421-8.677 11.863-19.767 20.746-33.471 26.634-13.504 5.902-28.177 8.307-43.818 7.227-22.059-1.522-40.882-9.051-56.483-22.389-15.588-13.537-23.266-30.75-22.605-52.01 1.25-9.36 4.064-18.01 8.654-26.135s10.474-14.553 17.851-19.27c7.191-4.93 15.606-7.164 25.072-7.114 7.821.54 15.089 3.252 21.818 7.938 6.514 4.871 11.729 11.06 15.429 18.752 3.5 7.678 5.14 16.032 4.532 24.834-.814 11.803-5.515 21.528-14.102 29.177-8.587 7.648-19.104 11.143-31.336 10.3l-4.612-.319c6.992 12.542 19.398 19.63 37.245 20.86 9.024.623 18.387-.74 27.86-3.705 9.687-3.15 17.853-7.612 24.912-13.557 7.059-5.945 11.94-12.442 14.242-19.519 3.975-7.966 6.366-19.258 7.346-33.461.662-9.602.322-19.274-.82-29-1.156-9.527-3.094-22.324-5.828-38.19-2.747-15.666-4.726-27.863-5.764-36.175a154.383 154.383 0 01-37.817 2.013c-21.858-1.508-42.209-7.334-61.04-17.678-18.83-10.344-35.02-23.923-48.754-40.95-13.535-17.014-23.723-35.807-30.536-56.779-6.628-20.758-9.376-42.253-8.058-64.272 2.21-20.349 7.373-39.69 15.862-57.596 8.503-18.106 18.942-35.074 31.504-50.689 12.562-15.615 25.428-29.802 38.586-42.36a2649.933 2649.933 0 0152.636-47.422z" ] []
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
        , drawStaff note
        , div []
            [ input [ type_ "text", onInput SetAnswer ] []
            , button [ onClick (SubmitAnswer note.name) ] [ text "Submit Answer" ]
            ]
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
