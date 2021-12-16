//
//  RoutesView.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

import SwiftUI

struct RoutesView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Image("Background")
                    .resizable()
                    .opacity(0.35)
                    .ignoresSafeArea()
                
                Text("Routes will be displayed here.")
            }
        }
        .navigationTitle("Routes")
        
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RoutesView()

        }
    }
}
