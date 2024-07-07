# <img src="./assets/logo.png" width="30" height="30" /> Traccar App -- Flutter

This app is a client for [Traccar](https://www.traccar.org/), an open-source GPS tracking platform. The app is built with Flutter and Dart.

## Platforms
* Android
* iOS
* Web
* Windows
* Linux
* macOS

## Features
* Dark mode
* Multiple map providers (Google Maps, OpenStreetMap, Carto, Stadia)
* Positions animation (play, pause, stop)
* Select time range of positions

## Register Traccar server
To use the app you need to set your Traccar server URL in the login screen.

## Screenshots
### Android
<img src="./screenshots/Android_login.png" width="200" height="400" /> <img src="./screenshots/Android_home.png" width="200" height="400" />

### iOS
<img src="./screenshots/iOS_login.png" width="200" height="400" /> <img src="./screenshots/iOS_home.png" width="200" height="400" />

### Web
<img src="./screenshots/Web_login.png" width="396" height="236" /> <img src="./screenshots/Web_home.png" width="396" height="236" />

### Windows
<img src="./screenshots/Windows_login.png" width="396" height="236" /> <img src="./screenshots/Windows_home.png" width="396" height="236" />

### Linux
<img src="./screenshots/Linux_login.png" width="396" height="236" /> <img src="./screenshots/Linux_home.png" width="396" height="236" />

### macOS
<img src="./screenshots/macOS_login.png" width="332" height="249" /> <img src="./screenshots/macOS_home.png" width="332" height="249" />

## Dark mode map providers
To use dark mode map providers [Stadia](https://stadiamaps.com/) you need to get an API key from their websites and add it to the `lib/utils/tile_providers.dart` file.