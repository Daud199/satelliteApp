//
//  SatelliteAppApp.swift
//  SatelliteApp
//
//  Created by labadmin on 15/03/23.
//

import SwiftUI

enum AppViews {
    case content, second, satellite
}

class AppState: ObservableObject {
    @Published var currentView: AppViews = AppViews.content
}

@main
struct SatelliteApp: App {
    @ObservedObject var currentAppState = AppState()
    @State var selectedView = "Content"
    var body: some Scene {
        WindowGroup {
            Text(selectedView)
            switch currentAppState.currentView {
            case AppViews.content:
                ContentView()
                    .environmentObject(currentAppState)
            case AppViews.second:
                SecondView()
                    .environmentObject(currentAppState)
            case AppViews.satellite:
                SatelliteView()
                    .environmentObject(currentAppState)
            default:
                ContentView()
                    .environmentObject(currentAppState)
            }
            /*
            TabView (selection: $selectedView){
                ContentView()
                    .tabItem{
                        Label("Content", systemImage: "list.dash")
                    }
                    .tag("Content")
                SecondView()
                    .tabItem{
                        Label("SecondView", systemImage: "square.and.pencil")
                    }
                    .tag("Second")
                ThirdView()
                    .tabItem{
                        Label("ThirdView", systemImage: "square.and.pencil")
                    }
                    .tag("Third")
                SatelliteView()
                    .tabItem{
                        Label("Satellite", systemImage: "square.and.pencil")
                    }
                    .tag("Satellite")
            }
             */
        }
    }
}
