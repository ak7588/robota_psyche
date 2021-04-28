# Final Project Journal

## April 17:

- Downloaded and cropped cat images to embed into the program.
- Downloaded the aggressive meow sound to play whenever the aggressive cat is met.
- Started the code: implemented the GUI and the Cat, FlowField, and PLayer Classes.

Next steps:
- Improve the Player class to add some interaction functionality.
- Add some new features to the Cat class to follow the Player flowfield.

## April 19:
- Fixed bugs in the detect collision function (problem was in the booleans detecting prevState)
- Added two functions to the Player class to detect collision and update player's health accordingly.

## April 21:
- Implemented the followMouse() flow field method in the FlowField class and added followFlowField() method to the Cat class.
- Added the separate() method to the Cat class so that they don't stack upon each other.
- Created ID class to display the player's id.
- Implemented the logic of the game: collecting ID's despite cats following the player.

Next steps:
- Improve design features
- Add difficulty levels to the game

## April 22:
- Implemented the difficulty level into the game. The more is the score, the harder it becomes to complete the game. This took some time as I had a challenge updating the function inside the Cat class and passing the score. A mistake that I did at first was incrementing difficulty instead of setting it to a different value, which resulted in enormous numbers. All fixed now.
- Health is now displaying in a bar for the player to see.

Next steps:
- Play with sound. Can I add a background sound?
- What background design do I want to make?

## April 26:
- Added new background music for a better game experience.
- Got feedback on cat asssociation + flow field: it might be better to let some cats wander around without the follow mouse flow field.

Next steps:
- Implement feedback and see if I need the flow field to follow mouse. How the game can become more interesting with more association / different fields?

## April 28:
- Finalized game design by adding a background image from the @nyuabudhabi Instagram page.
- Edited the background sound to be less loud.
- Played around with the flow field and association: orange (aggressive) cats are not following the player; instead, they wander around in a random flow field and have a greater start acceleration than their non-orange counterparts. Thus it gets more difficult for the player to navigate through the game canvas.

I believe the game is now fully complete, with a few minor improvements left, such as:
- Restarting the game from the beginning on the "Game Over" screen.
- Maybe assigning more behavior for orange cats or adding "cute" cats that increase health?
