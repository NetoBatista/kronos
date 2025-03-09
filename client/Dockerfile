
FROM ubuntu:24.04

# Install necessary dependencies
RUN apt update \
    && apt install -y \
       bash \
       git \
       curl \
       unzip \
       ca-certificates \
       openjdk-11-jdk \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Flutter
ENV FLUTTER_VERSION=stable \
    FLUTTER_HOME=/opt/flutter \
    PATH="$PATH:/opt/flutter/bin"

# Download and install Flutter
RUN git clone --branch $FLUTTER_VERSION https://github.com/flutter/flutter.git $FLUTTER_HOME
RUN flutter doctor

# Verify the Dart SDK
RUN flutter doctor --version

# Precache Flutter Web to avoid downloads during the build process
RUN flutter config --enable-web \
    && flutter precache --web

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Set build argument for URL_API
ARG URL_API

# Install dependencies and build the Flutter Web app with dart-define
RUN flutter pub get \
    && flutter build web --release --dart-define=URL_API=$URL_API

# Runtime stage using nginx
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]