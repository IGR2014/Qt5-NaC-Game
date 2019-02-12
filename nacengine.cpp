#include <QMessageBox>

#include "nacengine.h"

// Default c-tor
NACEngine::NACEngine() : QObject(),
						 data(new unsigned char[9]()),
						 winData(new unsigned int[3]()),
						 step(0),
						 determinant(true) {}

// Refresh game field
void NACEngine::refreshField() {

	// Delete old game field data
	if (data) {

		delete [] data;

	}
	// Delete old win data
	if (winData) {

		delete [] winData;

	}
	// Realloc new game field data and win data
	data = new unsigned char[9]();
	winData = new unsigned int[3]();

	// Zero steps counter
	step = 0;

}

// Cell[x, y] on game field was clicked
bool NACEngine::cellClicked(unsigned int x, unsigned int y) {

	// Check if values are in range
	if (x < 3 && y < 3) {

		// Pointer to current cell data
		unsigned char &cellData = data[x + y * 3];

		// Check if cell is free
		if (cellData == 0x00) {

			// Insert player specific id in the cell
			// (just 1 for Player 1 or 2 for Player 2)
			// Main idea is that players set marks
			// after each other. So every Odd click
			// is Player 1 mark. And every Even click
			// is Player 2 mark
			cellData = getPlayer();

			// Incremet step counter
			step++;

			// Click successfull
			return true;

		// Cell is already marked
		} /*else {

			if (cellData == getPlayer()) {

				QMessageBox mb;
				mb.setText("Already your!");
				mb.exec();

			} else {

				QMessageBox mb;
				mb.setText("Not your!");
				mb.exec();

			}

		}*/

	}

	// Click unsuccessfull
	return false;

}

// Get player id whose move now
int NACEngine::getPlayer() const {

	// If step counter is Odd - Player 1
	// else (Even) - Player 2
	return (step & 1) ? 0x02 : 0x01;

}

// Set players determinant
void NACEngine::setDeterminant(bool det) {

	determinant = det;

}

// Get players determinant
bool NACEngine::getDeterminant() const {

	return determinant;

}

// Check result
bool NACEngine::checkResult() {

		// Diagonals check
		if (data[0] != 0x00 &&
			data[0] == data[4] &&
			data[0] == data[8]) {

			// Set win data with win line element numbers
			winData[0] = 0;
			winData[1] = 4;
			winData[2] = 8;
			// We have winner
			return true;

		}
		if (data[2] != 0x00 &&
			data[2] == data[4] &&
			data[2] == data[6]) {

			// Set win data with win line element numbers
			winData[0] = 2;
			winData[1] = 4;
			winData[2] = 6;
			// We have winner
			return true;

		}

	// 3 Columns and 3 Rows check
	for (unsigned int i = 0; i < 3; i++) {

		// First row element number
		unsigned int row = i * 3;

		// Columns
		if (data[i] != 0x00 &&
			data[i] == data[i + 3] &&
			data[i] == data[i + 6]) {

			// Set win data with win line element numbers
			winData[0] = i;
			winData[1] = i + 3;
			winData[2] = i + 6;
			// We have winner
			return true;

		}

		// Rows
		if (data[row] != 0x00 &&
			data[row] == data[row + 1] &&
			data[row] == data[row + 2]) {

			// Set win data with win line element numbers
			winData[0] = row;
			winData[1] = row + 1;
			winData[2] = row + 2;
			// We have winner
			return true;

		}

	}

	// No checks success
	return false;

}

// Get step counter
unsigned int NACEngine::getStep() const {

	return step;

}

// Get win data
unsigned int NACEngine::getWinData(unsigned int i) const {

	// If in range - return data
	if (i < 3) {

		return winData[i];

	}
	// Else return unused simbol
	return 9;

}

// Get game data
unsigned int NACEngine::getData(unsigned int i) const {

	// If in range - return data
	if (i < 9) {

		return data[i];

	}
	// Else return unused simbol
	return 0xFF;

}

// D-tor
NACEngine::~NACEngine() {

	// Delete game field data
	if (data) {

		delete [] data;
		data = nullptr;

	}
	// Delete win data
	if (winData) {

		delete [] winData;
		winData = nullptr;

	}
	// Zero steps counter
	step = 0;

}
