module LearnSheetMusic exposing (..)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes exposing (type_)
import Html.Events exposing (onInput, onClick)
import Random exposing (Generator)


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
                info = if note == usersAnswer then "Hooray!" else ("You lose, the note was " ++ note)
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



--on : String -> Json.Decoder msg -> Attribute msg


type alias SubmitEvent =
    { target : String
    }



showGamePage : Note -> Html Msg
showGamePage note =
    div []
        [ text ("What is this note? " ++ String.fromInt note.positionFromTheFirstLine)
        , div [ ]
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
