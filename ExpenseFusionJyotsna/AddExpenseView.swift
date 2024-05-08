//
//  AddExpenseView.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 5/7/24.
//
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
            
            Button("Add Expense") {
                addExpenseAction()
            }
            .padding()
        }
        .padding()
    }
}
