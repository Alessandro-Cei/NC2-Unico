//
//  TicketView.swift
//  Unico
//
//  Created by alessandro on 13/12/21.
//
import CoreData
import SwiftUI
import CoreImage.CIFilterBuiltins
import simd


struct TicketView: View{
    
    
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var ticketPressed = false
    @State private var oldBrightness = UIScreen.main.brightness
    @State var isErased = false
    @State var isActivated = false
    @State var id: UUID
    var company: String
    var tratta: String
    var corsa: String
    var price: String
    @State var qrString: String = ""
    @State private var companyColor = Color.red
    @State private var companyColorInside = Color.blue
    @State private var companyLogo = ""
    var isExpired: Bool
    
    
    @State private var isActive = true
    @State private var timeRemaining: Int64 = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    
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
                            if corsa == "G" {
                                //timeRemaining = 86400
                                let (m, s) = secondsToMinutesSeconds(timeRemaining)
                                Text("\(m)m\(s)s")
                                    .font(.body)
                                    .foregroundColor(companyColor)
                            } else if corsa == "CS" {
                                //timeRemaining = 5400
                                let (m, s) = secondsToMinutesSeconds(timeRemaining)
                                Text("\(m)m\(s)s")
                                    .font(.body)
                                    .foregroundColor(companyColor)
                            }
                            
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
            
            if corsa == "G" {
                timeRemaining = 86400
            } else if corsa == "CS" {
                timeRemaining = 1800
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
        }) {
            PressedView(ticketPressed: self.$ticketPressed, oldBrightness: self.$oldBrightness, isErased: self.$isErased, isActivated: self.$isActivated, qrString: self.$qrString, companyColor: self.$companyColor, id: self.$id, isExpired: isExpired)
                .interactiveDismissDisabled(false)
        }
        .onReceive(timer) { time in
            guard self.isActive else {return}
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.isActive = true
        }
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
    
    func secondsToMinutesSeconds(_ seconds: Int64) -> (Int64, Int64) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

/*struct TicketView_Previews: PreviewProvider {
 static var previews: some View {
 TicketView()
 }
 }*/
