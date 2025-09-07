# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything and restore dependencies
COPY . .
RUN dotnet restore

# Publish the app to the /app folder
RUN dotnet publish -c Release -o /app

# Use the .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app .

# Expose port 8080 for Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Run your application
ENTRYPOINT ["dotnet", "MagicVilla.dll"]
