# BO2 Plutonium - Survival Town Enhanced Modpack

This repository contains a curated collection of GSC scripts and utilities designed to overhaul the **Survival** experience on the **Town** map (Black Ops II - Plutonium T6). The project focuses on providing a richer interface, visual optimizations, and a robust persistent economic system.

## 🚀 Key Features

### 🎮 Interface (HUD)
* **zm_hud_counters.gsc**: Implements real-time on-screen counters for current health, maximum health, total zombies remaining in the round, and active zombies currently on the map.

### 🛠️ Gameplay Mechanics
* **zm_mechanic_custom_perks.gsc**: Integrates an advanced perk system with several custom abilities and enhanced legacy perks.
* **zm_power_always_on.gsc**: Forces the power to stay active permanently, preventing random power outages between rounds for a smoother survival experience.

### 🧪 Perk Breakdown
The following perks are featured in the mechanics script:
* **Jugger-Nog**: Significantly increases the player's maximum health.
* **Speed Cola**: Increases weapon reload speed.
* **Quick Revive**: Speeds up ally revival and enables auto-revive in solo play.
* **Double Tap Root Beer**: Enhances fire rate and bullet damage.
* **Stamin-Up**: Improves movement speed and sprint duration.
* **Mule Kick**: Grants an additional primary weapon slot.
* **PhD Flopper**: Grants immunity to fall and explosive damage, triggering an explosion when diving to prone.
* **Deadshot Daiquiri**: Improves accuracy and auto-aims toward the head of enemies.
* **Electric Cherry**: Creates an electric shockwave around the player upon reloading.
* **Burn Heart**: Renders the player immune to lava and fire damage.
* **Dying Wish**: Prevents a down by entering a temporary "berserker" invulnerability mode.
* **Ethereal Razor**: Boosts melee damage, allows for multi-hit attacks, and restores health upon impact.
* **Downer's Delight**: Increases bleedout time and allows the use of the currently equipped weapon while in last stand.
* **Widow’s Wine**: Immobilizes nearby zombies when the player is hit and upgrades standard grenades.
* **Ammo Regen**: Passively regenerates weapon ammunition and grenades over time.

### 💰 Economy & Persistence
* **zm_economy_bank.gsc**: A banking system allowing players to deposit, withdraw, and transfer points via chat commands.
* **bank_watchdog.ps1**: A PowerShell utility that monitors server logs to ensure bank balances are permanently saved to the player's configuration file (`plutonium_zm.cfg`).

### 👁️ Visual Enhancements
* **zm_visual_no_fog.gsc**: Completely removes the dense environmental fog to improve map clarity.
* **zm_visual_lod_fix.gsc**: Adjusts Level of Detail (LOD) settings to prevent distant models from losing quality.

## 🔧 Installation

### GSC Scripts
Move all files from the `/scripts` folder to your Plutonium scripts directory:  
`C:\Users\{user}\AppData\Local\Plutonium\storage\t6\scripts\zm`

### Bank Watchdog
The `bank_watchdog.ps1` file must be running **before** starting your server or match:
1. Right-click `bank_watchdog.ps1`.
2. Select "Run with PowerShell".
3. Keep the window open while playing to ensure data is saved properly.

## ⌨️ Chat Commands
* `.help`: Displays a list of available commands.
* `.b`: Check your current bank balance and points on hand.
* `.d <amount|all>`: Deposit points into the bank.
* `.w <amount|all>`: Withdraw points from the bank.
* `.p <player> <amount>`: Transfer points to another player.

## 📋 Requirements
* Plutonium T6 (Black Ops II).
* PowerShell 5.1 or higher (for the persistence system).
* Town Map (zm_transit).

---
*Note: This project was specifically balanced and tested for the Town Survival experience.*
