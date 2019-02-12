#ifndef NACENGINE_H
#define NACENGINE_H

#include <QObject>

// Game engine
class NACEngine : public QObject {

		Q_OBJECT

	private:

		// Game field data
		unsigned char*		data;
		// Winning line data
		unsigned int*		winData;
		// Game step count
		unsigned int		step;
		// User determinant
		// If true Player 1 is Nought and
		// Player 2 - Cross. Else backward
		bool				determinant;


	public:

		// Default c-tor
		NACEngine();


		// Refresh game field
		Q_INVOKABLE void refreshField();

		// Cell[x, y] on game field was clicked
		Q_INVOKABLE bool cellClicked(unsigned int, unsigned int);

		// Get player id whose move now
		Q_INVOKABLE int getPlayer() const;

		// Set players determinant
		Q_INVOKABLE void setDeterminant(bool det);
		// Get players determinant
		Q_INVOKABLE bool getDeterminant() const;

		// Check result
		Q_INVOKABLE bool checkResult();

		// Get step counter
		Q_INVOKABLE unsigned int getStep() const;

		// Get win data
		Q_INVOKABLE unsigned int getWinData(unsigned int) const;

		// Get game data
		Q_INVOKABLE unsigned int getData(unsigned int) const;

		// D-tor
		~NACEngine();

};

#endif // NACENGINE_H
