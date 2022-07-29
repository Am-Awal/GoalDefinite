//
//  AddGoal.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/7/22.
//

import SwiftUI

struct AddGoal: View {
//    @Binding var hasScrolled: Bool
    @State var showAdd = false
    @State var showAccount = false
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
    @StateObject var goalsVM = GoalsViewModel()
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(0)
            
                Button {
                    showAdd = true
                } label: {
                    Image(systemName: "plus.app")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36 )
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeStyle(conrnerRadius: 14)
                }
                .sheet(isPresented: $showAdd) {
                    AddGoalView()
                }
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
    }
}
