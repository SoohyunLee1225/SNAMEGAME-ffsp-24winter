# 🐍 Snake Game

This is the desktop app version of the classic snake game, created using **flutter**. Once the game starts, the player's goal, or 'food', is created inside a specific area, and the player aims to control the snake through keyboard input and eat it. Eating increases the length and speed of the snake. Players must move the snake while avoiding collision conditions, and aim to eat as much food as possible to increase their score. In addition, it has been designed to look better by applying animation effects to the logo and background.

---

## 🚀 Features

- **Dynamic Gameplay:**
  - The snake moves and grows as it consumes food.
  - Gradient color transitions for the snake's body from head to tail.
- **Server Integration:**
  - Scores are saved to a server and displayed in a scoreboard.
- **Intuitive Controls:**
  - Keyboard controls for desktop users (`W`, `A`, `S`, `D` for movement, `Q` to quit, etc).
- **Countdown:**
  - 3-second countdown before gameplay begins.

---

## 📷 Screenshots

1. **Splash Screen:**
   - Start the game with a visually appealing splash screen.
2. **Gameplay:**
   - Smooth animations and gradient effects.
3. **Scoreboard:**
   - Display scores stored on the server.

---
 ## 🖥️ How It Works
 **Client-Side**
 -**Game Logic**
   - Handles the snake's movement, collision detection, and scoring.
   - Sends scores to the server and fetches from the server to the scoreboard.

-**Server-Side**
 -**Endpoints**
   - POST /scores: Save the score to the server.
   - GET /scores: Retrieve all stored scores.
 -**Data Management**
   - Uses a lightweight file-based storage(score.txt)

---
## ⌨️Controls
**Splash Screen**
|Key|Action|
|---|------|
|X|Start Game|
|S|Scoreboard|
|Q|Quit Game|


**Game Play**
|Key|Action|
|---|------|
|W|Move up|
|A|Move left|
|S|Move right|
|D|Move down|

**Game Over**
|Key|Action|
|---|------|
|Enter|Go to Mainmenu(Splash screen)|

**Scoreboard**
|Key|Action|
|---|------|
|Esc|Return to previous screen|


---
## 📂 File Structure

```plaintext
snake-game/
├── assets/
│   ├── images/
│   │   ├── background.png
│   │   ├── fallingbackground.gif
│   │   ├── snakegame.gif
│   │   └── gameover.gif
│   ├── fonts/
│   │   ├── SnaredrumTwoNbp.ttf
│   │   └── SnaredruZeroNbp.ttf
├── lib/
│   ├── main.dart           # App entry point
│   ├── snake_game.dart     # Core gameplay logic
│   ├── splash_screen.dart  # Splash screen
│   ├── scoreboard.dart     # scoreboard UI
│   ├── server_api.dart     # Server communication
│   └── gameover_score.dart # Gameover screen
│   │
└── pubspec.yaml            # Dependencies and configuration
```

---
## 🏆 Future Enhancements
-**Multiplayer Mode**
-**Advanced Client-Server System**
-**Database System**

---
## 📝 Credits and Acknowledgments
This project is based on the original work by [Haidar Rehman](https://github.com/HaidarRehmanNazir/Flutter-Snake-Game).

- **Original License:** MIT License
- **Modifications:** Significant changes and extensions were made by [Your Name], [Year].

Original code is available at [(https://github.com/HaidarRehmanNazir/Flutter-Snake-Game)].

---
## ✏️ Fonts

---
## 🖋️ Authors
-**Soohyun Lee**:Developer and Designer

---
## 📜 License
This project is licensed under the MIT License. 




