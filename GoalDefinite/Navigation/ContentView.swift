//
//  ContentView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/3/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        if !isLogged{
            ModalView()
                .zIndex(1)
        }else {
            ZStack(alignment: .bottom) {
                
                switch selectedTab {
                case .home:
                    HomeView()
                    //                        .offset(y: 300)
                case .add:
                    AddGoalView()
                case .explore:
                    SearchView()
                case .notifications:
                    AccountView()
                }
                
                TabBar()
                    .offset(y: model.showDetail ? 200 : 0)
                
                if showModal {
                    ModalView()
                        .zIndex(1)
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 44)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//                .previewDevice("iPhone 13")
            ContentView()
//                .preferredColorScheme(.light)
//                .previewDevice("iPhone 13")
        }
        .environmentObject(Model())
        
    }
}
