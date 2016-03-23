FROM jboss/wildfly:8.2.1.Final

WORKDIR /opt/jboss/wildfly

ADD modules /opt/jboss/wildfly/modules/
ADD customization /opt/jboss/wildfly/customization/

USER root
RUN yum -y install p11-kit-nss-trust openssl ca-certificates && yum clean all
 RUN curl http://curl.haxx.se/ca/cacert.pem -o /etc/pki/tls/certs/ca-bundle.crt

RUN mkdir -p /usr/share/ssl/certs
RUN cp /etc/pki/tls/certs/ca-bundle.crt /usr/share/ssl/certs/ca-bundle.crt
ADD ./default.crt /etc/pki/ca-trust/source/anchors/

RUN update-ca-trust enable
RUN update-ca-trust check
RUN update-ca-trust extract

RUN echo "root:password12" | chpasswd

RUN chmod +x /opt/jboss/wildfly/customization/execute.sh
RUN /opt/jboss/wildfly/customization/execute.sh

# Fix for Error: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current 
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
RUN chown -R jboss:jboss /opt/jboss/wildfly/
#USER jboss
USER root 

# admin-interface
RUN bin/add-user.sh -s -p passw0rd12 -u naturalist -e

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]


