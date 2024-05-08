//
//  Expense.swift
//  ExpenseFusionJyotsna
//
//  Created by student on 5/7/24.
//

import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase
import Foundation

struct Expense: Identifiable, Codable {
    @DocumentID var id: String?
    var userID: String // Add this property
    var name: String
    var amount: Double
    var date: Date
    var taxDeductible: Bool
}
