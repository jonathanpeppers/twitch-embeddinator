#!/usr/bin/env bash

# Install E4K from NuGet
mono .nuget/nuget.exe install Embeddinator-4000 -Version 0.1.0 -OutputDirectory packages

# Restore NuGet & build Xamarin app
rm -Rf Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/bin/Debug/
mono .nuget/nuget.exe restore Xamarin.Forms/Weather/WeatherApp.sln
msbuild Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/WeatherApp.Droid.csproj /p:Configuration=Debug

# Run E4K
rm -Rf bin/
cd packages/Embeddinator-4000.0.1
mono tools/MonoEmbeddinator4000.exe -gen=Java -platform=Android -c -o ../../bin ../../Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/bin/Debug/WeatherApp.Droid.dll
cd ../..

# Copy AAR
cp bin/WeatherApp.Droid.aar AndroidStudio/WeatherApp.Droid/WeatherApp.Droid.aar

# Build Java project
cd AndroidStudio
./gradlew assembleDebug
cd ..
