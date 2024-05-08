import SwiftUI
import Firebase

struct CreateAccountView: View {
    @Binding var isPresented: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpButtonDisabled = true
    @State private var errorMessage: String?
    @State private var showLoginView = false
    
    var body: some View {
        NavigationView {
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
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.8)))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .foregroundColor(.black)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.8)))
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
                
                NavigationLink(
                    destination: LoginView(),
                    isActive: $showLoginView,
                    label: {
                        Button(action: {
                            signUp()
                        }) {
                            Text("Sign Up")
                                .font(.body)
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
                                .disabled(isSignUpButtonDisabled)
                        }
                    }
                )
                
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
            .onDisappear {
                isPresented.toggle()
            }
            .navigationBarHidden(true) // Hide navigation bar
        }
    }
    
    private func signUp() {
        // Password validation
        if password.count < 6 {
            errorMessage = "The password must be 6 characters long or more."
            return
        }
       
        
        Auth.auth().createUser(withEmail: self.username, password: self.password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
            } else {
                print("User created successfully")
                // If user is successfully created, navigate to login screen
                showLoginView = true
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView(isPresented: .constant(true))
    }
}
