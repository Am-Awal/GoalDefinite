//
//  Goal.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct Goal: Identifiable {
    
    let id: UUID
        var title: String
    var details: String
    var background: String
    var startLine: Date
    var deadLine: Date
    var progress: CGFloat
}


var featuredGoals = [
    Goal(id: UUID(), title: "Dope and Body", details: "Workout 3x a week", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Make cigars important", details: "Smoke once per week at most", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Early Birld", details: "Be in bed by 11 each night so that you can awake up at 4:30 AM each day", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Strong ties", details: "Call one important person a day.", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
]

var goals = [
    Goal(id: UUID(), title: "Dope and Body", details: "Workout 3x a week", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Make cigars important", details: "Smoke once per week at most", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Early Birld", details: "Be in bed by 11 each night so that you can awake up at 4:30 AM each day", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
    
    Goal(id: UUID(), title: "Strong ties", details: "Call one important person a day.", background: "Black", startLine: Date(), deadLine: Date(), progress: 0.0),
]
