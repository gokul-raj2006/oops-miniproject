# Use a base image with JDK 21
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Install JavaFX SDK and JSON library
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://download2.gluonhq.com/openjfx/21.0.2/openjfx-21.0.2_linux-x64_bin-sdk.zip && \
    unzip openjfx-21.0.2_linux-x64_bin-sdk.zip -d /usr/lib/ && \
    rm openjfx-21.0.2_linux-x64_bin-sdk.zip && \
    wget https://repo1.maven.org/maven2/org/json/json/20231013/json-20231013.jar -O /usr/lib/json.jar

# Copy your Java files
COPY . .

# Compile your JavaFX app with JavaFX and JSON JARs in classpath
RUN mkdir -p out && \
    javac --module-path /usr/lib/javafx-sdk-21.0.2/lib --add-modules javafx.controls,javafx.fxml \
    -cp /usr/lib/json.jar -d out VoiceRecognitionFX.java

# Set the default command to run your app
CMD ["java", "--module-path", "/usr/lib/javafx-sdk-21.0.2/lib", "--add-modules", "javafx.controls,javafx.fxml", "-cp", "out:/usr/lib/json.jar", "VoiceRecognitionFX"]
