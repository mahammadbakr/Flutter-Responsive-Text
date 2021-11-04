
# Flutter Responsive Text

A new Flutter package to make your texts Responsive.
  The Package will Assist you to calculate size of texts and wieghts.
  Specify which Type of Texts you want to show such as [ headline, bodytext,
  subtitle text or caption text] so that is all...

## Features

  - Determine the Size of text depends on the screen height + width.
  - Specify the Weight of texts depend on the Text Type.

## Getting started

  Run one of these Commands to install
  ```dart
    dart pub add responsive_text
  ```
  ```dart
    flutter pub add responsive_text
  ```
  or add this line in pubspec.yaml
  ```dart
    responsive_text: ^version
  ```

## Usage

  - Import the Package where you want to use it
  ```dart
    import 'package:responsive_text/responsive_text.dart';
  ```

  - Use the Widget jus like simple Text Widget plus one new field
    named 'TextType'
  ```dart
    const ResponsiveMyText(
                  'Please Enter some text !',
                  textType: TextType.bodyText1,
                  style: TextStyle(color: Colors.black),
                ),
  ```

