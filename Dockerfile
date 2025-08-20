FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies
COPY pyproject.toml .
COPY README.md .
RUN pip install --no-cache-dir .

# Copy the source code
COPY src/ ./src/

# Expose port for Cloud Run
EXPOSE 8080

# Set environment variables for HTTP transport
ENV PORT=8080
ENV MCP_TRANSPORT=http

# Run the FastMCP native server
CMD ["python", "-m", "excel_mcp", "--transport", "sse", "--port", "8080"]