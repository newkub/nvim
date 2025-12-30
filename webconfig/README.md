# Neovim Web Config

Web UI สำหรับดู/แก้ Neovim config ใน repo นี้ โดยเขียนกลับไปที่ไฟล์จริงได้ทันที (ผ่าน server API)

## Safety

การอ่าน/เขียนไฟล์ทำผ่าน **allowlist เท่านั้น** เพื่อกันแก้ไฟล์มั่ว/เขียนข้ามโฟลเดอร์

- allowlist อยู่ที่ `server/utils/config-allowlist.ts`

## Project Structure (refactor)

- `app/pages/` orchestration layer
- `app/components/` UI layer
- `app/composables/` (call) API layer
- `app/composables/facade/` glue layer (ซ่อน store จาก UI)
- `app/stores/` state + orchestration
- `shared/types/` types + schemas (ใช้ร่วม client/server)
- `server/api/` API endpoints
- `server/utils/` server-only utilities (allowlist, path, read/write)

## Setup

```bash
bun install
```

## Dev

```bash
bun run dev
```

## Verify

```bash
bun run lint
bun run test
bun run build
```

## Add new editable file

เพิ่ม entry ใหม่ใน `server/utils/config-allowlist.ts` แล้ว UI จะเห็นไฟล์นั้นทันที
