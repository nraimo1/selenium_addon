ARG BUILD_FROM
FROM $BUILD_FROM

ENV SELENIUM_HUB_PORT 4444
EXPOSE ${SELENIUM_HUB_PORT}

# Installs latest Chromium package.
RUN \
    apk upgrade --no-cache --available \
    && apk add --no-cache \
      chromium \
      chromium-chromedriver \
      chromium-swiftshader \
      ttf-freefont \
      font-noto-emoji 

ARG SELENIUM_JAR_URL=http://selenium-release.storage.googleapis.com/3.9/selenium-server-standalone-3.9.1.jar
ENV SELENIUM_JAR_URL $SELENIUM_JAR_URL

ENV SELENIUM_DIR /selenium
ENV SELENIUM_JAR selenium-server-standalone.jar

WORKDIR ${SELENIUM_DIR}

RUN apk --no-cache add \
        openjdk8-jre-base

COPY stop_trap.sh ${SELENIUM_DIR}
ADD ${SELENIUM_JAR_URL} ${SELENIUM_DIR}/${SELENIUM_JAR}

COPY entrypoint.sh ${SELENIUM_DIR}
RUN chmod +x ${SELENIUM_DIR}/*.sh

ENTRYPOINT ["./entrypoint.sh"]
