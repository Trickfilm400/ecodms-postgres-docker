FROM debian:bookworm-slim
# install
RUN apt update && apt upgrade -y && apt install wget ca-certificates -y --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN echo "deb https://www.ecodms.de/ecodms_250164/bookworm /" > /etc/apt/sources.list.d/ecodms.list
RUN wget -O /etc/apt/trusted.gpg.d/ecodms.asc https://www.ecodms.de/gpg/ecodms.key
# install dependencies
RUN apt update && apt install -y --no-install-recommends procps libqt5networkauth5 libqt5core5a libqt5network5 qtbase-abi-5-15-8 libqt5sql5-psql libqt5sql5-odbc libqt5sql5-mysql libqt5gui5 libqt5xml5 libqt5widgets5 libjpeg62-turbo libapr1 liblcms2-2 libtiff6 libpng16-16 libjbig0 haveged libqt5webkit5 libopenjp2-7 libidn12 libwebpmux3 nano htop curl postgresql-client && rm -rf /var/lib/apt/lists/*
# download file; unpack file :: after this, apt will be broken (more or less by design), as postgres is not installed fully. AND: deleting useless config file
RUN apt update && apt download ecodmsserver && dpkg --unpack /ecodmsserver* && rm /ecodmsserver*.deb && rm -rf /var/lib/apt/lists/* && rm /etc/ecosims.ini

# add scripts
ADD start.sh /opt
# should run on every start
#RUN bash /opt/start.sh
ADD entrypoint.sh /opt/entrypoint.sh
ADD healthcheck.sh /opt/healthcheck.sh
RUN chmod +x /opt/entrypoint.sh
RUN chmod +x /opt/healthcheck.sh

WORKDIR /opt/ecodms
# expose HTTP WEB
EXPOSE 8080
# expose htto API port
EXPOSE 8180
# expose DESKTOP CLIENT port
EXPOSE 17001


ENV LD_LIBRARY_PATH=/opt/ecodms/ecodmsserver/

# at least one of "INFO", "ERROR", "DEBUG"
ENV ECODMS_LOGLEVEL=INFO
ENV ECODMS_POSTGRES_HOST=postgres
ENV ECODMS_POSTGRES_PORT=5432
ENV ECODMS_POSTGRES_USERNAME=ecosims
ENV ECODMS_POSTGRES_PASSWORD=eco
ENV ECODMS_POSTGRES_DATABASE=ecodms

ENTRYPOINT ["/opt/entrypoint.sh"]

VOLUME ["/data"]

LABEL org.opencontainers.image.authors="Trickfilm400"

STOPSIGNAL SIGINT

HEALTHCHECK --start-period=70s --start-interval=10s --timeout=10s --interval=15s CMD bash /opt/healthcheck.sh