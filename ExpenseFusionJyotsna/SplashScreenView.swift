//
//  SplashScreenView.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 4/18/24.
//

import SwiftUI

struct SplashScreenView: View {
    // Binding to control whether the splash screen is presented
    @Binding var isPresented: Bool
    
    // State variables for animation and opacity
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var systemImageOpacity = 0.0
    @State private var imageOpacity = 1.0
    @State private var opacity = 1.0
    
    var body: some View {
        // Main content wrapped in a ZStack
        ZStack {
            // Background color combination of white and black
            LinearGradient(gradient: Gradient(colors: [.brown, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Two images stacked on top of each other with animations
            ZStack {
                // First image with system symbol
                Image(systemName: "1")
                    .font(.system(size: 200))
                    .foregroundColor(.blue)
                    .opacity(systemImageOpacity)
                
                // Second image loaded from assets
                Image("1")
                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 24.077, bottom: 0.0, trailing: 78.0))
                    .aspectRatio(contentMode: .fill) // Adjust aspect ratio
                    .scaledToFit()
                    .opacity(imageOpacity)
                    .frame(width: 200, height: 700)
                    .clipShape(Circle()) // Make the image circular
                    
            }
            .scaleEffect(scale) // Apply scale effect to the entire ZStack
        }
        .opacity(opacity) // Overall opacity of the ZStack
        
        // Perform animations when the view appears
        .onAppear {
            // Scale animation to enlarge the images
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }
            
            // Delayed animation to shrink the images and fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeIn(duration: 1.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0 // Fade out the entire ZStack
                }
            }
            
            // Toggle the isPresented binding after a certain delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.20) {
                withAnimation(.easeIn(duration: 0.2)) {
                    isPresented.toggle() // Toggle the splash screen presentation
                }
            }
        }
    }
}
