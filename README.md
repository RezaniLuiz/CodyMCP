# CodyMCP - Free AI Agent for Roblox Studio

![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)
![License](https://img.shields.io/badge/license-GPL--3.0-blue)

**CodyMCP** is a free browser extension that turns DeepSeek, Gemini, Kimi, GLM, Qwen or Arena into a Roblox Studio AI agent.
Control Roblox Studio with AI directly from your browser - read/edit scripts, run Luau, generate assets, all from a normal AI chat. No API key, no terminal, no coding needed.

> 💬 **Stuck? Join the [Discord community](https://discord.gg/RXdhzPy2cW)** get help, share feedback, and follow updates.

> *Also known as: CodyMCP Roblox, CodyMCP free download, Roblox DeepSeek agent, Roblox Gemini agent, Roblox Kimi agent, Roblox GLM agent, Roblox Qwen agent, Roblox Arena agent, Roblox Studio AI automation, Luau AI, MCP Roblox, lemonade alternative free, lemonade.gg alternative, free Roblox AI agent, free lemonade roblox alternative*
## How it works

```
AI chat (DeepSeek / Gemini / Kimi / GLM / Qwen / Arena, in your browser) -> CodyMCP Extension -> Bridge (your PC) -> Roblox Studio
```

The extension runs inside the chat page (DeepSeek, Gemini, Kimi, GLM, Qwen or Arena). When you type a request, it sends commands to the Bridge running on your PC, which drives Roblox Studio through the built-in MCP server.

## Setup

### 1. Download the zip and install the extension

Download the latest zip from the **Releases** page and extract it. The zip contains both the **Bridge** and the **extension folder**.

To load the extension:

- Go to `edge://extensions` (Edge) or `chrome://extensions` (Chrome)
- Enable **Developer mode** (top right toggle)
- Click **Load unpacked**
- Select the `codymcp-extension` folder from the extracted zip

### 2. Start Roblox Studio and enable MCP

Open Studio and load a Place, then enable MCP (first time only):

- Click **Assistant AI** in the top bar
- Click **...** (top right of the Assistant panel)
- Click **Manage MCP Servers**
- Click **Enable Studio as MCP Server**

### 3. Run the Bridge

Double-click `start.bat` inside the extracted folder. A small window opens, that means the Bridge is running.

### 4. Start a session

Go to https://chat.deepseek.com (recommended), https://gemini.google.com, https://www.kimi.com, https://chat.z.ai, https://chat.qwen.ai or https://arena.ai and open a new chat. The CodyMCP bar appears above the input box. Click **Start session**. Type what you want to build.

> Only works on chat.deepseek.com, gemini.google.com, kimi.com, chat.z.ai, chat.qwen.ai and arena.ai - it will not work on any other site.
> On Arena, keep the mode dropdown on **Direct** - CodyMCP blocks Start in Battle / Side-by-Side / Agent modes (it only drives a single Direct reply).
> Gemini and Kimi can be unstable (model behavior, not the extension): Gemini may stop using the Roblox tools after a while, and Kimi may use its own native tools instead. If the AI starts answering in plain text instead of acting, remind it to use the commands or start a new session.

## Panel status

| Dot | Meaning |
|-----|---------|
| Green | Bridge + Studio ready (a place is open) |
| Yellow | Bridge OK, but Studio isn't usable yet - open Roblox Studio, load a place, or enable its MCP server (hover the dot for the exact reason) |
| Grey | Bridge offline - run start.bat |

## Requirements

- Windows PC
- Roblox Studio (MCP support built-in)
- Microsoft Edge or Chrome
- Python 3.8+ (included in start.bat setup)

## Support

CodyMCP is free. If it saves you time share with your friends !

> Credits to CodyMCP for the Core and the OpenSourced Project