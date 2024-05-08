import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginButtonDisabled = true
    @State private var errorMessage: String?
    @State private var isCreateAccountViewPresented = false // Add state variable for presenting CreateAccountView
    
    var body: some View {
        NavigationView { // Wrap the VStack in a NavigationView
            VStack {
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 200)
                    .padding(.bottom, 30)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 5)
                    )
                
                TextField("Username", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.9)))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .foregroundColor(.black)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.9)))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .foregroundColor(.black)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                }
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                    Color(red: 185/255, green: 142/255, blue: 28/255),
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .disabled(isLoginButtonDisabled)
                }
                .onReceive([self.username, self.password].publisher) { _ in
                    self.isLoginButtonDisabled = self.username.isEmpty || self.password.isEmpty
                }
                
                // Sign in with Apple button
                Button(action: {
                    // Handle sign in with Apple
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("Sign in with Apple")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.black)) // Use your primary color here
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 10)
                
                // Sign in with Google button
                Button(action: {
                    // Handle sign in with Google
                }) {
                    HStack {
                        Image("Google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("Sign in with Google")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue)) // Use your primary color here
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                    Button(action: {
                        // Toggle the state variable to present CreateAccountView
                        isCreateAccountViewPresented.toggle()
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isCreateAccountViewPresented) {
                        CreateAccountView(isPresented: $isCreateAccountViewPresented)
                    }
                }
                .padding(.top, 60)
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.brown, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: self.username, password: self.password) { authResult, error in
            if let error = error {
                self.errorMessage = self.errorMessage(for: error)
            } else {
                // User logged in successfully, navigate to ExpenseBuddyApp
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        window.rootViewController = UIHostingController(rootView: ExpenseBuddyAppView())
                    }
                }

            }
        }
    }

    private func errorMessage(for error: Error) -> String {
        switch (error as NSError).code {
        case AuthErrorCode.userNotFound.rawValue:
            return "User not found. Please check your email or sign up."
        case AuthErrorCode.wrongPassword.rawValue:
            return "Incorrect password. Please try again or reset your password."
        default:
            return "An error occurred. Please try again later."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
