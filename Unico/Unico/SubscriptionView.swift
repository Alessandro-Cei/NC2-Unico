//
//  SubscriptionView.swift
//  Unico
//
//  Created by alessandro on 14/12/21.
//

import CoreData
import SwiftUI
import CoreImage.CIFilterBuiltins

struct SubscriptionView: View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State private var subscriptionPressed = false
    @State private var oldBrightness = UIScreen.main.brightness
    @State var isErased = false
    @State var qrString: String = "CEI ALESSANDRO 19 03 1994 PAVIA"
    var isExpired: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var tickets: FetchedResults<Ticket>
    
    var body: some View {
        ZStack {
            
            
            Image("subscriptionBackground")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            
            Image("unicoLogoWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .position(CGPoint(x: 262, y: 110))
            
            
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                Image(uiImage: generateQRCode(from: qrString))
                 .interpolation(.none)
                 .resizable()
                 .scaledToFit()
                
            }
            .frame(width: 70, height: 70)
            .position(CGPoint(x: 65, y: 70))
            
            Text("CEI\nALESSANDRO\n19/03/1994 PAVIA")
                .font(.body)
                .fontWeight(.regular)
                .position(CGPoint(x: 100, y: 160))
        }
        .frame(width: .infinity, height: 220)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .onTapGesture(){
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            subscriptionPressed.toggle()
            oldBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
        }
        .sheet(isPresented: $subscriptionPressed, onDismiss: {
            UIScreen.main.brightness = oldBrightness
            if !isErased {
                
            }
            
        }) {
            SubscriptionPressedView(subscriptionPressed: self.$subscriptionPressed, oldBrightness: self.$oldBrightness, isErased: self.$isErased, qrString: self.$qrString, isExpired: isExpired)
                .interactiveDismissDisabled(false)
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
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(isExpired: false)
    }
}
