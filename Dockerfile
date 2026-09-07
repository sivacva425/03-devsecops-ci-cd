# Stage 1: Build dependencies
FROM python:3.11-slim AS builder
WORKDIR /app
COPY src/requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: Minimal runtime image
FROM python:3.11-slim AS runtime
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY src/ .
ENV PATH=/root/.local/bin:$PATH
EXPOSE 8080
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
