#!/usr/bin/env bash

git submodule update --init --recursive

# build E4K
cd Embeddinator-4000
#./build.sh -t Generate-Android
cd ..

# build Xamarin.Forms app
mono .nuget/nuget.exe restore Xamarin.Forms/Weather/WeatherApp.sln
msbuild Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/WeatherApp.Droid.csproj /p:Configuration=Release

# run E4K
rm -Rf bin/
cd Embeddinator-4000
mono build/lib/Release/MonoEmbeddinator4000.exe -gen=Java -platform=Android -c -o ../bin ../Xamarin.Forms/Weather/WeatherApp/WeatherApp.Droid/bin/Release/WeatherApp.Droid.dll
cd ..

# Copy AAR
cp bin/WeatherApp.Droid.aar AndroidStudio/WeatherApp.Droid/WeatherApp.Droid.aar