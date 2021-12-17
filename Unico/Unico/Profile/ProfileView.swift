//
//  ProfileView.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .opacity(0.20)
                    .ignoresSafeArea()
                Text("Your profile will be displayed here.")
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
