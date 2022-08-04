//
//  GoalItem.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/3/22.
//

import SwiftUI

struct GoalItem: View {
    var namespace: Namespace.ID
    var goal: Goal = goals[0]
    @Binding var show: Bool
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(goal.title)
                    .font(.title.weight(.bold))
//                    .matchedGeometryEffect(id: "title\(goal.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    VStack{
                        Text("Deadline:".uppercased())
                        .font(.footnote.weight(.semibold))
//                        .matchedGeometryEffect(id: "finishLine\(goal.id)", in: namespace)
                    Text("\(goal.deadLine.formatted())".uppercased())
                    .font(.footnote.weight(.semibold))
//                    .matchedGeometryEffect(id: "deadLine\(goal.id)", in: namespace)
                    }
                    Spacer()
                    VStack {
                        Text("Beginning:".uppercased())
                        .font(.footnote.weight(.semibold))
//                        .matchedGeometryEffect(id: "beginning\(goal.id)", in: namespace)
                    Text("\(goal.startLine.formatted())".uppercased())
                    .font(.footnote.weight(.semibold))
//                    .matchedGeometryEffect(id: "startLine\(goal.id)", in: namespace)
                }
                }
//                Text(goal.details)
//                    .font(.footnote)
//                    .matchedGeometryEffect(id: "text\(goal.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .blur(radius: 20)
//                    .matchedGeometryEffect(id: "blur\(goal.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(.linearGradient(colors: [.black, .black, .black], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.vertical, 20)
//            .matchedGeometryEffect(id: "image\(goal.id)", in: namespace)
        .strokeStyle(conrnerRadius: 20)
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .matchedGeometryEffect(id: "mask\(goal.id)", in: namespace)
        )
        .frame(height: 220)
    }
}

struct GoalItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        GoalItem(namespace: namespace, show: .constant(true))
    }
}
