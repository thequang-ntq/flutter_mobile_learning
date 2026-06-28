# Flutter mobile learning

## Table of Contents

- [Flutter mobile learning](#flutter-mobile-learning)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Goal](#goal)
  - [How to run](#how-to-run)
  - [Fix bugs](#fix-bugs)
    - [2026-06-25](#2026-06-25)
    - [2026-06-26](#2026-06-26)
    - [2026-06-28](#2026-06-28)
  - [UI Screenshots](#ui-screenshots)
  - [Time Tracking](#time-tracking)
  - [Future Work](#future-work)

## Features

- Learning about Dart, Flutter, REST API

## Goal

- Learning and creating Flutter apps

## How to run

1. Clone project
2. Open root folder
3. Open the following dir from root folder: 2. Flutter\code\all, then open VS Code at this dir
4. Open the terminal and run: fvm install -> fvm flutter pub get -> fvm flutter run

## Fix bugs

### 2026-06-25

1. Refactor code: 1 flutter projects for all learning contents

### 2026-06-26

1. Material theme & layout
2. Restructure project architecture (v0.1): main, app, theme, material

### 2026-06-28

1. Change color in color scheme, copyWith to overwrite color (primary is main color, onPrimary is text color on main color, surface is background color) (Default is lightColorScheme)
2. Need private field \_obscurePassword in \_MyFormState (State of StatefulWidget) to show/hide password.
3. Error config fvm for project: Failed to create version symlink
   3.1. ✗ Error updating project references
   3.2. FileSystemException: Cannot create link, path = 'D:\Career\Trainee\NextGen\works\trello_nextgen_intern_mobile\2. 3.3.3. Flutter\code\all\.fvm\versions\3.44.1'(OS Error: A required privilege is not held by the client, error = 1314)
   -> Need Admin in terminal

## UI Screenshots

1. Simple state management app

| Login                                                                            |     | Catalog                                                                              |
| -------------------------------------------------------------------------------- | --- | ------------------------------------------------------------------------------------ |
| ![Login UI](2.%20Flutter/code/all/assets/screenshots/state_management/Login.png) |     | ![Catalog UI](2.%20Flutter/code/all/assets/screenshots/state_management/Catalog.png) |

| Cart                                                                             |
| -------------------------------------------------------------------------------- |
| ![Login UI](2.%20Flutter/code/all/assets/screenshots/state_management/Login.png) |

## Time Tracking

| Date                     | Task                                                                      | Notes |
| ------------------------ | ------------------------------------------------------------------------- | ----- |
| 2026-06-23               | Learning: Variable, datatype, function in Dart                            | .     |
| 2026-06-24               | Learning: Operators, branches, loops, classes in Dart                     | .     |
| 2026-06-25               | Done learning in Dart, learning: Widget, Stateless, Stateful in Flutter   | .     |
| 2026-06-26               | Learning material, cupertino in Flutter, restructure project architecture | .     |
| 2026-06-27 -> 2026-06-28 | Learning state management, fvm; do simple state management app in Flutter | .     |

## Future Work

- [ ] Update app structure, optimize and clean code.
- [ ] UI : Design the UI better, cleaner.
