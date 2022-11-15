# **CSE 230N Final Project**
### **Team** 
Tina Jin A14463292,
Bill Hsu A59010414,
Yi Zhang A59012460,
Darlene Jiang 
## **1. Project Overview** 
Our goal is to create an interactive piano application from scratch with different novel functionalities. To be more specific, we want it to be an interactive piano music game with computer keyboard or mouse as piano keys ([ExampleDemo](https://www.youtube.com/watch?v=vMHbEIX8CFE)). Further more, if we are ahead of our schedule, it's planned that we will make it an automatic music playing software when fed with composed nodes(MIDI files).   
### **1.1 Packages Used**
* [Brick](https://hackage.haskell.org/package/brick): library for building up graphical user interface
* [Euterpea](https://hackage.haskell.org/package/Euterpea): library for playing individual musical notes.
* [Gloss](https):
* [vty](https):

## **2. Problem Statement**
### **2.1 User Stories**


### **2.2 Project Requirements**
**In Scope**
* **Complete Basic GUI**: should be able to draw black and white keys on our GUI
    * Gloss, vty, Brick 
* **Piano Keyboard Binding**: should be able to play notes 
    * Euterpea
* **Highlight Piano Key Plays**: should be able to demonstrate corresponding pressed keys on GUI 

**Out of Scope**
* **Music Game with Score System**:
    * subfunctions
* **Automatic Music player**:

### **3. System Design**
Since we are creating a game, it's easier to use ***Finite State Machine(FSM)*** to demonstrate our original design patterns. The high-level state transition diagram is shown in Figure 1.
### ***Timeline***
11.9 Project Proposal\
Basic Keyboard Implementation, including drawing rectangles for keys, playing notes, and highlighting keys played\
11.23 Project Update\
Keyboard Addons, including dropping bars as notes are played, or displaying piano sheet music.\
12.7 Project Demonstration
