# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy solution and csproj files
COPY MagicVilla.sln ./
COPY MagicVilla_Web/MagicVilla_Web.csproj MagicVilla_Web/
COPY MagicVilla_VillaAPI/MagicVilla_VillaAPI.csproj MagicVilla_VillaAPI/
COPY MagicVilla_Utility/MagicVilla_Utility.csproj MagicVilla_Utility/

# Restore dependencies
RUN dotnet restore MagicVilla.sln

# Copy everything and build
COPY . .
WORKDIR /src/MagicVilla_Web
RUN dotnet publish -c Release -o /app --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app .

# Tell ASP.NET Core to listen on port 8080
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "MagicVilla_Web.dll"]
