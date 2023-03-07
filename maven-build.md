# Motivation 
To build this project inside a Maven container rather than installing Maven, I ended up forking the original repo.

# Steps
1. git clone https://https://github.com/nmsaini/sample.daytrader7 

2. build datatrader app as a container image
```
cd sample.daytrader7
podman build -t dt7 -f maven-build.dockerfile .
```

3. Run in a container
```
podman run -it --rm -p 9082:9082 dt7
```

4. Open browser http://hostname:9082/daytrader
