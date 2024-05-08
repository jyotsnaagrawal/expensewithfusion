import SwiftUI
import FirebaseFirestore

struct ManageGroupView: View {
    @State private var selectedGroupName: String?
    @State private var groups: [String] = [] // Array to hold group names
    let db = Firestore.firestore()
    
    @State private var isRenameAlertPresented = false
    @State private var isDeleteAlertPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("MANAGE GROUP")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                if groups.isEmpty {
                    EmptyStateView()
                        .padding(.vertical)
                } else {
                    ListOfGroups(selectedGroupName: $selectedGroupName, groups: groups)
                        .padding(.vertical)
                        .background(Color(red: 40/40, green: 40/30, blue: 40/20)) // Darker background for the list
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        isRenameAlertPresented = true
                    }) {
                        Text("Rename Group")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(red: 212/255, green: 175/255, blue: 55/255))
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $isRenameAlertPresented) {
                        Alert(
                            title: Text("Rename Group"),
                            message: Text("Enter new name for the group"),
                            primaryButton: .default(Text("Rename")) {
                                if let groupName = selectedGroupName {
                                    renameGroup(groupName)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    Button(action: {
                        isDeleteAlertPresented = true
                    }) {
                        Text("Delete Group")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(red: 212/255, green: 175/255, blue: 55/255))
                            .cornerRadius(8)
                    }
                    .alert(isPresented: $isDeleteAlertPresented) {
                        Alert(
                            title: Text("Delete Group"),
                            message: Text("Are you sure you want to delete the group?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let groupName = selectedGroupName {
                                    deleteGroup(groupName)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .padding()
            .onAppear {
                fetchGroups()
            }
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
    
    private func fetchGroups() {
        db.collection("groups").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching groups: \(error)")
            } else {
                guard let documents = snapshot?.documents else { return }
                groups = documents.compactMap { $0["name"] as? String }
            }
        }
    }
    
    private func renameGroup(_ groupName: String) {
        // Implement group renaming logic here
        print("Renaming group: \(groupName)")
    }
    
    private func deleteGroup(_ groupName: String) {
        db.collection("groups").whereField("name", isEqualTo: groupName).getDocuments { snapshot, error in
            if let error = error {
                print("Error deleting group: \(error)")
            } else {
                guard let documents = snapshot?.documents else { return }
                for document in documents {
                    document.reference.delete()
                }
                groups.removeAll { $0 == groupName }
                selectedGroupName = nil
                print("Deleting group: \(groupName)")
            }
        }
    }
}

struct ListOfGroups: View {
    @Binding var selectedGroupName: String?
    var groups: [String]
    
    var body: some View {
        LazyVStack(spacing: 10) {
            ForEach(groups, id: \.self) { group in
                GroupRow(name: group, isSelected: selectedGroupName == group)
                    .onTapGesture {
                        selectedGroupName = group
                    }
            }
        }
        .padding()
    }
}

struct GroupRow: View {
    var name: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(isSelected ? .white : .primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(isSelected ? Color(red: 212/255, green: 175/255, blue: 55/255) : Color.clear) // Golden background color when selected
        .cornerRadius(10)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("No groups found.")
                .foregroundColor(.white)
            Text("Create a new group to get started.")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(red: 212/255, green: 175/255, blue: 55/255))
        .cornerRadius(15)
    }
}

struct ManageGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ManageGroupView()
    }
}
