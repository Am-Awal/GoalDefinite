//
//  AddMove.swift
//  MoveDefinite
//
//  Created by Awal Amadou on 7/28/22.
//

import SwiftUI

struct AddMove: View {
//    @Binding var hasScrolled: Bool
    @State var showSearch = false
    @State var showAccount = false
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
//    @AppStorage("goalID") var goalID = ""
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(0)
            
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "plus")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36 )
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeStyle(conrnerRadius: 14)
                }
                .sheet(isPresented: $showSearch) {
                    AddMoveView()
                }
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct AddMove_Previews: PreviewProvider {
    static var previews: some View {
        AddMove()
    }
}

