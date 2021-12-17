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
    @State private var departureDateTime = Date.now
    @State private var returnDateTime = Date.now

    
    var body: some View {
        
        ZStack {
            Image("Background")
                .resizable()
                .opacity(0.20)
                .ignoresSafeArea()
            ScrollView{
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
                                    .foregroundColor(.customSystemBlue)
                                
                                Text("To:")
                                    .foregroundColor(.customTextBlue)
                                TextField(
                                    "Arrival",
                                    text: $arrival
                                )
                                    .foregroundColor(.customSystemBlue)

                            }
                            Button(action: {
                                let temp = arrival
                                arrival = departure
                                departure = temp
                            }, label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.largeTitle)
                                    .frame(width: 35, height: 35)
                                    .padding()
                                    .background(Color.customSystemBlue.cornerRadius(10))
                                    .foregroundColor(.white)
                            })
                                .position(CGPoint(x: 275, y: 57))
                        }
                        .padding(.top, 10)
                        VStack(){
                            //Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "calendar.badge.clock")
                                    .font(.system(size: 33))
                                    .foregroundColor(.customTextBlue)
                                Spacer()
                                DatePicker("Departure", selection: $departureDateTime, in: Date()...,  displayedComponents: [.date, .hourAndMinute])
                                    .foregroundColor(.customTextBlue)
                                    .labelsHidden()
                                .accentColor(.customSystemBlue)
                                Spacer()
                            }
                                
                            if showRoundTrip{
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.system(size: 33
                                                     ))
                                        .foregroundColor(.customTextBlue)
                                    Spacer()
                                DatePicker("Return", selection: $returnDateTime, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                                
                                    //.disabled(!showRoundTrip)
                                    .foregroundColor(.customTextBlue)
                                    .accentColor(.customSystemBlue)
                                    .labelsHidden()
                                    Spacer()
                                }

                            }
                            
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
               
                ZStack{
                    
                    List {
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
                }
                .frame(width: .infinity, height: 150)
            }
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
