//
//  GoalsViewModel.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/28/22.
//

import SwiftUI
import Firebase

final class GoalsViewModel: ObservableObject {
    @Published var fetchedGoals: [Goal] = []
    @AppStorage("userID") var userID = ""
    
    init() {
        getGoalData()
    }
    
    func getGoalData() {
        let db = Firestore.firestore()
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
                        
                        
                        let title = data["title"] as? String ?? ""
                        let id = document.documentID
                        let description = data["details"] as? String ?? ""
                        let startLine = data["startLine"] as? String ?? ""
                        let finishLine = data["deadLine"] as? String ?? ""
                        let goal = Goal(goalID: id, title: title, details: description, background: "", startLine: startLine, deadLine: finishLine, progress: 0.4)
                        
                        self.fetchedGoals.append(goal)
                    }
                }
                
            }
        }
        
    }

}
