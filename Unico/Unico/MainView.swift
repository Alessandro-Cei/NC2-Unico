//
//  MainView.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            TicketsView()
                .tabItem{
                    Label("Tickets", systemImage: "ticket")
                }
            RoutesView()
                .tabItem{
                    Label("Routes", systemImage: "map")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.customTextBlue)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
