//
//  ChoiceModal.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

import SwiftUI
import CoreData

struct ChoiceModal: View {
    
    @Binding var showModal: Bool
    @State var showBuy = false
    @State var showAcquire = false
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Image("Background")
                    .resizable()
                    .opacity(0.35)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){

                    Text("Keep your physical and digital tickets all in one place.")
                        .foregroundColor(.customTextBlue)
                        .fontWeight(.semibold)
                        .font(.body)
                        .padding()
                        .padding(.top, 25)
                        
                    
                    List{
                        NavigationLink(destination: BuyView(showBuy: $showBuy)){
                            Label("Buy", systemImage: "eurosign.circle")
                                .foregroundColor(.customSystemBlue)
                        }
                        NavigationLink(destination: AcquireView(showAcquire: $showAcquire).environment(\.managedObjectContext, moc)){
                            Label("Acquire", systemImage: "camera")
                                .foregroundColor(.customSystemBlue)
                        }
                    }
                    .navigationBarTitleDisplayMode(.large)
                    .onAppear {
                        UINavigationBarAppearance()
                            .setColor(title: UIColor(.customTextBlue), background: .clear)
                        UINavigationBar.appearance().tintColor = UIColor(.customSystemBlue)
                        UITableView.appearance().backgroundColor = UIColor(.clear)
                    }
                    .navigationTitle("Add to your tickets")
                    .navigationBarItems(trailing: Button(action: {
                        self.showModal.toggle()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                            .foregroundColor(.customSystemBlue)
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
        

        
    }
}



struct ChoiceModal_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceModal(showModal: .constant(true))
    }
}
