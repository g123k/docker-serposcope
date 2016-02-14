FROM java:8u72-jre
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

RUN ap-get update && apt-get install -y \
      curl \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/*

ENV SERPOSCOPE_VERSION 2.2.0

RUN mkdir -p /opt/serposcope /var/log/serposcope /var/lib/serposcope/
RUN curl -L https://serposcope.serphacker.com/download/${SERPOSCOPE_VERSION}/serposcope-${SERPOSCOPE_VERSION}.jar > /opt/serposcope.jar
RUN useradd -u 1000 -d /home/serposcope -m serposcope
RUN chown serposcope:serposcope /var/log/serposcope /var/lib/serposcope/
COPY serposcope.conf /etc/serposcope.conf

EXPOSE 7134

USER serposcope

CMD	java -Dserposcope.conf=/etc/serposcope.conf -jar /opt/serposcope.jar