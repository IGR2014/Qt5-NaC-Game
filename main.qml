import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {

    visible: true

    title: qsTr("Noughts and Crosses (2 players mode)")

    width: 400
    height: 400

    minimumWidth: width
    minimumHeight: height

    maximumWidth: minimumWidth
    maximumHeight: minimumHeight

    StackView {

        id: stack

        anchors.fill: parent

        initialItem: startPage

        End {

            id: endPage

            onClicked: {

                // Go back to start page
                stack.pop()
                stack.pop()

            }

        }

        Field {

            id: gameField

            onClicked: {

                // Game is not ended
                if (gameField.done === false) {

                    // Free cell clicked
                    if (gameEngine.cellClicked(x, y)) {

                        // Player 1 is Noughts?
                        if (gameEngine.getDeterminant()) {

                            // Clicked by Player 1 - insert cross
                            // Clicked by Player 2 - insert nought
                            (gameEngine.getPlayer() === 1) ? gameField.getCell(x, y).setCross() :
                                                             gameField.getCell(x, y).setNought()

                        } else {

                            // Clicked by Player 1 - insert nought
                            // Clicked by Player 2 - insert cross
                            (gameEngine.getPlayer() === 1) ? gameField.getCell(x, y).setNought() :
                                                             gameField.getCell(x, y).setCross()

                        }

                        // Step count now > 4?
                        // (if so - there might be winner)
                        if (gameEngine.getStep() > 4) {

                            // If there is winning line
                            if (gameEngine.checkResult()) {

                                // Check whose line is this and
                                // change Result page color and text
                                // If Player 1
                                if (gameEngine.getPlayer() === 1) {

                                    // Does he Noughts or Crosses?
                                    gameEngine.getDeterminant() ? endPage.crossWin() :
                                                                  endPage.noughtWin()

                                // Else Player 2
                                } else {

                                    // Same but Player 2
                                    gameEngine.getDeterminant() ? endPage.noughtWin() :
                                                                  endPage.crossWin()

                                }

                                // Visual effects
                                for (var i = 0; i < 9; ++i) {

                                    // Highlight winning line cells
                                    if (gameEngine.getWinData(0) === i ||
                                        gameEngine.getWinData(1) === i ||
                                        gameEngine.getWinData(2) === i) {

                                        gameField.highlightCell(i)


                                    // And disable other
                                    } else {

                                        gameField.disableCell(i)

                                    }

                                }

                                // Game ended
                                gameField.done = true;

                            } else {

                                // If all cells are marked
                                // and we still have no winner
                                if (gameEngine.getStep() === 9) {

                                    // Disable them all
                                    for (var k = 0; k < 9; ++k) {

                                        gameField.disableCell(k)

                                    }

                                    // Show result page with "DRAW" message
                                    endPage.draw()
                                    // Game ended
                                    gameField.done = true;

                                }

                            }

                        }

                    // If already marked cell was clicked
                    } else {

                        // Player 1 Noughts or Crosses?
                        if (gameEngine.getDeterminant()) {

                            // If Nought in cell - green color
                            (gameEngine.getData(x + y * 3) === 1) ? gameField.hintColor = "#0F0" :
                                                                    gameField.hintColor = "#F00"

                        } else {

                            // Else red color
                            (gameEngine.getData(x + y * 3) === 1) ? gameField.hintColor = "#F00" :
                                                                    gameField.hintColor = "#0F0"

                        }

                        // If clicked cell is already players cell
                        if (gameEngine.getData(x + y * 3) === gameEngine.getPlayer()) {

                            gameField.hintText = "This cell is<br>ALREADY<br>your!"

                        // If enemies cell
                        } else {

                            gameField.hintText = "This cell is<br>NOT<br>your!"

                        }

                        // Show hint
                        gameField.hintVisibility = true

                    }

                } else {

                    // Clear game data
                    gameField.done = false

                    // Clear field
                    gameEngine.refreshField()
                    // Clear marks
                    gameField.clear()
                    // Show reusl page
                    stack.push(endPage)

                }

            }

            // Hint clicked
            onHintClicked: {

                // Dismiss hint
                gameField.hintVisibility = false

            }

        }

        Start {

            id: startPage

            // Clicked Noughts cell
            onNoughtClicked: {

                // Player 1 is now Noughts
                // Player 2 - Crosses
                gameEngine.setDeterminant(true);
                // Show game field
                stack.push(gameField)

            }

            // Clicked cross cell
            onCrossClicked: {

                // Player 1 is now Crosses
                // Player 2 - Noughts
                gameEngine.setDeterminant(false);
                // Show game field
                stack.push(gameField)

            }

        }

    }

}
