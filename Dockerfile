# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY MagicVilla.sln ./
COPY MagicVilla_Web/MagicVilla_Web.csproj MagicVilla_Web/
COPY MagicVilla_VillaAPI/MagicVilla_VillaAPI.csproj MagicVilla_VillaAPI/
COPY MagicVilla_Utility/MagicVilla_Utility.csproj MagicVilla_Utility/

# Restore dependencies
RUN dotnet restore MagicVilla.sln

# Copy everything
COPY . .

# Publish ONLY the Web project
WORKDIR /src/MagicVilla_Web
RUN dotnet publish -c Release -o /app --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .

# Expose port for Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "MagicVilla_Web.dll"]
