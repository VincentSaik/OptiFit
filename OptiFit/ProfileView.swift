//
//  ProfileView.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("password") private var storedPassword: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Hello, \(storedUsername)")
                    .font(.title2)
                    .fontWeight(.semibold)

                Button("Log Out") {
                    isLoggedIn = false
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)

                Button("Reset All Data") {
                    storedUsername = ""
                    storedPassword = ""
                    isLoggedIn = false
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}


