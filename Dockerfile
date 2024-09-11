FROM mcr.microsoft.com/dotnet/core/sdk:3.1-nanoserver-1809 AS build-env
WORKDIR /app
COPY . .
RUN dotnet restore quiz-backend.csproj
RUN dotnet publish quiz-backend.csproj -c Release -o out
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-nanoserver-1809
WORKDIR /app
COPY --from=build-env /app/out .
# set the environment variables
# ENV
ENTRYPOINT ["dotnet", "quiz-backend.dll"]