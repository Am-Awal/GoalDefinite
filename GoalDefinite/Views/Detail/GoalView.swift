//
//  GoalView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI
import Firebase

struct GoalView: View {
    var namespace: Namespace.ID
    var goal: Goal = goals[0]
    
    @Binding var show: Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDraggable = true
    @State var showMove = false
    @AppStorage("userID") var userID = ""
    @AppStorage("goalID") var goalID = ""
    @State var selectedIndex = 0
    @State var fetchedMoves: [GoalMove] = []
    @State private var goalTitle: String = ""
//    @FocusState private var titleFieldIsFocused: Bool = false
//    @State private var titleFieldIsFocused: Bool = false
    @State var tmpTitle = ""
        
    func deleteGoalData(goalIn: String) {
        let db = Firestore.firestore()
        
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").document(goalIn).delete() { err in
            if let err = err {
              print("Error removing document: \(err)")
            } else {
              print("Document successfully removed!")
            }
        }
        
    }
    
    func addGoalData() {
        if (goalTitle != ""){
            
            tmpTitle = goalTitle
            let db = Firestore.firestore()
            
            let startLineData = Timestamp(date: goal.startLine)
            let deadLineData = Timestamp(date: goal.deadLine)
            
            let goal = Goal(id: goal.id, title: goalTitle,details:  goal.details, background: "", startLine: goal.startLine, deadLine: goal.deadLine, progress: 0)
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
        else { goalTitle = tmpTitle}
    }
    
    func getMoveData(goalIn: Goal) async {
        let db = Firestore.firestore()
        if (goalTitle == "") {
            await HomeView().getGoalData()
            
            goalTitle = tmpTitle
            return
        }
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").document("\(goalIn.id)").collection("GoalMoves").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    fetchedMoves = []
                    for document in querySnapshot.documents {
                        
                        let data = document.data()
                        
                        let id = document.documentID
                        let has_move = fetchedMoves.contains(where: { $0.id == UUID(uuidString: id) }) // Returns bool
                        if !has_move {
                            let description = data["description"] as? String ?? ""
                            let startLine = (data["executionStart"] as? Timestamp)?.dateValue() ?? Date()
                            let finishLine = (data["executionEnd"] as? Timestamp)?.dateValue() ?? Date()
                            let goalMove = GoalMove(id: UUID(uuidString: id)!, description: description, executionStart: startLine, executionEnd: finishLine)
                            fetchedMoves.append(goalMove)
                        }
                    }
                }
                
            }
        }
        
    }
    
    var body: some View {
        
//        List{
        List {
//            ScrollView {
            ZStack{
                VStack{
                cover
                    .onAppear {
                        goalID = "\(goal.id)"
                        goalTitle = goal.title
                        tmpTitle = goal.title
                }
                
                content
                    .offset(y: 30)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
//                    .listRowSeparator(.hidden)
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 20)], spacing: 20) {
//                    content
//                        .offset(y: 120)
////                        .padding(.bottom, 200)
//                        .opacity(appear[2] ? 1 : 0)
//                }
                
                
                
            }
            .coordinateSpace(name: "scroll")
            .onAppear{model.showDetail = true}
            .onDisappear { model.showDetail = false}
//            .background(Color("Background"))
//            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
//            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
//            .scaleEffect(viewState.width / -500 + 1)
//            .background(.black.opacity(viewState.width / 500))
//            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
//            button
//        }
        }
        .listRowBackground(Color.clear)

//        .ignoresSafeArea()
//        .task {
//            await getMoveData(goalIn: goal)
//        }
//        .refreshable {
//            await getMoveData(goalIn: goal)
        }
        .coordinateSpace(name: "scroll")
        .background(.ultraThinMaterial)
//        .ignoresSafeArea()
        .overlay(
            HStack{
            AddMove()
            deleteButton
            }
        )
        .overlay(button)
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
//        }
        .task {
            await getMoveData(goalIn: goal)
        }
        .refreshable {
            await getMoveData(goalIn: goal)
        }
        .gesture(isDraggable ? drag : nil)
        
        
    } // end body view

    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
//            .background(
//                Image(goal.image)
//                Image("")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(20)
//                    .frame(maxWidth: 500)
//                    .matchedGeometryEffect(id: "image\(goal.id)", in: namespace)
//                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
//            )
//            .background(
//                Image(goal.background)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
////                    .matchedGeometryEffect(id: "background\(goal.id)", in: namespace)
//                    .offset(y: scrollY > 0 ? -scrollY : 0)
//                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1: 1)
//                    .blur(radius: scrollY / 10)
//            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
//                    .matchedGeometryEffect(id: "mask\(goal.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
        }
        .frame(height: 500)
    }
    

    var content: some View {
        VStack(alignment: .leading) {
            ForEach(Array(fetchedMoves.enumerated()), id: \.offset) { index, move in
                if index != 0 { Divider() }
                MoveRow(move: move, namespace: namespace)
                    .onTapGesture {
                        selectedIndex = index
                        showMove = true
                    }
            }
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(conrnerRadius: 30)
//            .padding(20)
            .sheet(isPresented: $showMove) {
                MoveView(move: fetchedMoves[selectedIndex])
            }
        }
//        .padding(20)
    }
    
    var deleteButton: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(0)
            Button {
                deleteGoalData(goalIn: goalID)
                withAnimation(.closeCard){
                    show.toggle()
                    model.showDetail.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .frame(width: 36, height: 36 )
                    .foregroundColor(Color.red)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .strokeStyle(conrnerRadius: 14)
            }
            .frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard){
                show.toggle()
                model.showDetail.toggle()
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
            TextField(goalTitle, text: $goalTitle)
                .font(.largeTitle.weight(.bold))
//                .matchedGeometryEffect(id: "title\(goal.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
//                .focused($titleFieldIsFocused)
                   .onSubmit {
                       addGoalData()
                   }
            Text(goal.details)
                .font(.footnote)
//                .matchedGeometryEffect(id: "text\(goal.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
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
            .opacity(appear[1] ? 1 : 0)
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                .matchedGeometryEffect(id: "blur\(goal.id)", in: namespace)
        )
        .offset(y: 100)
//        .padding(20)

    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged{ value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard){
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
        }
        .onEnded{ value in
            if viewState.width > 80 {
                close()
            } else {
                withAnimation(.closeCard){
                    viewState = .zero
                }
            }
        }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
            withAnimation(.closeCard.delay(0.3)){
                show.toggle()
                model.showDetail.toggle()
            }
        withAnimation(.closeCard){
            viewState = .zero
        }
        
        isDraggable = false
    }
}

struct GoalView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        GoalView(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}

