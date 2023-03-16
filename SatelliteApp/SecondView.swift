//
//  SecondView.swift
//  SatelliteApp
//
//  Created by labadmin on 15/03/23.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var currentAppState: AppState
    var body: some View {
        VStack {
            Text("You are in the second view")
            Button("ChangeView") {
                currentAppState.currentView = AppViews.content
            }
        }
        .padding()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
