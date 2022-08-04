//
//  MoveView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI
import Firebase

struct MoveView: View {
    var move: GoalMove = goalMoves[0]
    @EnvironmentObject var model: Model
    @AppStorage("currentMoveID") var currentMoveID = ""
    @AppStorage("userID") var userID = ""
    @AppStorage("goalID") var goalID = ""
    @Environment(\.dismiss) var dismiss

    
    func deleteMoveData(moveIn: String) {
        let db = Firestore.firestore()
        
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").document(goalID).collection("GoalMoves").document(moveIn).delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            } else {
              print("Document successfully removed!")
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            currentMoveID = "\(move.id)"
        }
        Button {
            deleteMoveData(moveIn: currentMoveID)
            dismiss()
        } label: {
            Label("Delete", systemImage: "xmark")
        }
        .tint(.red)

    }

    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
//            Image(move.image)
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(maxWidth: 500)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                .background(
//                    Image(move.background)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                )
                .mask(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                )
                .overlay(
                    overlayContent
                )
                .frame(height: 500)
            )
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
//            Text("SwiftUI is hands-down the best way for designers to take a first step into code. ")
//                .font(.title3).fontWeight(.medium)
            Text("This move")
                .font(.title).bold()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            
        }
        .padding(20)
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard){
                model.showDetail.toggle()
                dismiss()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight:  .infinity, alignment:  .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(move.description)
                .font(.footnote)
            Text("From \(move.executionStart.formatted()) to \(move.executionEnd.formatted())")
            Divider()
                .opacity(0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .strokeStyle(conrnerRadius: 18)
                Text("Taught by Pablo Picasso")
                    .font(.footnote)
            }
            .opacity(0)
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )
        .offset(y: 250)
        .padding(20)

    }
}

struct MoveView_Previews: PreviewProvider {
    static var previews: some View {
        MoveView()
    }
}
