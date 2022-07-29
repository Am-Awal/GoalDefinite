//
//  ValueMetric.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/28/22.
//

import SwiftUI

struct ValueMetric: Identifiable{
    let id = UUID()
    var confidence: CGFloat
    var provenTrackRecord: CGFloat
    var relevance: CGFloat
}

