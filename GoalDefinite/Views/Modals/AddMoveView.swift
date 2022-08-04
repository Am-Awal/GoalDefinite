//
//  SwiftUIView.swift
//  MoveDefinite
//
//  Created by Awal Amadou on 7/28/22.
//

import SwiftUI
import Firebase

struct AddMoveView: View {
//    enum Field: Hashable {
//        case title
//        case details
//        case startLine
//        case deadLine
//        case progress
//    }
    
    @State var description = ""
    @State var executionStart = Date()
    @State var executionEnd = Date()
    @AppStorage("userID") var userID = ""
    @AppStorage("goalID") var goalID = ""
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    func addMoveData() {
        let db = Firestore.firestore()
        let move = GoalMove(id: UUID(), description: description, executionStart: executionStart, executionEnd: executionEnd)
        let moveID = move.id
        let executionStartData = Timestamp(date: executionStart)
        let dexecutionEndData = Timestamp(date: executionEnd)
        
        let docRef = db.collection("UserGoals").document(String(userID)).collection("Goals").document(String(goalID)).collection("GoalMoves").document("\(moveID)")
        
        docRef.setData(["description": move.description, "background": "", "executionStart": executionStartData, "executionEnd": dexecutionEndData]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Add Move")
                .font(.largeTitle).bold()
                .padding(0)
            Divider()
            
            Group {
                
                Section {
//                    Text("")
//                        .padding()
                    TextField("Details/comments about the move", text: $description)
                        .inputStyle(icon: "text.justify.left")
                        .disableAutocorrection(true)
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                Section {
                    DatePicker(
                        "End",
                        selection: $executionEnd,
                        displayedComponents: [.date, .hourAndMinute]
                    ).inputStyle(icon: "checkerboard.rectangle")
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                Section {
                    DatePicker(
                        "Start",
                        selection: $executionStart,
                        displayedComponents: [.date, .hourAndMinute]
                    ).inputStyle(icon: "timer")
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                //                Spacer()
                Button {
                    addMoveData()
                    dismiss()
                } label: {
                    Text("Add").foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    
                }
                .font(.headline)
                .blendMode(.overlay)
                //                .buttonStyle(.angular)
//                .tint(.accentColor)
                .controlSize(.large)
                .frame(height: 50)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color(.black).opacity(0.6), radius: 20, x: 0, y: 10)
                .padding(20)
                
                Divider()
                
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .coordinateSpace(name: "container")
        .strokeStyle(conrnerRadius: 30)
    }
    
}


struct AddMoveView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoveView()
    }
}
