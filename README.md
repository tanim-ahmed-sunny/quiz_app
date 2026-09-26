# Quizzical

Quizzical is a Flutter trivia app for practicing general knowledge. Choose a
topic, customize a quiz, answer one question at a time, and see your score when
you finish. Questions and categories are provided by the
[Open Trivia Database](https://opentdb.com/).

## Features

- Browse trivia categories loaded from Open Trivia Database.
- Choose from 1 to 50 questions, a difficulty, and multiple-choice or true/false
	questions. Difficulty and question type can also be left set to Any.
- See answer feedback, quiz progress, and a final percentage score.
- Retry failed network requests from the app when a connection or API error
	occurs.
- Automatically try smaller question batches when the selected category has
	fewer questions available than requested.

## Requirements

- Flutter SDK with Dart 3 or later.
- Android Studio and/or Xcode tooling for the platform you intend to run.
- Internet access to retrieve quiz data from Open Trivia Database.

The repository includes Android and macOS platform projects. Other Flutter
platforms may require generating their platform folders with Flutter before
they can be run.

## Run locally

Clone the repository and fetch its Dart dependencies:

```sh
git clone https://github.com/tanim-ahmed-sunny/quiz_app.git
cd quiz_app
flutter pub get
```

List the available devices, then run the app on a connected device or simulator:

```sh
flutter devices
flutter run -d <device-id>
```

For example, to run on macOS (when developing on a Mac with the macOS desktop
target enabled):

```sh
flutter run -d macos
```

To build for Android or macOS:

```sh
flutter build apk
flutter build macos
```

## Run checks

Run the analyzer and the test suite from the project root:

```sh
flutter analyze
flutter test
```

## Project layout

```text
lib/
	main.dart                 App entry point
	theme.dart                Shared colors and text styles
	models/                   Category and question data models
	screens/                  Home, category, quiz setup, quiz, and results views
	services/                 Open Trivia Database API client
	widgets/                  Shared controls and illustrations
test/                       Automated tests
android/                    Android application configuration
macos/                      macOS application configuration
```

## Data and network behavior

The app requests category and question data from the public Open Trivia Database
API. An internet connection is required; quizzes are not available offline.
Question availability depends on the chosen category and filters, and the
database may rate-limit requests. The app displays retryable errors for network
and API failures and may return fewer questions than requested if the database
does not have enough matching questions.

Open Trivia Database is an independent service. Review its
[API documentation](https://opentdb.com/api_config.php) for details about its
API and data.
