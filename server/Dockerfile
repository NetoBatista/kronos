FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /app

COPY . ./

RUN dotnet restore

RUN dotnet publish -c Release -o out

EXPOSE 8080

ENTRYPOINT ["dotnet", "/app/out/Kronos.dll"]