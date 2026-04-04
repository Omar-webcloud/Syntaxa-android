
# Blueprint: Syntaxa Flutter App

## Overview

This document outlines the plan and progress for developing Syntaxa, a Flutter-based mobile application for learning English grammar. The app is inspired by the UI/UX of the web application at [https://github.com/Omar-webcloud/Syntaxa](https://github.com/Omar-webcloud/Syntaxa).

## Current Plan

### Phase 1: Foundational Setup & UI Mockups

The initial phase focuses on setting up the project structure, theming, and building the static UI for each of the five main screens.

**Steps:**

1.  **Project Initialization:**
    *   [x] Clear default boilerplate code.
    *   [x] Create this `blueprint.md` file.

2.  **Dependency Management:**
    *   [ ] Add `provider` for state management (especially for theme toggling).
    *   [ ] Add `google_fonts` for custom typography to match the design.
    *   [ ] Add `go_router` for navigation.

3.  **Core App Structure:**
    *   [ ] Implement a `ThemeProvider` to manage light and dark modes.
    *   [ ] Set up the main `MaterialApp` with a custom `ThemeData`.
    *   [ ] Create a home screen (`HomePage`) that contains the `BottomNavigationBar`.
    *   [ ] Create placeholder widget files for each of the five main screens:
        *   `quiz_screen.dart`
        *   `dictionary_screen.dart`
        *   `practice_screen.dart`
        *   `rewards_screen.dart`
        *   `profile_screen.dart`

4.  **UI Implementation (Static):**
    *   [ ] **Quiz Screen:** Build the UI for the daily quiz, including the progress bar, question card, and answer options.
    *   [ ] **Dictionary Screen:** Build the UI for the dictionary, including the search bar and "Word of the Day" card.
    *   [ ] **Practice Screen:** Build the UI for sentence practice and practice exercises.
    *   [ ] **Rewards Screen:** Build the UI for displaying rewards, streaks, and achievements.
    *   [ ] **Profile Screen:** Build the UI for the user profile and settings.

## Style, Design, and Features (Completed)

*This section will be updated as features are implemented.*

