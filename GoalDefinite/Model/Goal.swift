//
//  Goal.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct Goal: Identifiable {
    let id = UUID()
    
    var goalID: String
    var title: String
    var details: String
    var background: String
    var startLine: String
    var deadLine: String
    var progress: CGFloat
}


var featuredGoals = [
    Goal(goalID: "", title: "Dope and Body", details: "Workout 3x a week", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Make cigars important", details: "Smoke once per week at most", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Early Birld", details: "Be in bed by 11 each night so that you can awake up at 4:30 AM each day", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Strong ties", details: "Practice zumunci", background: "Black", startLine: "Call one important person a day.", deadLine: "Now", progress: 0.0),
]

var goals = [
    Goal(goalID: "", title: "Dope and Body", details: "Workout 3x a week", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Make cigars important", details: "Smoke once per week at most", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Early Birld", details: "Be in bed by 11 each night so that you can awake up at 4:30 AM each day", background: "Black", startLine: "Now", deadLine: "Now", progress: 0.0),
    
    Goal(goalID: "", title: "Strong ties", details: "Practice zumunci", background: "Black", startLine: "Call one important person a day.", deadLine: "Now", progress: 0.0),
]
