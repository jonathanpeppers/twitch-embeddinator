#!/usr/bin/env bash

cd Embeddinator-4000
./build.sh -t Generate-Android
cd ..

# Restore NuGet & build Xamarin app
rm -Rf Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/bin/Debug/
mono .nuget/nuget.exe restore Xamarin.Forms/Weather/WeatherApp.sln
msbuild Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/WeatherApp.Droid.csproj /p:Configuration=Debug

# Run E4K
rm -Rf bin/
cd Embeddinator-4000
mono build/lib/Release/MonoEmbeddinator4000.exe -gen=Java -platform=Android -c -o ../bin ../Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/bin/Debug/WeatherApp.Droid.dll
cd ..

# Copy AAR
cp bin/WeatherApp.Droid.aar AndroidStudio/WeatherApp.Droid/WeatherApp.Droid.aar

# Build Java project
cd AndroidStudio
./gradlew assembleDebug
cd ..
