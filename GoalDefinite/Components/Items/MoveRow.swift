//
//  MoveRow.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct MoveRow: View {
    var move: GoalMove = goalMoves[0]
    var namespace: Namespace.ID
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
//            Image(move.logo)
            Image("")
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
//                .overlay(CircularView(value: move.progress))
            VStack(alignment: .leading, spacing: 8) {
                Text(move.description)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.secondary)
                HStack{
//                    Text("Deadline: \(move.executionEnd)".uppercased())
                    Text("Deadline: \(move.executionEnd.formatted())")
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "deadLine\(move.id)", in: namespace)
                    
//                Text("Beginning: \(move.executionStart)".uppercased())
                    Text("Beginning: \(move.executionStart.formatted())")
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "startLine\(move.id)", in: namespace)
                }
//                ProgressView(value: move.progress)
//                    .accentColor(.white)
//                    .frame(maxWidth: 132)
            }
        }
        .padding(20)
            
    }
}

struct MoveRow_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        MoveRow(namespace: namespace)
            .environmentObject(Model())
    }
}
