# CSE 230 Final Project
### Team: Tina Jin, Bill Hsu, Yi Zhang, Darlene Jiang
## Proposal
#### Project Idea
We intend to implement a playable piano keyboard with additional features like playing MIDI files or an interactive piano tutorial. To our knowledge, there is no existing implementation with Brick, although there are implementations of piano keyboards in Haskell. However, we are proposing a further goal of implementating a game or tutorial, which should be novel.
#### Useful Packages
We are going to utilize the [Brick](https://hackage.haskell.org/package/brick) library for the TUI, and the [Euterpea](https://hackage.haskell.org/package/Euterpea) library for playing individual musical notes.
#### Goals
To start with, we are going to implement a basic piano keyboard, where each note is bound to a key on the computer keyboard. When a key is hit, we want to highlight that key while playing the note bound to the key. If time permits we are going to add more features. The end goal is either a education software with auto-scroll piano sheet music, or a rhythm game with a scoreboard.
#### Timeline
11.9 Project Proposal
Basic Keyboard Implementation, including drawing rectangles for keys, playing notes, and highlighting keys played
11.23 Project Update
Keyboard Addons, including dropping bars as notes are played, or displaying piano sheet music.
12.7 Project Demonstration
