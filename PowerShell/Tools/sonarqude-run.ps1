param (
    $projectKey, 
    $accessToken
)

dotnet tool install --global dotnet-sonarscanner --version 4.10.0 --interactive

dotnet sonarscanner begin /o:"codat" /k:"$projectKey" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="$accessToken" /d:sonar.cs.opencover.reportsPaths=**/*.opencover.xml

dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

dotnet sonarscanner end /d:sonar.login="$accessToken"