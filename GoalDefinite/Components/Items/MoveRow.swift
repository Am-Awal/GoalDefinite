//
//  MoveRow.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI

struct MoveRow: View {
    var move: GoalMove = goalMoves[0]
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
                Text(String(move.rank))
                    .fontWeight(.semibold)
                Text(move.description)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
//                ProgressView(value: move.progress)
//                    .accentColor(.white)
//                    .frame(maxWidth: 132)
            }
        }
        .padding(20)
            
    }
}

struct MoveRow_Previews: PreviewProvider {
    static var previews: some View {
        MoveRow()
    }
}
