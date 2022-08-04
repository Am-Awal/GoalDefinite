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
    @State var deadLine = Date()
    @State var startLine = Date()
    @State var progress = 0
    @Environment(\.dismiss) var dismiss
    @AppStorage("userID") var userID = ""
    @AppStorage("goalID") var goalID = ""
    
    @EnvironmentObject var model: Model    
    func addGoalData() {
        if (title != ""){
            let db = Firestore.firestore()
            //        let dateFormatter = DateFormatter()
            //        dateFormatter.dateFormat = "yyyy-MM-dd hhZ"
            //
            //        // convert data to firestore DateAndHour type
            //        let startDateString = dateFormatter.string(from: startLine)
            //        let deadLineString = dateFormatter.string(from: deadLine)
            let startLineData = Timestamp(date: startLine)
            let deadLineData = Timestamp(date: deadLine)
            
            //        let startLineData : [String: Any] = ["timestamp" : startDateString]
            //        let deadLineData : [String: Any] = ["timestamp" : deadLineString]
            
            let goal = Goal(id: UUID(),title: title, details: details, background: "", startLine: startLine, deadLine: deadLine, progress: 0)
            let goalID = goal.id
            
            let docRef = db.collection("UserGoals").document(String(userID)).collection("Goals").document("\(goalID)")
            
            docRef.setData(["title": goal.title, "details": goal.details, "background": "", "beginning": startLineData, "deadLine": deadLineData, "progress": 0]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        else {return}
    }
    
    var body: some View {
//        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Text("Specify Goal")
                        .font(.largeTitle).bold()
                        .padding(0)
                    Divider()
                    
                    Group {
                        Section{
//                            Text("The Endgame... a.k.a The Target")
//                                .padding()
                            TextField("The Endgame... a.k.a The Target", text: $title)
                                .inputStyle(icon: "target")
                                .disableAutocorrection(true)
                            Rectangle().frame(height: 1)
                                .padding(.horizontal, 20).foregroundColor(.black)
                        }
                        
//                        Section {
////                            Text("Details/comments about the goal")
////                                .padding()
//                            TextField("Details/comments about the goal", text: $details)
//                                .inputStyle(icon: "text.justify.left")
//                                .disableAutocorrection(true)
//                            Rectangle().frame(height: 1)
//                                .padding(.horizontal, 20).foregroundColor(.black)
//                        }
                        
                        Spacer()
                        Text("Specify Time Bound")
                            .font(.title3).bold()
                            .padding(.vertical, 30)
                            .padding(0)
                        Divider()
                        
                        Section {
//                            Text("Finish Line")
//                                .padding()
                            DatePicker(
                                "End",
                                selection: $deadLine,
                                displayedComponents: [.date, .hourAndMinute]
                            ).inputStyle(icon: "checkerboard.rectangle")
                                .textContentType(.dateTime)
                                .disableAutocorrection(true)
                            Rectangle().frame(height: 1)
                                .padding(.horizontal, 20).foregroundColor(.black)
                        }
                        
                        Section {
//                            Text("Beginning")
//                                .padding()
                            DatePicker(
                                "Start",
                                selection: $startLine,
                                displayedComponents: [.date, .hourAndMinute]
                            ).inputStyle(icon: "timer")
                            Rectangle().frame(height: 1)
                                .padding(.horizontal, 20).foregroundColor(.black)
                        }
                        
                        //                Spacer()
                        Button {
                            addGoalData()
                            startLine = Date()
                            deadLine = Date()
                            details = ""
                            title = ""
                            
                            dismiss()
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
//        }
    }
    
}


struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView()
    }
}
