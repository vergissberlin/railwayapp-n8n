FROM n8nio/n8n:latest

ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=http

EXPOSE 5678

CMD ["sh", "-c", "export N8N_PORT=${PORT:-5678} && exec n8n start"]
