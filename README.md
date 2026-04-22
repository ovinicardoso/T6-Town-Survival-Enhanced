# BO2 Plutonium - Survival Town Enhanced Modpack

This repository contains a curated collection of GSC scripts and utilities designed to overhaul the **Survival** experience on the **Town** map (Black Ops II - Plutonium T6). The project focuses on providing a richer interface, visual optimizations, and a robust persistent economic system.

## 🚀 Key Features

### 🎮 Interface (HUD)
* **zm_hud_counters.gsc**: Implements real-time on-screen counters for current health, maximum health, total zombies remaining in the round, and active zombies currently on the map.

### 🛠️ Gameplay Mechanics
* **zm_mechanic_custom_perks.gsc**: A comprehensive overhaul of the perk system. It repositions perk machines across the map and introduces new abilities, including persistent upgrades and extreme survival mechanics.
* **zm_power_always_on.gsc**: Forces the power to stay active permanently, preventing random power outages between rounds for a smoother survival experience.

### 🧪 Perk Breakdown
The following perks are featured in the mechanics script:
* **Jugger-Nog**: Significantly increases the player's maximum health.
* **Tombstone Soda**: Drop a tombstone upon death. Pick it up after respawning to recover your vanilla perks and weapons.
* **Speed Cola**: Increases weapon reload speed.
* **Quick Revive**: Speeds up ally revival and enables auto-revive in solo play.
* **Double Tap Root Beer**: Enhances fire rate and bullet damage.
* **Stamin-Up**: Improves movement speed and sprint duration.
* **Downer's Delight**: Grants weapon buffs and protection while in Last Stand. Increases bleedout time and allows the use of your primary weapon instead of a pistol.
* **Electric Cherry**: Reloading triggers an electric shockwave that stuns nearby zombies.
* **Burn Heart**: Total immunity to all environmental fire and lava damage.
* **Ammo Regen**: Passively regenerates 2 bullets per cycle for all equipped weapons.
* **Widow’s Wine**: Automatically releases a web explosion when hit, paralyzing nearby enemies. Also transforms standard grenades into web grenades.
* **Mule Kick**: Increases your weapon carry limit, allowing you to hold up to 3 weapons simultaneously.
* **PhD Flopper**: Immunity to explosive and fall damage. Performing a Dolphin Dive creates a nuclear explosion dealing 0.7 of the current zombies' health.
* **Bloodthirst**: Killing zombies regenerates health and increases your Maximum Health beyond the standard limit.
* **Guarding Strike**: Melee kills generate a shield that absorbs lethal blows (5-minute cooldown).
* **Rampage**: Taking damage activates a fury state, drastically increasing weapon damage for 30 seconds (5-minute cooldown).
* **Titan Jugg**: Extreme survival upgrade. Increases your Maximum Health (HP) from 250 to 1000.
* **Dying Wish**: Prevents death upon receiving a lethal hit, granting temporary invincibility (5-minute cooldown).
* **Thunder Wall**: Being hit has a chance to trigger a blast of wind that knocks back and launches nearby zombies.
* **Executioner's Edge**: Transforms your knife into a one-shot kill weapon for any round.
* **Headshot Mayhem**: Headshot kills have a chance to trigger an area-of-effect (AoE) explosion and grant extra points.

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
