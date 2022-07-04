# Final image.
FROM python:3.9.12-slim-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev=* \
  libssl-dev=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0
ENV PORT 8000


WORKDIR /home/appuser
COPY . /home/appuser

RUN DEBUG=1 python manage.py collectstatic --noinput && \
  # Create non-root user.
  useradd --create-home appuser

USER appuser
