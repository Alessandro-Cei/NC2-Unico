//
//  PressedView.swift
//  Unico
//
//  Created by alessandro on 13/12/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct PressedView: View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @Binding var ticketPressed: Bool
    @Binding var oldBrightness: CGFloat
    @Binding var isErased: Bool
    @Binding var isActivated: Bool
    @Binding var qrString: String
    @Binding var companyColor: Color
    @Binding var id: UUID
    @State private var showingDeleteAlert = false
    var isExpired: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var tickets: FetchedResults<Ticket>
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .opacity(0.20)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(companyColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        if isExpired {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .opacity(0.3)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                            Image(uiImage: generateQRCode(from: qrString))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                            if isExpired{
                                Rectangle()
                                    .foregroundColor(.black)
                                    .opacity(0.3)
                            }
                        }
                        .frame(width: 180, height: 180)
                    }
                    .frame(width: .infinity, height: 350)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding()
                    .padding(.bottom, 60)
                    .onTapGesture {
                        ticketPressed.toggle()
                        UIScreen.main.brightness = oldBrightness
                    }
                    .navigationBarItems(leading: Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    })
                    .navigationBarItems(trailing: Button(action: {
                        ticketPressed.toggle()
                        UIScreen.main.brightness = oldBrightness
                    }) {
                        Text("Done")
                            .foregroundColor(.customSystemBlue)
                    })
                    .alert("Delete ticket", isPresented: $showingDeleteAlert){
                        Button("Delete", role: .destructive, action: {
                            deleteTickets(id)
                            ticketPressed.toggle()
                            UIScreen.main.brightness = oldBrightness
                        })
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Are you sure?")
                    }
                    if !isExpired {
                        if !isActivated {
                            Button(action: {
                                isActivated.toggle()
                                ticketPressed.toggle()
                                UIScreen.main.brightness = oldBrightness
                            }, label: {
                                Text("Activate")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.customSystemBlue.cornerRadius(10))
                                    .foregroundColor(.white)
                            })
                                .padding()
                                .padding(.bottom, 50)
                        } 
                        
                    }
                }
            }
        }
        
    }
    

    func deleteTickets (_ givenId: UUID) {
        
        for ticket in tickets {
            if ticket.id == givenId{
                moc.delete(ticket)
            }
        }
        try? moc.save()
        
    }
    
    
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
/*
 struct PressedView_Previews: PreviewProvider {
 static var previews: some View {
 NavigationView{
 PressedView(ticketPressed: .constant(true), oldBrightness: .constant(CGFloat(1.0)), isErased: .constant(false), isActivated: .constant(false), id: 0)
 }
 }
 }
 */
