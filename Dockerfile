# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY MagicVilla.sln ./
COPY MagicVilla/MagicVilla.csproj MagicVilla/

# Restore dependencies
RUN dotnet restore MagicVilla.sln

# Copy everything else
COPY . .

# Build and publish
WORKDIR /src/MagicVilla
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .

# Expose port 8080 for Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Run the app
ENTRYPOINT ["dotnet", "MagicVilla.dll"]
