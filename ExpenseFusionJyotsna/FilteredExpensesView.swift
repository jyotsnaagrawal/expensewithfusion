//
//  FilteredExpensesView.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 5/7/24.
//
import SwiftUI

struct FilteredExpensesView: View {
    let expenses: [Expense]
    @Binding var filterCriteria: String
    
    var body: some View {
        VStack {
            TextField("Filter Expenses", text: $filterCriteria)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List {
                ForEach(expenses) { expense in
                    ExpenseItemView(expense: expense)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}
