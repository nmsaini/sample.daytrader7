FROM icr.io/appcafe/open-liberty:kernel-slim-java8-openj9-ubi AS build
USER 0
RUN dnf install maven -y
USER 1001
COPY --chown=1001:0 . /app/
WORKDIR /app/
RUN mvn -Dmaven.repo.local=/tmp clean package

FROM icr.io/appcafe/open-liberty:kernel-slim-java8-openj9-ubi
COPY --chown=1001:0 daytrader-ee7/src/main/liberty/config/server.xml /config/server.xml
RUN features.sh
COPY --from=build --chown=1001:0 /app/daytrader-ee7/target/*.ear /config/apps
COPY --from=build /app/daytrader-ee7/target/liberty/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar /opt/ol/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar
COPY --from=build --chown=1001:0 /app/daytrader-ee7/target/liberty/wlp/usr/shared/resources/data /opt/ol/wlp/usr/shared/resources/data
RUN configure.sh

EXPOSE 9082
