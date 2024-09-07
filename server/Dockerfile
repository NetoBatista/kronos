# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy all project files
COPY . .

# Navigate to the folder where the main .csproj file is located
WORKDIR /source

# Build and publish the application
RUN dotnet publish -c Release -o /app/publish

# Final stage: create the image for production use
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Expose port 8080
EXPOSE 8080

# Command to start the application
ENTRYPOINT ["dotnet", "Kronos.dll"]
