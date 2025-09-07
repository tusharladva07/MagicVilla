# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY MagicVilla.sln ./
COPY MagicVilla_Web/*.csproj MagicVilla_Web/
COPY MagicVilla_VillaAPI/*.csproj MagicVilla_VillaAPI/ || true
COPY MagicVilla_Utility/*.csproj MagicVilla_Utility/ || true

RUN dotnet restore "MagicVilla.sln"

COPY . .
WORKDIR /src/MagicVilla_Web
RUN dotnet publish -c Release -o /app --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "MagicVilla_Web.dll"]
