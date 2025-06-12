//
//  LoginView.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("password") private var storedPassword: String = ""
    
    @State private var enteredUsername: String = ""
    @State private var enteredPassword: String = ""
    @State private var isSignUpMode: Bool = false
    @State private var showPassword: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            Text(isSignUpMode ? "Sign Up for OptiFit" : "Log In to OptiFit")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            TextField("Username", text: $enteredUsername)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            ZStack(alignment: .trailing) {
                Group {
                    if showPassword {
                        TextField("Password", text: $enteredPassword)
                    } else {
                        SecureField("Password", text: $enteredPassword)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button(action: {
                isSignUpMode ? handleSignUp() : handleLogin()
            }) {
                Text(isSignUpMode ? "Create Account" : "Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Button(action: {
                isSignUpMode.toggle()
                errorMessage = ""
                enteredUsername = ""
                enteredPassword = ""
            }) {
                Text(isSignUpMode ? "Have an account? Log in" : "Don't have an account? Sign up")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    // MARK: - Local Logic
    
    private func handleSignUp() {
        guard !enteredUsername.isEmpty && !enteredPassword.isEmpty else {
            errorMessage = "Username and password cannot be empty."
            return
        }
        storedUsername = enteredUsername
        storedPassword = enteredPassword
        isLoggedIn = true
    }

    private func handleLogin() {
        if enteredUsername == storedUsername && enteredPassword == storedPassword {
            isLoggedIn = true
        } else {
            errorMessage = "Incorrect username or password."
        }
    }
}


