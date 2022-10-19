FROM python:3.10-alpine as build
WORKDIR /tmp
RUN set -eux; \
      wget https://github.com/frozenpandaman/s3s/archive/refs/heads/master.zip -O s3s.zip && \
      unzip s3s.zip && rm s3s.zip && mv s3s* /opt/s3s
WORKDIR /opt/s3s
RUN set -eux; \
      pip install -r requirements.txt
# Cleanup
RUN set -eux; \
      rm -fr .github .gitignore requirements.txt

FROM python:3.10-alpine
LABEL maintainer="issei-m (https://twitter.com/Issei_M)"
RUN addgroup -S -g 1000 s3s && adduser -S -G s3s -u 999 s3s
COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY docker-entrypoint.sh /entrypoint.sh
COPY --from=build /opt/s3s /opt/s3s
RUN set -eux; \
      chown -R s3s.s3s /opt/s3s
WORKDIR /opt/s3s
USER s3s
ENTRYPOINT ["/entrypoint.sh", "python", "/opt/s3s/s3s.py"]
