//
//  AccountView.swift
//  GoalDefinite
//
//  Created by Awal Amadou on 7/2/22.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @State var isDeleted = false
    @State var isPinned = false
    @State var userName = "Awal Amadou"
    @State var address: Address = Address(id: 1, country: "US")
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("userID") var userID = ""
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("isLiteMode") var isLiteMode = false
    @ObservedObject var coinModel = CoinModel()
    @AppStorage("showModal") var showModal = true
    @State var showAccount = false
    
//    let user = Auth.auth().currentUser
//    if let user = user {
//        userID = user.uid
//    }
    

    func fetchAddress() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/address/random_address")!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            // Show error
            address = Address(id: 1, country: "Error fetching")
        }
    }
    
    var body: some View {
        NavigationView {
           List {
               profile
               
               menu
               
               Section {
                   Toggle(isOn: $isLiteMode) {
                       Label("Lite Mode", systemImage:  isLiteMode ? "tortoise" : "hare")
                   }
               }
               .accentColor(.primary)
               
               links
               
               coins
               
               Button {
                   showAccount = false
                   signOut()
                   withAnimation {
                       showModal = true                       
                   }
               } label: {
                   Text("Sign out")
               }
               .tint(.red)
               
            }
           .task {
               await fetchAddress()
               await coinModel.fetchCoins()
           }
           .refreshable {
               await fetchAddress()
               await coinModel.fetchCoins()
           }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing: Button { dismiss() } label: { Text("Done").bold()})
        }
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                     HexagonView()
                         .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            Text(userEmail)
                .font(.subheadline.weight(.semibold))
            Text(userID)
                .font(.footnote.weight(.semibold))
            
            
            HStack {
                Image(systemName: "location")
                    .imageScale(.large)
                Text(address.country)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View {
        Section {
            NavigationLink(destination: HomeView()) {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink {    Text("Billing")} label: {
                Label("Billing", systemImage: "creditcard")
            }
            NavigationLink{ HomeView() } label:{
                Label("Help", systemImage: "questionmark")
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
//               .listRowSeparator(.hidden)
    }
    
    var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://apple.com")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                // Add delete option for when swipe is detected
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button(action: { isDeleted = true }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                    pinButton
                }
            }
            Link(destination: URL(string: "https://news.ycombinator.com")!) {
                HStack {
                    Label("HackerNews", systemImage: "newspaper")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false){
                pinButton
            }
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var coins: some View {
        Section(header: Text("Coins")) {
            ForEach(coinModel.coins) {coin in
                HStack {
                    AsyncImage(url: URL(string: coin.logo)){ image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    var pinButton: some View {
        Button { isPinned.toggle() } label: {
            if isPinned {
                Label("Unpin", systemImage: "pin.slash")
            }else{
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
    
    func signOut(){
        do
        {
            try Auth.auth().signOut()
            isLogged = false
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
