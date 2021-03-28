# chatty_widget

A Flutter widget that shows message on tap event.


## Installation
In your `pubspec.yaml` root add:

```yaml
dependencies:
  chatty_widget: LATEST_VERSION_NUMBER
```

on use,

`import 'package:chatty_widget/chatty_widget.dart';`


## Demo

<img src="https://raw.githubusercontent.com/hyobbb/chatty_widget/master/chatty_widget_demo.gif" width="250" />

## Limit

Do Not use widgets like Buttons that has their own onTap callback function. It will be ignored.
Instead, just use onTap method to execute additional method while showing the chat box.