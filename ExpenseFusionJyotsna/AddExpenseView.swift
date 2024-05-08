import SwiftUI

struct AddExpenseView: View {
    @Binding var expenseName: String
    @Binding var amount: String
    @Binding var expenseDate: Date
    @Binding var isTaxDeductible: Bool
    @Binding var currentUserID: String?
    let addExpenseAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Expense Name", text: $expenseName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.horizontal)
            
            TextField("Amount", text: $amount)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.horizontal)
                .keyboardType(.decimalPad)
            
            DatePicker("Expense Date", selection: $expenseDate, displayedComponents: .date)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.horizontal)
            
            Toggle("Tax Deductible", isOn: $isTaxDeductible)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.horizontal)
            
            Button(action: addExpenseAction) {
                Text("Add Expense")
                    .foregroundColor(Color.black)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color(red: 0.83, green: 0.69, blue: 0.22))
            .cornerRadius(8)
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(red: 0.6, green: 0.4, blue: 0.2)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}
