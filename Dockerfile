FROM python:3.12-alpine as build
RUN set -eux; \
    apk --no-cache upgrade && \
    apk add --no-cache patch
WORKDIR /tmp
COPY bypassing_update_check.patch /tmp
ARG REVISION=master
RUN set -eux; \
    wget "https://github.com/frozenpandaman/s3s/archive/${REVISION}.zip" -O s3s.zip && \
    unzip s3s.zip && rm s3s.zip && mv s3s* /opt/s3s
WORKDIR /opt/s3s
RUN set -eux; \
    patch -u s3s.py -i /tmp/bypassing_update_check.patch
RUN set -eux; \
    echo "$REVISION" > REVISION
RUN set -eux; \
    pip install --user -r requirements.txt
# Cleanup
RUN set -eux; \
    rm -fr .github .gitignore requirements.txt

FROM python:3.12-alpine
LABEL maintainer="issei-m (https://twitter.com/Issei_M)"
RUN addgroup -S -g 1000 s3s && adduser -S -G s3s -u 999 s3s
COPY --from=build /root/.local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY docker-entrypoint.sh /entrypoint.sh
COPY --from=build /opt/s3s /opt/s3s
RUN set -eux; \
    chown -R s3s.s3s /opt/s3s
WORKDIR /opt/s3s
USER s3s
ENTRYPOINT ["/entrypoint.sh", "python", "/opt/s3s/s3s.py"]
