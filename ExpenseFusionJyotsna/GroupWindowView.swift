import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct GroupWindowView: View {
    @State private var groupName: String = ""
    @Environment(\.presentationMode) var presentationMode
    let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack {
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 500) // Adjust image size as needed
                    .clipShape(Circle())
                    .padding()
                
                Text("Create New Group")
                    .font(.title)
                    .padding()
                
                TextField("Enter Group Name", text: $groupName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .padding(.horizontal)
                
                Button(action: {
                    saveGroupName()
                }) {
                    Text("Save")
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
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.brown, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
    func saveGroupName() {
        guard let currentUser = Auth.auth().currentUser else {
            // Handle user not logged in
            return
        }
        
        let groupData = [
            "name": groupName,
            "createdBy": currentUser.uid,
            // Add more fields as needed
        ]

        // Add group data to Firestore
        db.collection("groups").addDocument(data: groupData) { error in
            if let error = error {
                print("Error creating group: \(error)")
            } else {
                print("Group created successfully")
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
struct GroupWindowView_Previews: PreviewProvider {
    static var previews: some View {
        GroupWindowView()
    }
}
