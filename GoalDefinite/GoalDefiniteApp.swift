//
//  GoalDefiniteApp.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/1/22.
//

import SwiftUI
import Firebase

@main
struct GoalDefiniteApp: App {
    @StateObject var model = Model()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .preferredColorScheme(.light)
        }
    }
}
