FROM jboss/wildfly:8.2.1.Final

WORKDIR /opt/jboss/wildfly

COPY modules /opt/jboss/wildfly/modules/
COPY customization /opt/jboss/wildfly/customization/

USER root
RUN yum -y install p11-kit-nss-trust openssl ca-certificates && yum clean all
RUN curl http://curl.haxx.se/ca/cacert.pem -o /etc/pki/tls/certs/ca-bundle.crt

RUN mkdir -p /usr/share/ssl/certs
RUN cp /etc/pki/tls/certs/ca-bundle.crt /usr/share/ssl/certs/ca-bundle.crt
COPY ./default.crt /etc/pki/ca-trust/source/anchors/

RUN update-ca-trust enable
RUN update-ca-trust check
RUN update-ca-trust extract

RUN echo "root:password12" | chpasswd

RUN chmod +x /opt/jboss/wildfly/customization/execute.sh
RUN /opt/jboss/wildfly/customization/execute.sh

# Fix for Error: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current 
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
RUN chown -R jboss:jboss /opt/jboss/wildfly/

USER jboss
ADD naturalist_mediaserver.war /opt/jboss/wildfly/standalone/deployments/

USER root 

# admin-interface
RUN bin/add-user.sh -s -p passw0rd12 -u naturalist -e

# tini, zombie reaper
ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]

ADD wait-for-it.sh /opt/jboss/wildfly
CMD ./wait-for-it.sh --timeout=40 dbnf:3306 --strict -- /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]


