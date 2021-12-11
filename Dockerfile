ARG BASE_TAG
FROM jboss/base-jdk:${BASE_TAG}

ARG WILDFLY_VERSION
ENV WILDFLY_VERSION ${WILDFLY_VERSION}
ENV HOME /opt
ENV JBOSS_HOME /opt/wildfly

USER root

WORKDIR $HOME
RUN curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && curl -L https://github.com/wildfly/wildfly/releases/download/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz > wildfly-$WILDFLY_VERSION.tar.gz \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv "$HOME/wildfly-$WILDFLY_VERSION" $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

RUN localedef -i pt_BR -f UTF-8 pt_BR.UTF-8
ENV TZ America/Sao_Paulo

ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN sed -i 's| JAVA_OPTS="-Xms64m -Xmx512m -XX:MaxPermSize=256m -Djava.net.preferIPv4Stack=true"| JAVA_OPTS="-Xms2048m -Xmx2048m -Xss228k -XX:+UseCompressedOops -XX:+UseParallelGC -XX:NewRatio=2 -Djava.net.preferIPv4Stack=true"|g' ${JBOSS_HOME}/bin/standalone.conf

COPY --chown=jboss:0 ./deploys/* ${JBOSS_HOME}/standalone/deployments/

COPY --chown=jboss:0 ./configs/org ${JBOSS_HOME}/modules/org

COPY --chown=jboss:0 ./configs/standalone.xml ${JBOSS_HOME}/standalone/configuration/standalone.xml

# USER jboss

ENV LANG pt_BR.UTF-8
ENV LANGUAGE pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8

EXPOSE 8080 8443

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
