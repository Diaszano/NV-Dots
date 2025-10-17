<p align="center">
  <img src="../.github/assets/logo.svg" alt="NV-Dots logo" width="120"/>
</p>

<h1 align="center">💤 NV-Dots</h1>

<p align="center">
  My personal Neovim setup, based on 
  <a href="https://github.com/NvChad/starter" target="_blank">NvChad/starter</a>.<br/>
  Built for productivity and focused on development with 
  <b>Golang</b>, <b>Python</b>, <b>TypeScript</b>, and <b>JavaScript</b>.
</p>

<p align="center">
  <a href="../README.md">🇧🇷 Leia em português</a>
</p>

---

## 🚀 About

**NV-Dots** is my personal Neovim ~~configuration~~, built upon the [NvChad](https://github.com/NvChad/NvChad) ecosystem — one of the most powerful and modern Neovim distributions.

The goal is to keep a **minimal**, **fast**, and **highly productive** environment with optimized configurations for the languages I use daily.

---

## 🧠 Supported Languages

| Language | Key Features |
|-----------|---------------|
| 🦫 **Golang** | LSP, linting, formatting, and snippets via `gopls` |
| 🐍 **Python** | Integration with `pyright`, `ruff`, and `black` |
| 🟦 **TypeScript / JavaScript** | LSP via `tsserver` and full Node.js support |
| ⚙️ **Other languages** | Base syntax highlighting and navigation provided by NvChad |

---

## ⚙️ Installation

1. Make sure you have Neovim (>= 0.9) installed.
2. Backup or remove any previous configuration:
   ```bash
    mv ~/.config/nvim ~/.config/nvim.backup
    ````

3. Clone this repository:

   ```bash
   git clone https://github.com/Diaszano/NV-Dots ~/.config/nvim
   ```
4. Launch Neovim:

   ```bash
   nvim
   ```

   NvChad will automatically handle plugin installation.

---

## 🧩 Project Structure

```
~/.config/nvim
├── lua
│   ├── configs/         # Plugin-specific settings
│   ├── highlights/      # Color and theme adjustments
│   ├── mappings/        # Custom key mappings
│   ├── plugins/         # Extra plugins
│   └── custom/          # NvChad overrides and customizations
└── init.lua             # Entry point of the configuration
```

---

## 💡 Philosophy

* **Productivity first:** seamless keymaps, formatting, and LSP integration.
* **Focused environment:** tailored for my main languages.
* **Solid base:** leveraging NvChad’s power without unnecessary complexity.
* **Aesthetic design:** modern, elegant, and pleasant to use.

---

## 🧭 Credits

* [NvChad](https://github.com/NvChad/NvChad) — The foundation of this awesome setup.
* [NvChad Starter Template](https://github.com/NvChad/starter) — The base template used for NV-Dots.

---

## 🪶 License

This project follows the same license as [NvChad](https://github.com/NvChad/NvChad) — [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).