# Campus Cats Adventure

April 28, 2021.

Campus Cats Adventure is an arcade game that is based on NYU Abu Dhabi campus environment.
A number of cats are wondering around the virtual "campus", and the player's task is to collect as many student ID's as possible.
The game gets more difficult with an increasing score.
If the player's health gets below zero, the game is over.

Author: Amina Kobenova.
Class Credits: Robota Psyche, 2021.

<img src="https://github.com/ak7588/robota_psyche/blob/main/finalProject/startScreen.png" width="400" height="400">

## Game Premise

Create an environment with campus cats and a player (student). Some of the cats will be orange and aggressive, so the player has to avoid them. The player is the center of the flow field, so aggressive cats are naturally attracted to the player. The player has health points and if all of them are gone, the game is over.

<img src="https://github.com/ak7588/robota_psyche/blob/main/finalProject/playScreen.png" width="400" height="400">


## Game Logic

The core of the game is implemented with the inspiration from the Evolution and Association projects we covered in class. There are four classes in the program, so let's briefly discuss the functionality of each class:

- **Cat** class creates cat objects that have their unique characteristics such as color (image)
, behavior (aggressive or not) and motion throughout the canvas (attached to the flow field or not). The class is used in the main program inside of the ArrayList of Cat object that interact with each other and the player throughout the game.

- **FlowField** class is holds multiple flow field to be used in the game: a mouse-generated flow field and a random flow field. Non-aggressive cats follow the mouse-generated flow field to attack the player while aggressive cats follow the random flow field to make the game harder.

- **Player** class holds the player object that updates and displays the game score on the canvas.

- **ID** class is responsible for ID object manipulation throughout the game. It replaces the ID whenever it gets collected by the player.

## Graphical User Interface

A crucial element in the game is the experience design and the graphical user interface, all of which have been implemented using buttons for user-interface and scene manipulation to navigate through different parts of the game.

## Future Improvements

For next improvements of this game, it would be interesting to think about how the association could be used in the opposite way; that is -- not to harm the player by deducting the health points but to give the player more points if they "interact" with a specific type of cat.

Another potential imporvement is the collision detection process; if I had to describe this as a programmer, I would say that the program works fine in amortized time. However, if a specific number of cats are in the ArrayList, it becomes difficult to trace if the collision detection works _all_ the time.

And lastly, it would be interesting to observe how the user-experience of the game could be improved. Because the game was not user-tested in-person (COVID-19 regulations), it was difficult to adequately assess if the user-flow of the game is optimal.

## Thank You

Thanks for reading this document and there is a more thorough discussion of the program development in the [journal](https://github.com/ak7588/robota_psyche/blob/main/finalProject/journal.md).
