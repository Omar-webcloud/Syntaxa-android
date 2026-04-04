
# Syntaxa Flutter App Blueprint

## Overview

This document outlines the plan and progress for creating a Flutter application named "Syntaxa," based on the provided UI screenshots. The app is an English learning platform with features like quizzes, a dictionary, practice exercises, rewards, and a user profile.

## Style, Design, and Features

### Implemented

*   **Core Structure:**
    *   Basic Flutter project setup.
    *   Dependencies for `provider` (state management) and `google_fonts` (typography) have been added.

### Current Plan

*   **Navigation:** Implement a bottom navigation bar with five sections: Quiz, Dictionary, Practice, Rewards, and Profile.
*   **Theming:**
    *   Create a centralized theme management system using `provider`.
    *   Implement both light and dark themes based on Material 3 principles.
    *   Use `ColorScheme.fromSeed` for a consistent color palette.
    *   Integrate custom fonts using the `google_fonts` package to match the design.
*   **Screens:**
    *   Create placeholder screens for each of the five navigation sections.
    *   The initial focus will be on building the main layout and navigation structure.

## Plan for this Request

1.  **Create `blueprint.md`:** Done.
2.  **Add `cupertino_icons`:** Add the `cupertino_icons` dependency for icons.
3.  **Create screen files:** Create the individual Dart files for each screen (Quiz, Dictionary, Practice, Rewards, Profile).
4.  **Implement `main.dart`:**
    *   Set up `ChangeNotifierProvider` for theme management (`ThemeProvider`).
    *   Define `lightTheme` and `darkTheme` using `ThemeData` and `google_fonts`.
    *   Create a `MainScreen` widget to hold the `Scaffold` with the `BottomNavigationBar`.
    *   Implement the logic to switch between screens.
