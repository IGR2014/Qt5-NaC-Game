import QtQuick 2.5

Item {

    id: field

    x: 0
    y: 0

    width: 400
    height: 400

    property bool done: false

    property bool hintVisibility: false

    property string noughtSign: qsTr("◯")
    property string crossSign: qsTr("✘")

    property string hintText: qsTr("CLICK<br>ME!")

    property color backgroundColor: "#050505"

    property color noughtColor: "#00FF00"
    property color noughtHoverColor: "#002500"
    property color crossColor: "#FF0000"
    property color crossHoverColor: "#250000"

    property color hintColor: "#FF0"

    // Cell(x, y) clicked
    signal clicked(int x, int y)

    // Hint clicked
    signal hintClicked

    // Get cell(x, y)
    function getCell(x, y) {

        switch(x + y * 3) {

            case 0:
                return cell00
            case 1:
                return cell10
            case 2:
                return cell20
            case 3:
                return cell01
            case 4:
                return cell11
            case 5:
                return cell21
            case 6:
                return cell02
            case 7:
                return cell12
            case 8:
                return cell22
            default:
                return undefined

        }

    }

    // Clear cells
    function clear() {

        cell00.setClear()
        cell10.setClear()
        cell20.setClear()
        cell01.setClear()
        cell11.setClear()
        cell21.setClear()
        cell02.setClear()
        cell12.setClear()
        cell22.setClear()

    }

    // Highlight cell(i) where i = x + y * 3
    function highlightCell(i) {

        field.getCell(i % 3, Math.floor(i / 3)).highlight()

    }

    // Disable cell(i) where i = x + y * 3
    function disableCell(i) {

        field.getCell(i % 3, Math.floor(i / 3)).disable()

    }

    Rectangle {

        id: background

        anchors.fill: parent

        color: backgroundColor

        smooth: true

    }

    Grid {

        id: grid

        anchors.centerIn: parent

        columns: 3
        spacing: 10

        Cell {

            id: cell00

            onClicked: {

                hintAnimation.start()
                field.clicked(0, 0)

            }

        }

        Cell {

            id: cell10

            onClicked: {

                hintAnimation.start()
                field.clicked(1, 0)

            }

        }

        Cell {

            id: cell20

            onClicked: {

                hintAnimation.start()
                field.clicked(2, 0)

            }

        }

        Cell {

            id: cell01

            onClicked: {

                hintAnimation.start()
                field.clicked(0, 1)

            }

        }

        Cell {

            id: cell11

            onClicked: {

                hintAnimation.start()
                field.clicked(1, 1)

            }

        }

        Cell {

            id: cell21

            onClicked: {

                hintAnimation.start()
                field.clicked(2, 1)

            }

        }

        Cell {

            id: cell02

            onClicked: {

                hintAnimation.start()
                field.clicked(0, 2)

            }

        }

        Cell {

            id: cell12

            onClicked: {

                hintAnimation.start()
                field.clicked(1, 2)

            }

        }

        Cell {

            id: cell22

            onClicked: {

                hintAnimation.start()
                field.clicked(2, 2)

            }

        }

    }

    PropertyAnimation {

        id: hintAnimation

        target: hint

        properties: "opacity"
        from: 1.0
        to: 0.75

        duration: 1000

    }

    Rectangle {

        id: hint

        visible: hintVisibility

        anchors.centerIn: parent

        width: parent.width
        height: parent.height

        color: background.color

        Rectangle {

            id: hintBorder

            anchors.centerIn: parent

            width: parent.width - 80
            height: parent.height - 200

            color: background.color

            opacity: 1.0

            radius: 10

            border {

                width: 10
                color: hintColor

            }
        }

        Text {

            id: hintTextData

            anchors.centerIn: parent

            horizontalAlignment: Text.AlignHCenter

            color: hintColor

            style: Text.Raised
            styleColor: "#FFF"

            textFormat: Text.RichText
            text: hintText

            font {

                family: "Arial"
                bold: true
                pixelSize: 36

            }

            antialiasing: true
            smooth: true

        }

        MouseArea {

            id: hintArea

            anchors.fill: hint

            hoverEnabled: true

            onClicked: {

                field.hintClicked()

            }

        }

    }

}
