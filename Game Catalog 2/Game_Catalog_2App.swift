import SwiftUI

@main
struct Game_Catalog_2App: App {
    let persistenceController = CoreDataManager.shared

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") ?? .white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") ?? .white]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.BackgroundColor.ignoresSafeArea()

                TabView {
                    GameListView()
                        .tabItem {
                            Label("Game", systemImage: "gamecontroller")
                        }

                    FavoriteListView()
                        .tabItem {
                            Label("Favorit", systemImage: "heart")
                        }

                    AboutView()
                        .tabItem {
                            Label("About", systemImage: "person.circle")
                        }
                }
                .accentColor(Color.PrimaryBlue)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
