# StackOverlay Widget plugin for Flutter

StackOverlay is a widget that will use 2 stacked screens(widgets). The foreground widget is overlayed over the background one and can be hidden or shown depending on a boolean value passed to the StackOverlay widget, just take a look at the example for more details.

Originally designed to provide as a way of forcing a "login" screen to automatically be shown should a user not be logged in(to whatever service) then dismissed once the user has logged in.

The widget takes 3 values

- *background*  - this is the background widget (usually the main screen)
- *foreground*  - this is the dismissable foreground widget( for example a Login screen)
- *showForeground* - a boolean to indicate if the foreground widget should be shown or hidden (defaults to false if not provided)



## Getting Started

For help getting started with Flutter, view the online [documentation](https://flutter.io/).
