# ps-adminmenu For RSGCore RedM Converted by DFA-Developments
The Admin Menu crafted by [OK1ez](https://github.com/OK1ez) and our dedicated team is user-friendly and intuitive. We invite you to contribute by submitting new features through PRs. We're always eager to review and consider new features. Make sure you use our template when opening Issues or they will be auto closed.

### [DFA-DEVELOPMENTS](https://discord.gg/dMvdur7vdR)

# Preview
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/0da6cf4d-fc72-497f-a59c-08011b3785ab" width="300">
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/2d366445-4094-4a10-a570-265cb230fc37" width="300">
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/33382d64-3b95-42aa-9659-d92dbdca94d2" width="600">
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/d63982c6-9b04-4dec-b059-55e1cc5ea608" width="600">
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/ab44df15-7d9e-4753-9c71-2492348a229d" width="600">
<img src="https://github.com/Project-Sloth/ps-adminmenu/assets/82112471/6f1d0ea9-ea55-4088-98de-ceb4fb1c3838"  width="600">

# Change Language.
- Place this `setr ox:locale en` inside your `server.cfg`
- Change the `en` to your desired language!

**Supported Languages:**
| **Alias** | **Language Names**   |
| --------- | -------------------- |
| en        | English              |
| fr        | French               |
| id        | Indonesia            |
| pt-br     | Brazilian Portuguese |
| tr        | Turkish              |
| es        | Spanish              |
| nl        | Dutch                |
| no        | Norwegian            |
| de        | German               |

# Features
* Admin Horse
* Ban Player
* Bring Player
* Change Weather
* Check Permissions
* Clear Inventory
* Clear Inventory Offline
* Copy Coordinates
* Delete Vehicle
* Freeze Player
* Give Item
* Give Item to All
* Give Money
* Give Money to All
* Give NUI Focus
* God Mode
* Invisible
* Infinite Ammo
* Kick Player
* Kill Player
* Make Player Drunk
* Message Player
* Mute Player
* No Clip
* Open Inventory
* Open Stash
* Play Sound
* Remove Money
* Remove Stress
* Revive All
* Revive Player
* Revive Radius
* Set Bucket
* Server Announcement
* Set Ammo
* Set Gang
* Set Job
* Set Permissions
* Spectate Player
* Teleport Back
* Teleport to Coordinates
* Teleport to Marker
* Teleport to player
* Toggle Coords
* Toggle Cuffs
* Toggle Duty
* Toggle Names
* Warn player

# Depedency
1. [rsg-core](https://github.com/Rexshack-RedM/rsg-core)
2. [ox_lib](https://github.com/overextended/ox_lib)

# Installation
1. Download the latest release.
2. Add the files to your server resources.
3. Ensure `ps-adminmenu` in your server cfg. Make sure ox_lib starts before ps-adminmenu.
4. Set the config in `shared/config.lua` to your needs.

## Permissions
Make sure you've correctly configured player permissions in your server.cfg by using ACE permissions with the appropriate identifier. Otherwise, you'll be unable to access or launch the admin menu. Here's a sample configuration where the player, MonkeyWhisper, is assigned god, admin, and mod roles, you should not have all 3 permissions for a single person. For a deeper understanding of how QBCore manages permissions, refer to [this documentation.](https://docs.qbcore.org/qbcore-documentation/guides/setting-permissions)

### Player Permission
```
add_principal identifier.fivem:565139 rsgcore.god # MonkeyWhisper
add_principal identifier.fivem:565139 rsgcore.admin # MonkeyWhisper
add_principal identifier.fivem:565139 rsgcore.mod # MonkeyWhisper
```


## Setting Up Logs
1. Set up a Discord Webhook for the channel you want the logs to be.
2. Add this to `rsg-essentials/server/logs.lua` -
`['ps-adminmenu'] = 'discord webhook'`
3. Replace the place holder with your webhook link.


# Credits
* [OK1ez](https://github.com/OK1ez)
* [Lenzh](https://github.com/Lenzh)
* [LeSiiN](https://github.com/LeSiiN)
* Project Sloth Team
