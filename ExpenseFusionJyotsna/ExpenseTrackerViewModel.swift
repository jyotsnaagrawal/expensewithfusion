import Foundation
import FirebaseFirestore
import FirebaseAuth

class ExpenseTrackerViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    
    func fetchExpenses(forUserID userID: String?) {
        guard let userID = userID else {
            print("User ID is nil")
            return
        }
        
        let db = Firestore.firestore()
        let expensesRef = db.collection("expenses")
        
        // Construct the query with the filter
        let query = expensesRef.whereField("userID", isEqualTo: userID)
        
        // Fetch documents based on the query
        query.getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching expenses: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Process fetched documents
            self.expenses = documents.compactMap { queryDocumentSnapshot in
                do {
                    let expense = try queryDocumentSnapshot.data(as: Expense.self)
                    return expense
                } catch {
                    print("Error decoding expense: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }
    
    
    
    
    
    func addExpense(_ expense: Expense) {
        let db = Firestore.firestore()
        do {
            _ = try db.collection("expenses").addDocument(from: expense)
        } catch {
            print("Error adding expense to Firestore: \(error.localizedDescription)")
        }
    }
    
    
    func filteredExpenses(forUserID userID: String?) -> [Expense] {
        guard let userID = userID else { return [] }
        
        var filteredExpenses: [Expense] = []
        for expense in expenses {
            if expense.userID == userID {
                filteredExpenses.append(expense)
            }
        }
        
        return filteredExpenses
    }

}
