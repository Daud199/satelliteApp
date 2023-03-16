//
//  ContentView.swift
//  SatelliteApp
//
//  Created by labadmin on 15/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currentAppState: AppState
    @State var counter: Int = 0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text(String(counter))
            Button("Increase Me") {
                counter += 1
            }
            Button("ChangeView") {
                currentAppState.currentView = AppViews.second
            }
        }
        .padding()
        .onAppear() {
            UITabBar.appearance().tintColor = .white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
