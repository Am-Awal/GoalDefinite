//
//  FeaturedItem.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/3/22.
//

import SwiftUI

struct FeaturedItem: View {
    var goal: Goal = goals[0]
    var namespace0: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
//            Image(goal.logo)
//                .resizable(resizingMode: .stretch)
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 26.0, height: 26.0)
//                .cornerRadius( 10)
//                .padding(9)
//                .background(Color(UIColor.systemBackground).opacity(0.1), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
//                .strokeStyle(conrnerRadius: 16)
            Text(goal.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("Finish by \(goal.deadLine.formatted())".uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(goal.details)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading )
                .foregroundColor(.white)
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 20)
        .frame(height: 200.0)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .blur(radius: 20)
//                .matchedGeometryEffect(id: "Blur\(goal.id)", in: namespace0)
        )
        .foregroundStyle(.white)
        .background(.linearGradient(colors: [.black, .black, .black], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
//            .padding(20)
//            .matchedGeometryEffect(id: "Image\(goal.id)", in: namespace0)
        .strokeStyle(conrnerRadius: 30)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .cornerRadius(20)
            .mask(RoundedRectangle(cornerRadius: 30,style: .continuous).opacity(0.79))
        .strokeStyle()
//        .padding(.horizontal, 20)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    @Namespace static var namespace0
    static var previews: some View {
        FeaturedItem(namespace0: namespace0, show: .constant(true))
    }
}
