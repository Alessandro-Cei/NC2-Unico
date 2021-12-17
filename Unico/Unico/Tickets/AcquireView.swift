//
//  AcquireView.swift
//  Unico
//
//  Created by alessandro on 10/12/21.
//
import CoreData
import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreMedia


class ScannerViewModel: ObservableObject {
    
    let scanInterval: Double = 1.0
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = ""
    @Published var lastQrCode2: String = ""
    @Published var codeArr: [String] = [""]
    
    
    func onFoundQrCode(_ code: String) {
        
        let toCompare: String = "\(code[0])\(code[1])\(code[2])"
        if (toCompare == "AIR") || (toCompare == "anm") || (toCompare == "ctp") {
            self.lastQrCode = code
            self.codeArr = code.components(separatedBy: " ")
        } else if (toCompare == "SUB") {
            self.lastQrCode2 = code
            self.codeArr = code.components(separatedBy: " ")
        } else if (toCompare == "htt") {
            self.lastQrCode2 = code
            codeArr[0] = "its sub"
        }
    }
}

struct AcquireView: View {

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @ObservedObject var viewModel = ScannerViewModel()
    @Binding var showAcquire: Bool
    @State private var showAlert = false
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var tickets: FetchedResults<Ticket>
    @FetchRequest(sortDescriptors: []) var subscriptions: FetchedResults<Subscription>
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .opacity(0.20)
                .ignoresSafeArea()
            VStack{
                VStack (alignment: .leading){
                    ZStack {
                        QrCodeScannerView()
                            .found(r: self.viewModel.onFoundQrCode)
                            .torchLight(isOn: self.viewModel.torchIsOn)
                            .interval(delay: self.viewModel.scanInterval)
                            .frame(height: 350)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 350, height: 200)
                            .foregroundColor(Color.clear)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2))
                    }
                    Text("Position your ticket in the frame to scan it.")
                        .foregroundColor(.customTextBlue)
                        .fontWeight(.semibold)
                        .font(.body)
                        .padding()
                }
                .padding(.top, 50)
                
                Spacer()
                
                if self.viewModel.lastQrCode != "" {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.customTextBlue)
                        .frame(width: 1, height: 1)
                        .opacity(0.0)
                        .onAppear(){
                            
                            let ticket = Ticket(context: self.moc)
                            ticket.id = UUID()
                            ticket.company = self.viewModel.codeArr[0]
                            ticket.tratta = self.viewModel.codeArr[1]
                            ticket.corsa = self.viewModel.codeArr[2]
                            ticket.price = self.viewModel.codeArr[3]
                            
                            do {
                                try self.moc.save()
                                //self.showAcquire = false
                                self.showAlert = true

                            } catch {
                                print(error)
                            }
                        }
                        .alert(isPresented: $showAlert, content: {
                            
                            Alert(title: Text("Acquired"),
                                  message: Text("Saved successfully."),
                                  dismissButton: Alert.Button.default(
                                    Text("OK"), action: {
                                        
                                        self.showAcquire = false

                                    }
                                  )
                            )
                        })
                    
                } else if (self.viewModel.lastQrCode2 != "") && (self.viewModel.codeArr[0] == "its sub"){
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.customTextBlue)
                        .frame(width: 1, height: 1)
                        .opacity(0.0)
                    
                        .onAppear(){
                            
                            let subscription = Subscription(context: self.moc)
                            subscription.id = UUID()
                            subscription.surname = "CEI"
                            subscription.name = "ALESSANDRO"
                            subscription.day = "19"
                            subscription.month = "03"
                            subscription.year = "1994"
                            subscription.birthplace = "PAVIA"
                            
                            do {
                                try self.moc.save()
                                //self.showAcquire = false
                                self.showAlert = true
                            } catch {
                                print(error)
                            }
                            
                            
                        }
                        .alert(isPresented: $showAlert, content: {
                            
                            Alert(title: Text("Acquired"),
                                  message: Text("Saved successfully."),
                                  dismissButton: Alert.Button.default(
                                    Text("OK"), action: {
                                        
                                        self.showAcquire = false

                                    }
                                  )
                            )
                        })
                    
                } else if self.viewModel.lastQrCode2 != "" {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.customTextBlue)
                        .frame(width: 1, height: 1)
                        .opacity(0.0)
                    
                        .onAppear(){
                            
                            let subscription = Subscription(context: self.moc)
                            subscription.id = UUID()
                            subscription.surname = self.viewModel.codeArr[0]
                            subscription.name = self.viewModel.codeArr[1]
                            subscription.day = self.viewModel.codeArr[2]
                            subscription.month = self.viewModel.codeArr[3]
                            subscription.year = self.viewModel.codeArr[4]
                            subscription.birthplace = self.viewModel.codeArr[5]
                            
                            do {
                                try self.moc.save()
                                //self.showAcquire = false
                                self.showAlert = true

                            } catch {
                                print(error)
                            }
                        }
                        .alert(isPresented: $showAlert, content: {
                            
                            Alert(title: Text("Acquired"),
                                  message: Text("Saved successfully."),
                                  dismissButton: Alert.Button.default(
                                    Text("OK"), action: {
                                        

                                        self.showAcquire = false

                                    }
                                  )
                            )
                        })
                }
                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.white)
                            .padding()
                            .frame(width: 60, height: 60)
                            .background(Color.customSystemBlue)
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Acquire ticket")
        .onAppear {
            UINavigationBarAppearance()
                .setColor(title: UIColor(.customTextBlue), background: .clear)
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
    }
    
}



struct AcquireView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AcquireView(showAcquire: .constant(true))
            
        }
    }
}
