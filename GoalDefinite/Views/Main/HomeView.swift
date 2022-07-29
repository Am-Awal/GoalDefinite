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
    @StateObject var goalsVM = GoalsViewModel()
    @Namespace var namespace
    @State var show = false
    @State var selectedID = UUID()
//    @State var selectedID = ""
    @State var showStatusBar = true
    @State var showGoal = false
    @State var selectedIndex = 0
    @AppStorage("userID") var userID = ""
    @EnvironmentObject var model: Model
    @AppStorage("isLiteMode") var isLiteMode = true
        
    
    var body: some View {
        ZStack {
            ScrollView {
                scrollDetection
                
                Text("priorities".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                featured
                
                Text("goals".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    } else {
//                        ForEach(goals) { goal in
                        ForEach(goalsVM.fetchedGoals, id: \.goalID) { goal in
                            Rectangle()
                                .fill(.white)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                .opacity(0.3)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavBar(title: "Goal Definite", hasScrolled: $hasScrolled)
            )
//            .overlay(
//                AddGoal()
//            )
            
            if show {
                detail
            }
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
        
    }
    
    var scrollDetection: some View{
        GeometryReader{ proxy in
//                Text("\(proxy.frame(in: .named("scroll")).minY)")
            
            Color.clear.preference(key: ScrollPreferenceKey.self,
                value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0{
                    hasScrolled = true
                } else { hasScrolled = false
                    
                }
            }
        })

    }
    
    var featured: some View {
        TabView {
            ForEach(Array(featuredGoals.enumerated()), id: \.offset) { index, goal in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(goal: goal, namespace: namespace)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3) , radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX) / 40)
                        .onTapGesture {
                            showGoal = true
                            selectedIndex = index
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)

//                    Text("\(proxy.frame(in: .global).minX))")
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 275)
        .sheet(isPresented: $showGoal) {
            GoalView(namespace: namespace, goal: featuredGoals[selectedIndex], show: $showGoal)
        }
    }
    
    var cards: some View {
        ForEach(goalsVM.fetchedGoals) { goal in
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
    
//    var cards: some View {
//        ForEach(goals) { goal in
//            GoalItem(namespace: namespace, goal: goal, show: $show)
//                .onTapGesture {
//                    withAnimation(.openCard) {
//                        show.toggle()
//                        model.showDetail.toggle()
//                        showStatusBar = false
//                        selectedID = goal.id
//                    }
//                }
//        }
//    }
    
    var detail: some View {
        ForEach(goalsVM.fetchedGoals) { goal in
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
