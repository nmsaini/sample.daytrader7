FROM maven:3.9.0-ibmjava-8 as build
COPY . /app/
WORKDIR /app/
RUN mvn clean package

FROM icr.io/appcafe/open-liberty:kernel-slim-java8-ibmjava-ubi
COPY --chown=1001:0 daytrader-ee7/src/main/liberty/config/server.xml /config/server.xml
RUN features.sh
COPY --from=build --chown=1001:0 /app/daytrader-ee7/target/*.ear /config/apps
COPY --from=build --chown=1001:0 /app/daytrader-ee7/target/liberty/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar /opt/ol/wlp/usr/shared/resources/DerbyLibs/derby-10.14.2.0.jar
COPY --from=build --chown=1001:0 /app/daytrader-ee7/target/liberty/wlp/usr/shared/resources/data /opt/ol/wlp/usr/shared/resources/data
RUN configure.sh
