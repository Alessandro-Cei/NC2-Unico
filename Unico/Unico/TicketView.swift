//
//  TicketView.swift
//  Unico
//
//  Created by alessandro on 13/12/21.
//
import CoreData
import SwiftUI
import CoreImage.CIFilterBuiltins


struct TicketView: View{
    
    
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var ticketPressed = false
    @State private var oldBrightness = UIScreen.main.brightness
    @State var isErased = false
    @State var isActivated = false
    var id: UUID
    var company: String
    var tratta: String
    var corsa: String
    var price: String
    @State var qrString: String = ""
    @State private var companyColor = Color.red
    @State private var companyColorInside = Color.blue
    @State private var companyLogo = ""
    var isExpired: Bool
    
    
    
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var tickets: FetchedResults<Ticket>
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(companyColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .position(CGPoint(x: 25, y: 80))
                        .frame(width: .infinity, height: 160)
                        .clipped()
                    VStack {
                        Image(companyLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                            Image(uiImage: generateQRCode(from: "\(company) \(tratta) \(corsa) \(price)"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 70, height: 70)
                        .padding(.top, -10)
                        if isActivated {
                            Text("40m30s")
                                .font(.body)
                                .foregroundColor(companyColor)
                        }
                    }
                    .position(CGPoint(x:55, y: 105))
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(companyColorInside)
                        .overlay(
                            VStack(alignment: .leading, spacing: 20){
                                
                                switch tratta{
                                    
                                case "EAC1":
                                    Text("CTP E AC 1")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .padding(.leading, -10)
                                case "UNA1":
                                    Text("ANM U NA 1")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .padding(.leading, -10)
                                case "UBN":
                                    Text("AIR U BN")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                default:
                                    Text("ATM MI 2")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                                
                                if corsa == "CS" {
                                    Text("CORSA\nSINGOLA")
                                        .foregroundColor(companyColor)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                        .padding(.leading, -10)
                                } else if corsa == "G" {
                                    Text("GIORNALIERO")
                                        .foregroundColor(companyColor)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                }
                                
                                if company == "anm" || company == "ctp"{
                                    Text("€ \(price)")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .padding(.leading, -10)
                                } else {
                                    Text("€ \(price)")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                
                            }
                                .frame(width: 160, height: 160)
                        )
                    
                    /*
                     VStack(alignment: .leading, spacing: 15){
                     
                     switch tratta{
                     
                     case "EAC1":
                     Text("CTP E AC 1")
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .font(.title3)
                     case "UNA1":
                     Text("ANM U NA 1")
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .font(.title3)
                     case "UBN":
                     Text("AIR U BN")
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .font(.title3)
                     default:
                     Text("ATM MI 2")
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .font(.title3)
                     }
                     
                     
                     if corsa == "CS" {
                     Text("CORSA\nSINGOLA")
                     .foregroundColor(companyColor)
                     .fontWeight(.bold)
                     .font(.title3)
                     } else if corsa == "G" {
                     Text("GIORNALIERO")
                     .foregroundColor(companyColor)
                     .fontWeight(.bold)
                     .font(.title3)
                     }
                     
                     Text("€ \(price)")
                     .foregroundColor(.white)
                     .fontWeight(.semibold)
                     .font(.title3)
                     }
                     .position(CGPoint(x: 60, y: 80))*/
                }
                .position(CGPoint(x: 40, y: 80))
                .frame(width: 160, height: 160)
            }
        }
        .frame(width: .infinity, height: 220)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .onAppear(){
            switch company {
            case "AIR":
                companyColor = Color.airGreen
                companyColorInside = Color.airGreenInside
                companyLogo = "airLogo"
            case "anm":
                companyColor = Color.anmBlue
                companyColorInside = Color.anmBlueInside
                companyLogo = "anmLogo"
            case "ctp":
                companyColor = Color.ctpPurple
                companyColorInside = Color.ctpPurpleInside
                companyLogo = "ctpLogo"
            default:
                companyColor = Color.indigo
                companyColorInside = Color.blue
                companyLogo = "airLogo"
            }
            
        }
        .onTapGesture(){
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            ticketPressed.toggle()
            oldBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
            qrString = "\(company) \(tratta) \(corsa) \(price)"
        }
        .sheet(isPresented: $ticketPressed, onDismiss: {
            UIScreen.main.brightness = oldBrightness
            if !isErased {
                
            }
        }) {
            PressedView(ticketPressed: self.$ticketPressed, oldBrightness: self.$oldBrightness, isErased: self.$isErased, isActivated: self.$isActivated/*, id: self.id*/, qrString: self.$qrString, companyColor: self.$companyColor, isExpired: isExpired)
                .interactiveDismissDisabled(false)
        }
    }
    
    func deleteTickets (at offsets: IndexSet) {
        for offset in offsets {
            let ticket = tickets[offset]
            moc.delete(ticket)
        }
        
        //try? moc.save()
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

/*struct TicketView_Previews: PreviewProvider {
 static var previews: some View {
 TicketView()
 }
 }*/
