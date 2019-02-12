import QtQuick 2.5

Item {

    property color backgroundColor: "#050505"

    // Player 1 Noughts
    signal noughtClicked
    // Player 1 Crosses
    signal crossClicked

    id: start

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

        y: 50

        anchors.horizontalCenter: parent.horizontalCenter

        horizontalAlignment: Text.AlignHCenter

        textFormat: Text.RichText
        text: qsTr("Player #1<br>Choose your side:")

        color: "#FF0"

        style: Text.Raised
        styleColor: "#FFF"

        font {

            family: "Arial"
            bold: true
            pixelSize: 42

        }

        antialiasing: true
        smooth: true

    }

    Grid {

        id: sideGrid

        anchors.top: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20

        columns: 2
        spacing: 70

        Cell {

            id: noughtCell

            cellSymbol: qsTr("O")

            textColor: "#00FF00"
            borderColor: "#00FF00"
            backgroundColor: "#001500"
            hoverColor: "#003500"
            clickedColor: "#002500"

            onClicked: {

                noughtClicked()

            }

        }

        Cell {

            id: crossCell

            cellSymbol: qsTr("✘")

            textColor: "#FF0000"
            borderColor: "#FF0000"
            backgroundColor: "#150000"
            hoverColor: "#350000"
            clickedColor: "#250000"

            onClicked: {

                crossClicked()

            }

        }

    }

}
