//
//  GradientButton.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/16/22.
//

import SwiftUI

struct GradientButton: View {
    @State private var angle = 0.0
    
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
    ]
    var buttonTitle: String
    var buttonAction: () -> Void
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            //                Text("**Create an account**")
            //                    .frame(maxWidth: .infinity)
            GeometryReader() { geometry in
                ZStack {
                    AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                        .blendMode(.overlay)
                        .blur(radius: 8)
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                                .frame(height: 50)
                                .frame(maxWidth: geometry.size.width - 16)
                                .blur(radius: 8.0)
                        )
                        .onAppear(){
                            withAnimation(.linear(duration: 7.0)) {
                                self.angle += 350
                            }
                        }
                    GradientText(text: buttonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            Color.white.opacity(0.8)
                        )
                        .background(
                            .ultraThinMaterial
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 2.0)
                                .blendMode(.normal)
                                .opacity(0.9)
                        )
                        .cornerRadius(16)
                }
            }
            //                .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
    }
}

//struct GradientButton_Previews: PreviewProvider {
//    static var previews: some View {
//        GradientButton()
//    }
//}
