# us_soccer_flutter

A demo application to showcase functionality of the `elverion/us-soccer-go` repository.

## Web without https endpoint
When using web and non-https domains, you will need to use the following command.
```
flutter run -d chrome --web-browser-flag "--disable-web-security"
```
## When using Mobile
For mobile emulation, change the serverURL to reflect the emulators network in `/lib/const/environmentals.dart`
```
const String serverURL = 'http://10.0.2.2:8080';
```
## Example CSV
```
https://github.com/jokecamp/FootballData/blob/master/other/stadiums-with-GPS-coordinates.csv
```

## Getting Started
Tested platform [windows,linux,web,android]. No IOS application was tested as we have no device.

To get started install flutter [Flutter Install Instructions](https://docs.flutter.dev/get-started/install?_gl=1*l0frce*_up*MQ..&gclid=Cj0KCQjw0_WyBhDMARIsAL1Vz8uXDij_vyuVljvkSMGVpd4TiZCCQbv1PUZ904NJoIBYw-YFJxz7ifwaAtruEALw_wcB&gclsrc=aw.ds)

```
flutter run
```

## Why no .env
Inherently we pass typical env variables to flutter during the build or run command as parameters, this ensures these variables are encrypted within the application. 

To facilitate this, typically a script to parse the .env and apply to the command would be written. As this is a demo we have opted to skip this step and simply store those variables in a file.

## Where are the unit tests?
This application was constructed to showcase the functionality of the `elverion/us-soccer-go` repository. It was developed in reaction to software being developed. Because of this no clear planning was preformed defining any of the functionality. Some test's will now be written, this is not typical of our usual development cycle.