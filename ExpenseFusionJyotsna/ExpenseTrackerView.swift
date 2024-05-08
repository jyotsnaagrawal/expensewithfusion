import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ExpenseTrackerView: View {
    @ObservedObject var expenseTrackerViewModel = ExpenseTrackerViewModel()
    @State private var expenseName = ""
    @State private var amount = ""
    @State private var expenseDate = Date()
    @State private var isTaxDeductible = false
    @State private var filterCriteria = ""
    @State private var currentUserID: String? // Make sure this is correctly set elsewhere in your code.

    var body: some View {
        VStack {
            // Check here if currentUserID is correctly set before using it.
            FilteredExpensesView(expenses: expenseTrackerViewModel.filteredExpenses(forUserID: currentUserID ?? ""), filterCriteria: $filterCriteria)
                .onAppear {
                    fetchCurrentUserID()
                    fetchExpenses()
                }
                .padding()

            // Check here if currentUserID is correctly set before using it.
            AddExpenseView(
                expenseName: $expenseName,
                amount: $amount,
                expenseDate: $expenseDate,
                isTaxDeductible: $isTaxDeductible,
                currentUserID: $currentUserID,
                addExpenseAction: addExpense
            )
                .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.6, green: 0.4, blue: 0.2)]), startPoint: .top, endPoint: .bottom))
    }

    private func fetchExpenses() {
        guard let userID = currentUserID else {
            print("User ID not available")
            return
        }
        expenseTrackerViewModel.fetchExpenses(forUserID: userID)
    }

    private func fetchCurrentUserID() {
        if let currentUser = Auth.auth().currentUser {
            self.currentUserID = currentUser.uid
        } else {
            print("User not authenticated")
            self.currentUserID = nil
        }
    }

    private func addExpense() {
        guard let amount = Double(amount), let currentUserID = currentUserID else { return }

        // Assuming currentUserID is the ID of the current user
        let expense = Expense(id: UUID().uuidString, userID: currentUserID, name: expenseName, amount: amount, date: expenseDate, taxDeductible: isTaxDeductible)

        expenseTrackerViewModel.addExpense(expense)

        expenseName = ""
        self.amount = ""
        expenseDate = Date()
        isTaxDeductible = false
    }
}

struct ExpenseTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTrackerView()
    }
}
