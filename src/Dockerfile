FROM debian:bookworm-slim
# install
RUN apt update && apt update
RUN apt install wget ca-certificates -y --no-install-recommends
RUN echo "deb https://www.ecodms.de/ecodms_240264/bookworm /" > /etc/apt/sources.list.d/ecodms.list
RUN wget -O /etc/apt/trusted.gpg.d/ecodms.asc https://www.ecodms.de/gpg/ecodms.key
RUN apt update
# download file
RUN apt download ecodmsserver
# install dependencies
RUN apt install -y --no-install-recommends procps libqt5networkauth5 libqt5core5a libqt5network5 qtbase-abi-5-15-8 libqt5sql5-psql libqt5sql5-odbc libqt5sql5-mysql libqt5gui5 libqt5xml5 libqt5widgets5 libjpeg62-turbo libapr1 liblcms2-2 libtiff6 libpng16-16 libjbig0 haveged libqt5webkit5 libopenjp2-7 libidn12 libwebpmux3 nano htop curl postgresql-client
# unpack file :: after this, apt will be broken (more or less by design)
RUN dpkg --unpack /ecodmsserver*
# delete install file
RUN rm /ecodmsserver*.deb

# add scripts
ADD start.sh /opt
RUN bash /opt/start.sh
ADD entrypoint.sh /opt/entrypoint.sh
ADD healthcheck.sh /opt/healthcheck.sh
RUN chmod +x /opt/entrypoint.sh
RUN chmod +x /opt/healthcheck.sh

WORKDIR /opt/ecodms
# expose HTTP WEB, API, DESKTOP CLIENT ports
EXPOSE 8080
EXPOSE 8180
EXPOSE 17001


ENV LD_LIBRARY_PATH=/opt/ecodms/ecodmsserver/

ENTRYPOINT ["/opt/entrypoint.sh"]

VOLUME ["/data"]

LABEL org.opencontainers.image.authors="Trickfilm400"

STOPSIGNAL SIGINT

HEALTHCHECK --start-period=70s --start-interval=10s --timeout=10s --interval=15s CMD bash /opt/healthcheck.sh