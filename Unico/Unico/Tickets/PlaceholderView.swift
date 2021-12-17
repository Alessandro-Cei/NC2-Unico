//
//  PlaceholderView.swift
//  Unico
//
//  Created by alessandro on 16/12/21.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        ZStack (alignment: .center){
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(UIColor.systemGray6))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 0.5)
                )
            Text("Buy or acquire your tickets and subscriptions to keep them in one place.\n\nPress the plus button on the\ntop-right corner to add your first one.")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
                .font(.title2)
                .foregroundColor(Color.customTextBlue)
        }
        .frame(width: .infinity, height: 300)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
