# n8n for railway.app

![Template Header](./template-header.svg)

Deploy [n8n](https://n8n.io/) workflow automation on Railway.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template)

## Environment

| Variable | Required | Description |
|----------|----------|-------------|
| `N8N_ENCRYPTION_KEY` | Production | Secret key for credential encryption |

Railway sets `PORT`; the image maps it to `N8N_PORT` at startup.

## Optional

Set `WEBHOOK_URL` to your public HTTPS URL if you use webhooks.

## Local

```bash
docker build -t railwayapp-n8n .
docker run --rm -e N8N_ENCRYPTION_KEY=dev -p 5678:5678 railwayapp-n8n
```
