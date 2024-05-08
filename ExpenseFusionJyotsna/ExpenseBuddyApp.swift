import SwiftUI

struct ExpenseBuddyAppView: View {
    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.brown, Color.white]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Welcome to Expense Fusion")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 50)
                        
                        Image("1") //
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 24.0, bottom: 30.0, trailing: 50.0))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 200)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 5)
                            )
                            .padding(.bottom, 50)
                        
                        NavigationLink(destination: GroupWindowView()) {
                            LargeButtonView(title: "Create New Group", backgroundColor: LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                    Color(red: 185/255, green: 142/255, blue: 28/255),
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ), foregroundColor: .black)
                        }

                        NavigationLink(destination: ManageGroupView()) {
                            LargeButtonView(title: "Manage Groups", backgroundColor: LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                    Color(red: 185/255, green: 142/255, blue: 28/255),
                                    Color(red: 212/255, green: 175/255, blue: 55/255),
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ), foregroundColor: .black)
                        }

                        
                        Spacer()
                    }
                    .padding()
                }
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Split Bills")
            }
            
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            NavigationView {
                ExpenseTrackerView()
            }
            
            .tabItem {
                Image(systemName: "chart.pie.fill")
                Text("Expense Tracker")
            }

        }
    }
}

struct LargeButtonView: View {
    let title: String
    let backgroundColor: LinearGradient // Change the background color type to LinearGradient
    let foregroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor) // Use LinearGradient for background color
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            .padding(.bottom, 20)
    }
}

struct ExpenseBuddyAppView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseBuddyAppView()
    }
}
