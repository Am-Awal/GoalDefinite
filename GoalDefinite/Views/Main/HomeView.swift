//
//  HomeView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/1/22.
//

import SwiftUI
import Firebase


struct HomeView: View {
    @State var hasScrolled = false
//    @StateObject var goalsVM = GoalsViewModel()
    @State var fetchedGoals: [Goal] = []
    @State var fetchedGoalsFeatured: [Goal] = []
    @Namespace var namespace
    @Namespace var namespace0
    @State var show = false
    @State var selectedID = UUID()
//    @State var selectedID = ""
    @State var showStatusBar = true
    @State var showGoal = false
    @State var showFeats = false
    @State var selectedIndex = 0
    @AppStorage("userID") var userID = ""
    @EnvironmentObject var model: Model
    @AppStorage("isLiteMode") var isLiteMode = true
    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = .clear
       UITableView.appearance().backgroundColor = .clear
    }
    
    func getGoalData() async {
        
        let db = Firestore.firestore()
        
        db.collection("UserGoals").document(String(userID)).collection("Goals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let querySnapshot = querySnapshot {
                    fetchedGoalsFeatured = []
                    fetchedGoals = []
                    for document in querySnapshot.documents {
                        let data = document.data()
                        
                        
                        let title = data["title"] as? String ?? ""
                        let id = document.documentID
                        let has_goal = fetchedGoals.contains(where: { $0.id == UUID(uuidString: id) }) // Returns true

                        if !has_goal {
                            let description = data["details"] as? String ?? ""
                            
//                            let startLine: Date = timestamp.dateValue()
                            
                            let startLine = (data["beginning"] as? Timestamp)?.dateValue() ?? Date()
                            let finishLine = (data["deadLine"] as? Timestamp)?.dateValue() ?? Date()
                            
                            let goal = Goal(id: UUID(uuidString: id)!, title: title, details: description, background: "", startLine: startLine, deadLine: finishLine, progress: 0.4)
                        
                        fetchedGoals.append(goal)
                        fetchedGoalsFeatured.append(goal)
                        }
                    }
                }
                
            }
        }
        
    }
    
    
        
    
    var body: some View {
        
        ZStack {
            
//            ScrollView {
            
                List {

                    scrollDetection
//                List{
                    Text("priorities".uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 20)
                        .listRowSeparator(.hidden)
                    
                    if !showFeats{
                        featured
                    }
                    
                    Text("goals".uppercased())
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 20)
                        .listRowSeparator(.hidden)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                        if !show {
                            cards
                        } else {
                            //                        ForEach(goals) { goal in
                            //                        ForEach(goalsVM.fetchedGoals, id: \.goalID) { goal in
                            ForEach(fetchedGoals, id: \.id) { goal in
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 300)
                                    .cornerRadius(30)
                                    .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                    .opacity(0.3)
                                    .padding(.horizontal, 30)
                            }
                        }
                    } //close LazyVGrid
//                    .padding(.horizontal, 20)

                }// close list
                .coordinateSpace(name: "scroll")
                .safeAreaInset(edge: .top, content: {
//                    Color.clear.frame(height: 70)
//                    Color.clear.frame(height: 40)
                    Color.clear.frame(height: 40)

                })
                .overlay(
                    NavBar(title: "Goal Definite", hasScrolled: $hasScrolled)
                )
                .overlay(
                    AddGoal()
                        
                )
                .task {
                    await getGoalData()
                }
                .refreshable {
                    await getGoalData()
                }
                
                if show {
                    detail
                }
                if showFeats{
                    detailFeats
                }
                
            // end of ZStack
            }
            .statusBar(hidden: !showStatusBar)
            .onChange(of: show) { newValue in
                withAnimation(.closeCard) {
                    if newValue {
                        showStatusBar = false
                    } else {
                        showStatusBar = true
                    } // end of else
                } // end of with Animation
            } // end of onChange
            .onChange(of: showFeats) { newValue in
                withAnimation(.closeCard) {
                    if newValue {
                        showStatusBar = false
                    } else {
                        showStatusBar = true
                    } // end of else
                } // end of with Animation
            } // end of onChange
//        }
        
        
    } // end of body
    
    var scrollDetection: some View{
        GeometryReader{ proxy in
//                Text("\(proxy.frame(in: .named("scroll")).minY)")
            
            Color.clear.preference(key: ScrollPreferenceKey.self,
                                   value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 70{
                    hasScrolled = true
                } else { hasScrolled = false
                    
                }
            }
        })

    }
    
    var featured: some View {
        TabView {
//            ForEach(Array(featuredGoals.enumerated()), id: \.offset) { index, goal in
            ForEach(fetchedGoalsFeatured) {goal in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX - 40.0
                    
                    let rotVal = minX / (-10)
                    FeaturedItem(goal: goal, namespace0: namespace0, show: $showFeats)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .rotation3DEffect(.degrees(rotVal), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3) , radius: 20, x: 0, y: 10)
                        .blur(radius: abs(minX) / 40)
                        .onTapGesture {
                                showFeats.toggle()
//                            show.toggle()
//                                showGoal = true
                                model.showDetail.toggle()
                                showStatusBar = false
//                                selectedIndex = index
                                selectedID = goal.id
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)

//                    Text("\(proxy.frame(in: .global).minX))")
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 275)
//        .sheet(isPresented: $showGoal) {
////            GoalView(namespace: namespace, goal: featuredGoals[selectedIndex], show: $showGoal)
//            GoalView(namespace: namespace, goal: fetchedGoalsFeatured[selectedIndex], show: $showGoal)
//                .zIndex(1)
//                .transition(.asymmetric(
//                insertion: .opacity.animation(.easeInOut(duration: 0.1)),
//                removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
//        }
    }
    
    var cards: some View {
//        ForEach(goalsVM.fetchedGoals) { goal in
            ForEach(fetchedGoals) { goal in
            GoalItem(namespace: namespace, goal: goal, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = goal.id
                    }
                }
        }
    }
    var detailFeats: some View {
        ForEach(fetchedGoalsFeatured) { goal in
            if goal.id == selectedID {
                GoalView(namespace: namespace0, goal: goal, show: $showFeats)
//                GoalView(namespace: namespace0, goal: featuredGoals[selectedIndex], show: $showFeats)
                    .zIndex(1)
                    .transition(.asymmetric(
                    insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
//
        }
    }
    var detail: some View {
        ForEach(fetchedGoals) { goal in
            if goal.id == selectedID {
                GoalView(namespace: namespace, goal: goal, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                    insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
            
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        HomeView()
    }
}
