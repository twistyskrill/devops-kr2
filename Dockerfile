FROM python:3.12-slim

RUN useradd --system --uid 10001 --no-create-home app
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=app:app app.py .
USER app

EXPOSE 8004
CMD ["gunicorn", "--bind", "0.0.0.0:8004", "--access-logfile", "-", "app:app"]
