# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy all project files
COPY . .

# Navigate to the folder where the main .csproj file is located
WORKDIR /app/Kronos

RUN apt-get update && apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    dotnet workload install wasm-tools

# Remove existing appsettings.json and create a new one with desired content
RUN rm -f wwwroot/appsettings.json
RUN echo '{"KronosApi": "http://localhost:8006"}' > wwwroot/appsettings.json

# Publish the project as WebAssembly standalone
RUN dotnet publish -c Release -o /app/dist /p:WasmBuildNative=true /p:WasmEnableSIMD=true

RUN ls -l /app/dist

# Stage 2: Final image
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy published files from the build stage
COPY --from=build /app/dist/wwwroot .

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
