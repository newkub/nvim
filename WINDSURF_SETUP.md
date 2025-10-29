# Windsurf.nvim Setup Guide

## การติดตั้งเสร็จสิ้น ✅

Plugin **windsurf.nvim** ได้ถูกติดตั้งและตั้งค่าเรียบร้อยแล้ว

## ขั้นตอนการใช้งาน

### 1. รีสตาร์ท Neovim
```bash
:qa
nvim
```

### 2. ติดตั้ง Plugin
เมื่อเปิด Neovim ครั้งแรก ให้รอให้ lazy.nvim ติดตั้ง windsurf.nvim อัตโนมัติ หรือใช้คำสั่ง:
```vim
:Lazy sync
```

### 3. Authenticate กับ Windsurf
```vim
:Codeium Auth
```
- จะเปิด browser ให้คุณ login
- Copy API token และ paste ใน Neovim

### 4. ทดสอบการใช้งาน
- เปิดไฟล์ใดๆ และเริ่มพิมพ์ code
- Windsurf จะแสดง AI suggestions เป็น virtual text สีเทา
- กด `Tab` เพื่อ accept suggestion

## Key Mappings

### Normal Mode
- `<leader>ca` - Windsurf: Authenticate
- `<leader>cc` - Windsurf: Open Chat (เปิด chat ใน browser)
- `<leader>ct` - Windsurf: Toggle Completion (เปิด/ปิด suggestions)

### Insert Mode
- `Tab` - Accept Windsurf suggestion (ถ้ามี) > หรือ cmp completion > หรือ snippet jump
- `Alt-]` - Windsurf: Next Suggestion
- `Alt-[` - Windsurf: Previous Suggestion
- `Ctrl-x` - Windsurf: Clear Suggestion

## Commands

```vim
:Codeium Auth       " Authenticate กับ Windsurf
:Codeium Chat       " เปิด Windsurf Chat ใน browser
:Codeium Toggle     " เปิด/ปิด completion
```

## Features

✅ **Virtual Text Completions** - แสดง AI suggestions แบบ inline  
✅ **nvim-cmp Integration** - ทำงานร่วมกับ completion menu  
✅ **Chat Support** - เปิด Windsurf Chat ผ่าน command  
✅ **Smart Tab Handling** - Tab key ทำงานร่วมกับ cmp และ snippets

## Configuration

ไฟล์ config อยู่ที่: `lua/plugins/windsurf.lua`

ปรับแต่งได้ตามต้องการ:
- `idle_delay` - เวลารอก่อนแสดง suggestion (default: 75ms)
- `enable_chat` - เปิด/ปิด chat feature
- `virtual_text.enabled` - เปิด/ปิด virtual text

## Troubleshooting

### ถ้า Windsurf ไม่ทำงาน
1. ตรวจสอบว่า authenticate แล้ว: `:Codeium Auth`
2. ลองเปิด/ปิดใหม่: `:Codeium Toggle`
3. Restart Neovim: `:qa` แล้วเปิดใหม่

### ถ้า Tab key ไม่ accept suggestion
- ตรวจสอบว่า virtual text ปรากฏอยู่หรือไม่
- ลองกด `Alt-]` เพื่อ cycle suggestions

### ถ้ามี error message
- รัน `:Lazy sync` เพื่อ update plugins
- ตรวจสอบ dependencies: plenary.nvim และ nvim-cmp

## ความแตกต่างกับ Copilot

|                    | Windsurf (Codeium) | GitHub Copilot |
|--------------------|--------------------|----------------|
| Accept            | `Tab`              | `Alt-l`        |
| Next              | `Alt-]`            | `Ctrl-Alt-]`   |
| Previous          | `Alt-[`            | `Ctrl-Alt-[`   |
| Clear             | `Ctrl-x`           | `Ctrl-]`       |

## เอกสารเพิ่มเติม

- Repository: https://github.com/Exafunction/windsurf.nvim
- Documentation: อ่าน README บน GitHub
