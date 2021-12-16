//
//  BuyView.swift
//  Unico
//
//  Created by alessandro on 10/12/21.
//

import SwiftUI

struct BuyView: View {
    
    
    
    @State var showAcquire = false
    
    
    
    
    @Binding var showBuy: Bool
    @State private var showRoundTrip = false
    @State private var departure: String = ""
    @State private var arrival: String = ""
    @State private var wakeUp = Date.now
    
    
    
    
    
    var body: some View {
        
        
        ZStack {
            Image("Background")
                .resizable()
                .opacity(0.35)
                .ignoresSafeArea()
            VStack{
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                    
                    VStack{
                        Toggle("Round Trip", isOn: $showRoundTrip)
                            .padding(.trailing, 8)
                            .foregroundColor(.customTextBlue)
                            .tint(Color.customSystemBlue)
                        
                        
                        
                        ZStack {
                            VStack(alignment: .leading){
                                Text("From:")
                                    .foregroundColor(.customTextBlue)
                                TextField(
                                    "Departure",
                                    text: $departure
                                )
                                
                                Text("To:")
                                    .foregroundColor(.customTextBlue)
                                TextField(
                                    "Arrival",
                                    text: $arrival
                                )
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.largeTitle)
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(Color.customSystemBlue.cornerRadius(10))
                                    .foregroundColor(.white)
                            })
                                .position(CGPoint(x: 270, y: 55))
                            
                        }
                        .padding(.top, 10)
                        
                        
                        HStack(){
                            Spacer()
                            DatePicker("", selection: $wakeUp, in: Date()...,  displayedComponents: [.date])
                                .labelsHidden()
                            //.accentColor(.customSystemBlue)
                            Spacer()
                            Divider()
                            Spacer()
                            DatePicker("", selection: $wakeUp, in: Date()..., displayedComponents: [.date])
                                .disabled(!showRoundTrip)
                                .labelsHidden()
                            Spacer()
                            
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    
                    
                }
                .foregroundColor(.customSystemBlue)
                .padding()
                
                
                
                
                Button(action: {
                    
                }, label: {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.customSystemBlue.cornerRadius(10))
                        .foregroundColor(.white)
                })
                    .padding()
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()

                
                HStack {
                    Text("Recent")
                        .font(.title2)
                        .foregroundColor(.customTextBlue)
                        .padding()
                    
                    Spacer()
                }
                
                
                List{
                    NavigationLink(destination: AcquireView(showAcquire: $showAcquire)){
                        VStack (alignment: .leading){
                            Text("Napoli Piazza Cavour")
                            Text("Napoli San Giovanni Barra")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: AcquireView(showAcquire: $showAcquire)) {
                        VStack (alignment: .leading){
                            Text("Napoli Montesanto")
                            Text("Napoli Campi Flegrei")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(.customSystemBlue)
                //.padding(.top, -35)
                
            }
            //.navigationBarTitleDisplayMode(.large)
            .navigationTitle("Buy ticket")
            .onAppear {
                UINavigationBarAppearance()
                    .setColor(title: UIColor(.customTextBlue), background: .clear)
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
            
        }
        
    }
}

struct BuyView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        
        NavigationView {
            BuyView(showBuy: .constant(true))
        }
    }
}
