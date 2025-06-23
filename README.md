# 🎮 Game Catalog - An iOS Game Discovery App

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue.svg)](https://developer.apple.com/xcode/swiftui/)

Welcome to Game Catalog! This is an iOS application designed for exploring the vast world of video games. Discover the latest titles, dive into their details, and save your favorites.

> This project is my second application, developed as part of the "Learning to Create iOS Apps for Beginners" class at **Dicoding Academy**.

## ✨ Key Features

-   **Explore Thousands of Games**: Browse a list of popular games fetched directly from the powerful [RAWG API](https://rawg.io/apidocs).
-   **Real-time Search**: Instantly find any game you're looking for.
-   **Rich Game Details**: Get in-depth information, including descriptions, release dates, and ratings.
-   **Favorites System**: Save your most-loved games to a personal list, stored locally using **Core Data**.
-   **User Profile**: Personalize your experience by setting up your name and details right within the app.

## 🛠️ Tech Stack & Architecture

-   **SwiftUI**: For building a modern, declarative UI.
-   **Combine**: To handle asynchronous operations like network requests gracefully.
-   **Core Data**: For persistent local storage of user's favorite games.
-   **RAWG API**: As the primary data source for all game information.

## 📂 Project Structure

This project is built using the **MVVM (Model-View-ViewModel)** architecture to ensure a clean separation of concerns, making the codebase scalable and easy to maintain.

```bash
└── Game Catalog 2
├── Assets.xcassets                      # Image assets, colors, and App Icon
├── CoreData                             # Manager and models for Core Data
│   ├── CoreDataManager.swift
│   └── GameEntity+...
├── Models                               # Data models for API responses
│   ├── Game.swift
│   ├── GameDetail.swift
│   └── GameResponce.swift
├── Networking                           # Networking components
│   ├── APIService.swift
│   └── Environment.swift
├── Resources                            # Extensions and helpers
│   └── ColorExtensions.swift
├── ViewModels                           # Business logic and state for each View
│   ├── GameListViewModel.swift
│   ├── GameDetailViewModel.swift
│   └── ...
├── Views                                # UI components (the Views)
│   ├── GameListView.swift
│   ├── GameDetailView.swift
│   ├── FavoriteListView.swift
│   └── ...
├── Game_Catalog_2App.swift              # Main application entry point
└── ContentView.swift                    # The main view container, hosting the TabView
```


## ⚙️ Setup & Configuration

This project requires an API Key from RAWG to fetch game data. To maintain security, the API Key is not included in the repository.

### **API Key Configuration Steps:**

1.  **Get a Free API Key**
    -   Go to the [RAWG API website](https://rawg.io/login).
    -   Register or log in, then navigate to the API page to get your unique key.

2.  **Add the API Key to the Project**
    -   Open this project in Xcode.
    -   Navigate to the file: `Game Catalog 2/Networking/Environment.swift`.
    -   You will find an `apiKey` property. Replace the placeholder string `"<YOUR_API_KEY_HERE>"` with the key you obtained.
    -   Follow the path below:

    ```swift
    // Game Catalog 2/Networking/Environment.swift

    import Foundation

    struct Environment {
        static let apiKey = "<YOUR_API_KEY_HERE>" // <-- Replace here
    }
    ```

3.  **Run the Application**
    -   Select a target iOS simulator or device.
    -   Press **Build and Run** (Cmd+R) in Xcode.
    -   That's it! The app is ready to go.

## 👤 About The Developer

This application was created by **Muhammad Rafi Aditya**, a Informatics Engineering student at the University of Darussalam Gontor who is passionate about learning and becoming an iOS Developer.
