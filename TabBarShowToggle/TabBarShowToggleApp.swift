//
//  TabBarShowToggleApp.swift
//  TabBarShowToggle
//
//  Created by Andres Felipe Ocampo Eljaiek on 20/02/2021.
//

import SwiftUI
import Firebase

@main
struct TabBarShowToggleApp: App {
    
    init() {
        self.prepareFirebaseRemoteConfig()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func prepareFirebaseRemoteConfig() {
        FirebaseApp.configure()
    }
}
