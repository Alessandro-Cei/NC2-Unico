//
//  ContentView.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

/*import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var tickets: FetchedResults<Ticket>
    
    var body: some View {
        
        VStack{
            List(tickets){ ticket in
                Text(ticket.company ?? "Unknown")
            }
        }
        
        Button("Add"){
            
            let companies = ["Air", "Anm", "Atm"]
            let tratte = ["UAV1", "NA1", "MI2"]
            let corse = ["CS", "G", "CS"]
            let prices = ["4,70", "1,10", "2"]
            
            let chosenFirstElement = companies.randomElement()!
            let chosenSecondElement = tratte.randomElement()!
            let chosenThirdElement = corse.randomElement()!
            let chosenFourthElement = prices.randomElement()!
            
            let ticket = Ticket(context: moc)
            ticket.id = UUID()
            ticket.company = chosenFirstElement
            ticket.tratta = chosenSecondElement
            ticket.corsa = chosenThirdElement
            ticket.price = chosenFourthElement
            
            try? moc.save()

        }
        
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
