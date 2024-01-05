# RobloxModeration
A simple moderation system built to assist you with moderating your game.

How does this work? Well...
## 📚 Setup Instructions
1. Insert the RBXM file provided into your workspace.
2. Read the README.lua file, and arrange every asset using its instructions.

### No, I like making things difficult. How do I set this up in a difficult manner?
1. Copy-paste every script from the repo into a script in ROBLOX. At the top of each script, CLIENT, MODULE, or SCRIPT is indicated. You can use this to determine how to insert the scripts.
2. Arrange the scripts in your game following the README.lua file inside the repo.
3. Create the necessary instances (remote events, guis, etc...) as stated in the README.lua file.

## 🚨 Bugs
I am aware that this repository may contain bugs as I have not thuroughly tested it in a large experience. If you encounter any bugs, simply submit a bug report. I will do my best to get back to you, and I will update the repository with updated code. Your feedback is appreciated!

## 📋 Use Instructions
So, how do I use this thing? Good question! **This system features 4 commands:**
- **:ban (player) (reason)** - Bans a player from the experience.
- **:kick (player) (reason)** - Kicks the player from the experience.
- **:admin (player) (reason)** - Gives administrative permissions to a player.
- **:unban (player)** - Unbans a player from the experience.
🛑 Please note, this system relies on ROBLOX's DataStore Service, meaning that **bans and admins do NOT transfer to other experiences**.
To use the system, follow the following steps:
1. First, press **'** on your keyboard. This will open the admin panel.
2. Click on the "Enter command" field on the GUI, and enter your desired command. Commands should start with the : prefix. Arguments (ex: :ban (player) (reason)) should be seperated by spaces.
3. Press **enter** (or return) on your keyboard. This will send the admin command and close the panel.
4. If you opened the panel on accident, just press enter with an empty textbox.
