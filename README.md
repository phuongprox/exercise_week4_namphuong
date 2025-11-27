🚀 Flutter Advanced Features Demo
This project is a simple Flutter application designed to introduce and test core and advanced features of Flutter and Dart, focusing on data management, complex list display, and asynchronous/parallel processing. Each feature is placed on a separate screen for easy exploration and testing.

🛠️ Technologies Used
Flutter: Cross-platform UI framework.

Dart: Programming language.

shared_preferences: Package for simple data persistence.

✨ Core Features
The application is structured with a main Home Screen that provides navigation options to the following feature demo screens:

1. 📱 ListView (Scrollable List)
* Objective: Display scrollable data lists, efficiently using the ListView.builder widget for large datasets.
* Demo: A vertical scrolling list of placeholder items (ListTile).

2. 🖼️ GridView (Grid Layout)
* Objective: Display data using a grid layout.
* Demo: Uses GridView.count or GridView.builder to show a collection of boxes or cards in a grid format.

4. 💾 SharedPreferences (Local Storage)
* Objective: Practice saving and reading simple, small, synchronous key-value pairs on the device.
* Demo: A screen allowing the user to input a string/number, save it using SharedPreferences, and display the saved value even after restarting the app.
4. ⏳ Async / Future (Asynchronous Operations)
* Objective: Handle asynchronous tasks (e.g., simulating network data loading or file access) using async/await and Future.
* Demo: A button that triggers a Future.delayed function to simulate data loading, displaying a CircularProgressIndicator while waiting, and then showing the result.

5. 🔥 Isolate (compute) (Parallel Processing)
* Objective: Run CPU-intensive computational tasks on a separate thread (Isolate) to prevent blocking the UI thread.
* Demo: Uses the compute function from flutter/foundation to execute a heavy computational task (e.g., calculating a large Fibonacci number or a long loop) and displays the result.
🎯 Bonus: Dart Console Isolate (Challenge 2)
* Objective: Explore how to manually create and manage an Isolate in a Dart environment (often used for CLI or more complex background tasks than Flutter's compute).
* Demo: An example in a separate subdirectory/file (/lib/challenge2_isolate/) demonstrating the creation of a new Isolate and sending/receiving data via SendPort and ReceivePort.

⚙️ Setup and Run
Clone the repository:

Bash

git clone github.com/phuongprox/exercise_week4_namphuong
cd exercises_week4_namphuong
Get dependencies:

Bash

flutter pub get
Run the application:

Bash

flutter run

📂 Project Structure
```
lib/
 ├── main.dart
 ├── exercise1_listview.dart
 ├── exercise2_gridview.dart
 ├── exercise3_shared_preferences.dart
 ├── exercise4_async.dart
 └── exercise5_isolate.dart
 └── exercise6_isolate_communication.dart
```
