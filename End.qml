import QtQuick 2.5

Item {

    property color mainColor: "#FF0"
    property color backgroundColor: "#050505"

    property color buttonColor: "#151500"
    property color buttonBorderColor: "#555500"
    property color buttonHoverColor: "#353500"
    property color buttonClickColor: "#252500"

    // "Again" cell clicked
    signal clicked

    // "Noughts WIN" result page
    function noughtWin() {

        mainText.text = qsTr("Noughts<br>WINS")

        mainColor = "#0F0"
        buttonColor = "#001500"
        buttonBorderColor = "#00FF00"
        buttonHoverColor = "#003500"
        buttonClickColor = "#002500"

    }

    // "Crosses WIN" result page
    function crossWin() {

        mainText.text = qsTr("Crosses<br>WINS")

        mainColor = "#F00"
        buttonColor = "#150000"
        buttonBorderColor = "#FF0000"
        buttonHoverColor = "#350000"
        buttonClickColor = "#250000"

    }

    // "DRAW" result page
    function draw() {

        mainText.text = qsTr("Try again!<br>DRAW")

        mainColor = "#FF0"
        buttonColor = "#151500"
        buttonBorderColor = "#FF0"
        buttonHoverColor = "#353500"
        buttonClickColor = "#252500"

    }

    id: end

    x: 0
    y: 0

    width: 400
    height: 400

    Rectangle {

        id: background

        anchors.fill: parent

        color: backgroundColor

        smooth: true

    }

    Text {

        id: mainText

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20

        horizontalAlignment: Text.AlignHCenter

        textFormat: Text.RichText
        text: qsTr("Try again!<br>DRAW")

        color: mainColor

        style: Text.Raised
        styleColor: "#FFF"

        font {

            family: "Arial"
            bold: true
            pixelSize: 74

        }

        antialiasing: true
        smooth: true

    }

    Cell {

        id: againCell

        anchors.top: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20

        cellSymbol: qsTr("↺")

        textColor: mainColor
        borderColor: buttonBorderColor
        backgroundColor: buttonColor
        hoverColor: buttonHoverColor
        clickedColor: buttonClickColor

        onClicked: {

            // "Again" cell clicked
            end.clicked()

        }

    }

}
