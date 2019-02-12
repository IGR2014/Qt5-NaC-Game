import QtQuick 2.5

Item {

    property string cellSymbol: qsTr(" ")

    property color textColor: "#FFF"
    property color borderColor: "#353535"
    property color backgroundColor: "#050505"
    property color hoverColor: "#404040"
    property color clickedColor: "#252525"

    property int hoverAnimationDuration: 150
    property int clickAnimationDuration: 250

    // Cell clicked
    signal clicked

    // Clear cell color and mark
    function setClear() {

        cell.cellSymbol = qsTr(" ")

        cell.backgroundColor = "#050505"
        cell.textColor = "#FFF"
        cell.borderColor = "#353535"
        cell.hoverColor = "#404040"
        cell.clickedColor = "#252525"

    }

    // Set cell color to green and mark to Nought
    function setNought() {

        cell.cellSymbol = qsTr("O")

        cell.backgroundColor = "#001500"
        cell.textColor = "#00FF00"
        cell.borderColor = "#005500"
        cell.hoverColor = "#003500"
        cell.clickedColor = "#002500"

    }

    // Set cell color to red and mark to Cross
    function setCross() {

        cell.cellSymbol = qsTr("✘")

        cell.backgroundColor = "#150000"
        cell.textColor = "#FF0000"
        cell.borderColor = "#550000"
        cell.hoverColor = "#350000"
        cell.clickedColor = "#250000"

    }

    // Highlight cell
    function highlight() {

        cell.borderColor = cell.textColor

    }

    // Disable cell
    function disable() {

        cell.textColor = "#353535"
        cell.borderColor = "#353535"
        cell.hoverColor = "#404040"
        cell.clickedColor = "#252525"
        cell.backgroundColor = "#050505"

    }

    id: cell

    x: 0
    y: 0

    height: 120
    width: 120

    smooth: true

    Rectangle {

        id: cellBackground

        anchors.fill: cell

        height: cell.height
        width: cell.width

        color: backgroundColor

        radius: 10

        border {

            width: 5
            color: borderColor

        }

        smooth: true

    }

    Text {

        id: cellText

        anchors.centerIn: cell

        text: cellSymbol

        color: textColor

        style: Text.Raised
        styleColor: "#FFF"

        font {

            family: "Arial"
            pixelSize: 100
            bold: true

        }

        antialiasing: true
        smooth: true

    }

    PropertyAnimation {

        id: hoverAnimation

        target: cellBackground

        properties: "color"
        to: hoverColor

        duration: hoverAnimationDuration

    }

    PropertyAnimation {

        id: leaveAnimation

        target: cellBackground

        properties: "color"
        to: backgroundColor

        duration: hoverAnimationDuration

    }

    PropertyAnimation {

        id: clickAnimation

        target: cellBackground

        properties: "color"
        to: clickedColor

        duration: clickAnimationDuration

    }

    PropertyAnimation {

        id: releaseAnimation

        target: cellBackground

        properties: "color"
        to: hoverColor

        duration: clickAnimationDuration

    }

    MouseArea {

        id: cellArea

        anchors.fill: cell

        hoverEnabled: true

        // Visual effects (animation on hover)
        onEntered: {

            hoverAnimation.start()

        }

        // Visual effects (animation on hover out)
        onExited: {

            leaveAnimation.start()

        }

        // Visual effects (animation on cell released)
        onReleased: {

            releaseAnimation.start()

        }

        // Visual effects (animation on cell clicked)
        onClicked: {

            clickAnimation.start()
            cell.clicked()

        }

    }

}
