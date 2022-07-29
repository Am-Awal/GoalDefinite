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
    @State var fetchedMoves = []
    
    func getGoalData(goalIn: Goal) {
        let db = Firestore.firestore()
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").document(goalIn.goalID).collection("GoalMoves").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let data = document.data()
                        
                        
                        let title = data["title"] as? String ?? ""
                        let id = document.documentID
                        let description = data["details"] as? String ?? ""
                        let startLine = data["startLine"] as? String ?? ""
                        let finishLine = data["deadLine"] as? String ?? ""
                        let goal = Goal(goalID: id, title: title, details: description, background: "", startLine: startLine, deadLine: finishLine, progress: 0.4)
                        fetchedMoves.append(goal)
//                        fetchedMoves.append(goal)
                    }
                }
                
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                cover.onAppear {
                    goalID = goal.goalID
                }
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .coordinateSpace(name: "scroll")
            .onAppear{model.showDetail = true}
            .onDisappear { model.showDetail = false}
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            button
        }
        .overlay(
            AddMove()
        )
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }

    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
//                Image(goal.image)
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(goal.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                Image(goal.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(goal.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1: 1)
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(goal.id)", in: namespace)
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
            ForEach(Array(goalMoves.enumerated()), id: \.offset) { index, move in
                if index != 0 { Divider() }
                MoveRow(move: move)
                    .onTapGesture {
                        selectedIndex = index
                        showMove = true
                    }
            }
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .strokeStyle(conrnerRadius: 30)
            .padding(20)
            .sheet(isPresented: $showMove) {
                MoveView(move: goalMoves[selectedIndex])
            }
        }
        .padding(20)
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
            Text(goal.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(goal.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(goal.details)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(goal.id)", in: namespace)
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
                .matchedGeometryEffect(id: "blur\(goal.id)", in: namespace)
        )
        .offset(y: 250)
        .padding(20)

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

