FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy everything
COPY . .

# Restore as distinct layers
RUN dotnet restore "KingsInns.Dining.Contracts\KingsInns.Dining.Contracts.csproj"

# Build and publish a release
RUN dotnet publish "KingsInns.Dining.Contracts\KingsInns.Dining.Contracts.csproj" -c Release -o /app

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "KingsInns.Dining.Contracts.dll"]
