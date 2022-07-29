//
//  AddGoalView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/7/22.
//

import SwiftUI
import Firebase

struct AddGoalView: View {
    enum Field: Hashable {
        case title
        case details
        case startLine
        case deadLine
        case progress
    }
    
    @State var title = ""
    @State var details = ""
    @State var deadLine = ""
    @State var startLine = ""
    @State var progress = 0
    @AppStorage("userID") var userID = ""
    @AppStorage("goalID") var goalID = ""
    
    @EnvironmentObject var model: Model    
    func addGoalData() {
        let db = Firestore.firestore()
        let goal = Goal(goalID: "",title: title, details: details, background: "", startLine: startLine, deadLine: deadLine, progress: 0)
        let goalID = goal.id
//        goal.goalID = "\(goalID)"

        let docRef = db.collection("UserGoals").document(String(userID)).collection("Goals").document("\(goalID)")
        
        docRef.setData(["title": goal.title, "details": goal.details, "background": "", "deadLine": goal.deadLine, "progress": 0]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    var body: some View {
        ScrollView{
        VStack(alignment: .leading, spacing: 10) {
            Text("Define Goal")
                .font(.largeTitle).bold()
                .padding(0)
            Divider()
            
            Group {
                Section{
                    Text("The Endgame... a.k.a The Target")
                        .padding()
                    TextField("", text: $title)
                        .inputStyle(icon: "target")
                        .disableAutocorrection(true)
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                Section {
                    Text("Details/comments about the goal")
                        .padding()
                    TextField("", text: $details)
                        .inputStyle(icon: "text.justify.left")
                        .disableAutocorrection(true)
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                Section {
                    Text("Finish Line")
                        .padding()
                    TextField("", text: $deadLine)
                        .inputStyle(icon: "clock.badge.checkmark")
                        .textContentType(.dateTime)
                        .disableAutocorrection(true)
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                Section {
                    Text("Beginning")
                        .padding()
                    TextField("", text: $startLine)
                        .inputStyle(icon: "clock")
                        .textContentType(.dateTime)
                        .disableAutocorrection(true)
                    Rectangle().frame(height: 1)
                        .padding(.horizontal, 20).foregroundColor(.black)
                }
                
                //                Spacer()
                Button {
                    addGoalData()
                    startLine = ""
                    deadLine = ""
                    details = ""
                    title = ""
                    
//                    dismiss()
                    //                    return
                } label: {
                    Text("Add").foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    
                }
                .font(.headline)
                .blendMode(.overlay)
//                                .buttonStyle(.angular)
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
    
}


struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView()
    }
}
