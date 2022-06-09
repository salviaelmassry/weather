# weather

A new Flutter project.

## Getting Started

This is a flutter project to get the weather of your current city.
By clicking on GET WEATHER button a card will appear with weather info, you can EXPAND or SHRINK the card.
Bloc is used to handle the data and communicate with the repository that calls GETAPI.

A CACHE HELPER "local storage- shared preferences" is used to store last requested weather info locally, when ever the user close the app and open it again he will see a card with his last requested weather info with a message informing him to click on GET WEATHER button to update weather info according to the current day and current location/city.


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
