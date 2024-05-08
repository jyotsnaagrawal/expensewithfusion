import SwiftUI
import FirebaseFirestore

struct Group {
    var name: String
    var persons: [String]
}

struct ExpenseSplitView: View {
    @State private var groupName = ""
    @State private var newPersonName = ""
    @State private var selectedPersons = [String]()
    @State private var splitAmount = ""
    @State private var paidByIndex = 0
    @State private var owesByIndex = 0
    @State private var groups = [Group]()
    @State private var summary = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Group Name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    TextField("Add Person", text: $newPersonName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addPerson) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .padding()
                }
                
                List {
                    ForEach(groups, id: \.name) { group in
                        Section(header: Text(group.name)) {
                            ForEach(group.persons, id: \.self) { person in
                                Button(action: {
                                    if !selectedPersons.contains(person) {
                                        selectedPersons.append(person)
                                    } else {
                                        selectedPersons.removeAll { $0 == person }
                                    }
                                }) {
                                    HStack {
                                        Text(person)
                                        Spacer()
                                        if selectedPersons.contains(person) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                Picker("Paid By", selection: $paidByIndex) {
                    ForEach(0..<selectedPersons.count, id: \.self) { index in
                        Text(selectedPersons[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Picker("Owes By", selection: $owesByIndex) {
                    ForEach(0..<selectedPersons.count, id: \.self) { index in
                        Text(selectedPersons[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Split Amount", text: $splitAmount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Button(action: addSplit) {
                    Text("Add Split")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
                
                Text(summary)
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
            .navigationBarTitle("Expense Split")
            .padding()
        }
        .onAppear(perform: fetchData)
    }
    
    private func addPerson() {
        guard !newPersonName.isEmpty else { return }
        if let index = groups.firstIndex(where: { $0.name == groupName }) {
            groups[index].persons.append(newPersonName)
        } else {
            groups.append(Group(name: groupName, persons: [newPersonName]))
        }
        newPersonName = ""
    }
    
    private func addSplit() {
        guard let amount = Double(splitAmount) else { return }
        let paidBy = selectedPersons[paidByIndex]
        let owesBy = selectedPersons[owesByIndex]
        // Add logic to store the split data in Firebase Firestore
        let db = Firestore.firestore()
        let splitData: [String: Any] = [
            "groupName": groupName,
            "paidBy": paidBy,
            "owesBy": owesBy,
            "splitAmount": amount
        ]
        db.collection("split_bills").addDocument(data: splitData) { error in
            if let error = error {
                print("Error adding split bill: \(error.localizedDescription)")
            } else {
                print("Split bill added successfully")
                summary = "Split bill added: \(amount) paid by \(paidBy), owes \(owesBy)"
            }
        }
        // Clear fields after adding split
        groupName = ""
        selectedPersons = []
        splitAmount = ""
    }
    
    private func fetchData() {
        // Fetch data from Firebase Firestore and populate the 'groups' array
        let db = Firestore.firestore()
        db.collection("groups").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            groups = documents.compactMap { document in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let persons = data["persons"] as? [String] else {
                    return nil
                }
                return Group(name: name, persons: persons)
            }
        }
    }
}

struct ExpenseSplitView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSplitView()
    }
}
