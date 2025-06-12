//
//  OptiFitApp.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-10.
//

import SwiftUI

@main
struct OptiFitApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
