#Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS builder
WORKDIR /src
COPY ./dotnetAKS.csproj .
RUN dotnet restore dotnetAKS.csproj
COPY . .
RUN dotnet build dotnetAKS.csproj -c Debug -o /src/out
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=builder /src/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "dotnetAKS.dll"]