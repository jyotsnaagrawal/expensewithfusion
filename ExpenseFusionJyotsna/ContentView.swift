//
//  ContentView.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 4/18/24.
//

import SwiftUI

struct ContentView: View {
    // State variable to control whether to show the login screen
    @State private var showLogin = false
    
    var body: some View {
        // ZStack is used to overlay views on top of each other
        ZStack {
            // Conditional statement to determine which view to display
            if !showLogin {
                // If showLogin is false, display the SplashScreenView
                SplashScreenView(isPresented: $showLogin)
            } else {
                // If showLogin is true, display the LoginView
                LoginView()
            }
        }
    }
}
