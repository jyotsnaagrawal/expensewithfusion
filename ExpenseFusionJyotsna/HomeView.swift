import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @ObservedObject var expenseTrackerViewModel = ExpenseTrackerViewModel()
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                Text("Expense Summary")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Display expense summary cards
                ForEach(expenseTrackerViewModel.expenses) { expense in
                    ExpenseSummaryCard(expense: expense)
                }
                
                Text("Split Bills Summary")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Split bills summary cards - Placeholder data
                SplitBillsSummaryCard(groupName: "Trip Expenses", amountOwed: "$80")
                SplitBillsSummaryCard(groupName: "House Rent", amountOwed: "$200")
                SplitBillsSummaryCard(groupName: "Utility Bills", amountOwed: "$50")
            }
            .padding()
            .onAppear {
                // Fetch expense summary data for the current user when the view appears
                if let currentUser = Auth.auth().currentUser {
                    let currentUserID = currentUser.uid
                    expenseTrackerViewModel.fetchExpenses(forUserID: currentUserID)
                } else {
                    // Handle the case where there's no current user signed in
                    // You may want to show a login screen or handle it differently based on your app's requirements
                }

            }

        }
    }
}

struct ExpenseSummaryCard: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(expense.name)
                    .font(.headline)
                Text("Amount: \(expense.amount)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Text("Date: \(formattedDate)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                Text("Tax Deductible: \(expense.taxDeductible ? "Yes" : "No")")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: expense.date)
    }
}

struct SplitBillsSummaryCard: View {
    let groupName: String
    let amountOwed: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(groupName)
                    .font(.headline)
                Text("Amount Owed: \(amountOwed)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
