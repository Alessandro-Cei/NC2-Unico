//
//  ScannerView.swift
//  Unico
//
//  Created by alessandro on 12/12/21.
//

import Foundation
import SwiftUI

/*class ScannerViewModel: ObservableObject {
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = ""
    
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}*/

/*struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
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
            
           
            
            
            VStack {
                VStack {
                    Text("Keep scanning for QR-codes")
                        .font(.subheadline)
                    Text(self.viewModel.lastQrCode)
                        .bold()
                        .lineLimit(5)
                        .padding()
                }
                .padding(.vertical, 20)
                
                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
      
            ScannerView()

    
    }
}
*/
