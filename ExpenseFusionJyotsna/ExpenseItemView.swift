//
//  ExpenseItemView.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 5/7/24.
//

import SwiftUI

struct ExpenseItemView: View {
    let expense: Expense
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Expense Name: \(expense.name)")
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
