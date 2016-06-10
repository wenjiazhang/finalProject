# finalProject
Second term final project with Wendy and Kelly

Project Name: Exploding Kittens-a BomberMan remake
Team Name: Vet ER

Project Description: BomberMan. Goal is to be the last one standing by killing all other characters and players. Secondary Goal is to get the highest score possible. Your score increases with the number of walls you destroy, the number of upgrades you obtain, and the number of people you kill.

How To Play: To Move, use the up, down, left and right arrows on your keyboard. In 2-Player Mode, the 2nd player will use the arrows while the 1st uses A, S, D, W. To drop a bomb, hit the space bar! Good luck!

Day by Day Log:

5/16 Updated README, created files (with nothing in them) (short-term goals): make tiles, have player move with keyboard input, placing bombs
5/18 Made Characters, made them move, and allowed for dropping of bombs, started on cross class
5/18 Made grid of Tiles and Blocks are on some of the tiles. (short-term goals):Player should look as if moving between tiles (no weird standing in middle of two tiles), bombs should break tiles nearby
5/21 Changed coloring of tiles, deleted block class, just made blocks by making state variable in Tile. short-term goals: not walking past walls, items, bombs exploding in cross
5/22 breaking walls work! items (speedUp and firePowerUp) images load and speedUp works! 
5/22 made breaking walls work again, firePowerUp works! had trouble making crosses right sizes and hitting tiles less than radius, but figure it out!  
5/23 Fixed collision/auto turning.Changed probability of tiles having items. Removed grid-limiting movement. Bombs now snap to grid when created!
5/25 started on fixing the Fire-Power Upgrade (it's only supposed to break adjacent walls but it can attack other players up to a radius of their firePower away) works half the time right now.
5/26 Finished fixing the Fire Upgrade, works 99% now!, fixed the verrrryyyy annoying IndexOufOfBounds error that occurred when a player exploded a bomb that's firepower radius would reach over the grid. 
6/2 Finished first pre-set level! (Had to utilize BufferedReader), fixed small bug relating to grid, implemented score system (20 points for each wall you break and 10 points off for each time you hurt yourself), made page for when game ends("YOU LOSE") (short-term) goals: AI, when you hit opponent, score increases by 100 points, have options on end page to go to menu or play again.
6/3 started on making hard-to-break tiles (require two hits before actually breaking), will finish that and also do unbreakable tiles (basically permanent walls, will have to figure out how to make them permanent).
6/6 finished hard-to-break and unbreakable tiles, fixed bug involving collisions (the player was stepping on the new tiles, because originally it had only looked for tiles with state == 2, changed it to >= 2). I did the work at school, but had to commit and push at home because of merging problems.
6/6 added button class, main menu, another player. Cleaned up A BUNCH of code, added graphics to make it look like an actual game! Also, now player looks as if they are changing direction when they are moving (using different images when different keys are activated).
6/7 made end page look prettier! (You'll see during the demo), fixed a small bug that came from unbreakable tiles), started working on pvp
6/7 changed tile color coding (made it easier to see which are unbreakable, hard-to-break, or regular tiles). Other characters can now take damages, added a win screen, added bomb graphics (exploding kittens!, players flash on screen when bomb hits them)
6/9 fixed IndexOutOfBounds error for right and bottom borders of the screen, upgraded win page, made more buttons (on win and lose page, now there are "play again" buttons,i accidentally pasted something in the code, that i shouldnt have (deleted it after)
6/9 fixed bug that resulted from the play again buttons (after playing for the second time in a row, the screen would immediately change to the win/lose state (since it was saved at that state the last time)
6/9 fixed ANOTHER bug that resulted from the option to play again (if you had lost the previous time, the second game would start off with the player flashing and with -10 points (the last bomb from the first game had not been deleted from the arraylist explosives yet), made mode select page and the buttons in it, worked more on pvp but still stuck.
6/9 FINISHED AI, improved graphics even further (tiles became circles, empty circles represent tiles you've broken, fixed bugs (one of them let the ai walk past the circular tiles), added music!
6/10 (2:00 in the morning) finalized map (has no large tile blocks and no large wall blocks), fixed a lot of things for the 2nd player in pvp (it can pick up and use items as well now! 2nd player score and health systems work now (made score a character class variable instead of a global variable)!, win screen after pvp specifies WHICH player won and THEIR specific score! (opposed to before where it kept on only showing 1st player's)