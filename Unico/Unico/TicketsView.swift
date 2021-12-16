//
//  TicketsView.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//

import SwiftUI
import CoreData

struct TicketsView: View {
    
    init(){
        UITableView.appearance().backgroundColor = .red // tableview background
        UITableViewCell.appearance().backgroundColor = .green // cell background
    }
    
    
    @State private var showModal = false
    @State private var dropdown = false
    @State var arrowDegrees = false
    
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id/*, order: .reverse*/)]) var tickets: FetchedResults<Ticket>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .reverse)]) var subscriptions: FetchedResults<Subscription>
    
    
    var body: some View {
        
        
        //NavigationView {
        ZStack {
            
            Image("Background")
                .resizable()
                .opacity(0.35)
                .ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Text("Tickets")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.customSystemBlue)
                    }
                    .sheet(isPresented: $showModal) {
                        ChoiceModal(showModal: self.$showModal)
                            .environment(\.managedObjectContext, self.moc)
                            .interactiveDismissDisabled(true)
                    }
                }
                .padding()
                .padding(.top, 30)
                HStack {
                    Text("Active")
                        .font(.title2)
                        .foregroundColor(.customTextBlue)
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.top, -10)
                .onTapGesture {
                    if dropdown {
                        dropdown.toggle()
                    }
                }
                
                if !dropdown {
                    
                    if subscriptions.isEmpty && tickets.isEmpty {
                        VStack{
                            //Spacer()

                            PlaceholderView()
                                .padding()
                            
                            Spacer()
                        }
                        
                    } else {
                        
                        List{
                            ForEach(subscriptions) { subscription in
                                SubscriptionView(isExpired: false)
                            }
                            .onDelete(perform: deleteSubscriptions)
                            
                            ForEach(tickets) { ticket in
                                
                                TicketView(id: ticket.id!, company: ticket.company!, tratta: ticket.tratta!, corsa: ticket.corsa!, price: ticket.price!, isExpired: false)
                            }
                            .onDelete(perform: deleteTickets)
                            
                        }
                        .listStyle(.plain)
                    }
                    
                }
                
                HStack {
                    Text("History")
                        .font(.title2)
                        .foregroundColor(.customTextBlue)
                    Spacer()
                    Button(action: {
                        dropdown.toggle()
                        arrowDegrees.toggle()
                    }, label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.customSystemBlue)
                            .font(.title2)
                            .rotationEffect(Angle(degrees: arrowDegrees ? 180.0 : 0.0))
                        
                    })
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 20)
                .padding(.top, 10)
                
                if dropdown {
                    List{
                        SubscriptionView(isExpired: true)
                            .overlay(RoundedRectangle(cornerRadius: 10).foregroundColor(.black).opacity(0.5))
                        TicketView(id: UUID(), company: "AIR", tratta: "UBN", corsa: "G", price: "4,70", isExpired: true)
                            .overlay(RoundedRectangle(cornerRadius: 10).foregroundColor(.black).opacity(0.5))
                        TicketView(id: UUID(), company: "anm", tratta: "UNA1", corsa: "CS", price: "1,10", isExpired: true)
                            .overlay(RoundedRectangle(cornerRadius: 10).foregroundColor(.black).opacity(0.5))
                        TicketView(id: UUID(), company: "ctp", tratta: "EAC1", corsa: "CS", price: "1,20", isExpired: true)
                            .overlay(RoundedRectangle(cornerRadius: 10).foregroundColor(.black).opacity(0.5))
                    }
                    .listStyle(.plain)
                    //.onDelete(perform: deleteTickets)
                }
                
            }
            .navigationTitle("Tickets")
            .onAppear {
                UINavigationBarAppearance()
                    .setColor(title: UIColor(.customTextBlue), background: .clear)
                UITableView.appearance().separatorStyle = .none
                UITableViewCell.appearance().backgroundColor = .red
                UITableView.appearance().backgroundColor = .clear
            }
            .navigationBarItems(trailing: Button(action: {
                self.showModal.toggle()
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.customSystemBlue)
            })
            .sheet(isPresented: $showModal) {
                ChoiceModal(showModal: self.$showModal)
                    .environment(\.managedObjectContext, self.moc)
                //.interactiveDismissDisabled(true)
            }
        }
        //}
    }
    
    
    func deleteTickets (at offsets: IndexSet) {
        for offset in offsets {
            let ticket = tickets[offset]
            moc.delete(ticket)
        }
        
        //try? moc.save()
    }
    func deleteSubscriptions (at offsets: IndexSet) {
        for offset in offsets {
            let subscription = subscriptions[offset]
            moc.delete(subscription)
        }
        
        //try? moc.save()
    }
    
    func deleteFake (at offsets: IndexSet) {
        for offset in offsets {
            let ticket = tickets[offset]
            moc.delete(ticket)
        }
        
        //try? moc.save()
    }
    
    
    /*private func addItem() {
     withAnimation {
     let newItem = Item(context: viewContext)
     newItem.timestamp = Date()
     
     do {
     try viewContext.save()
     } catch {
     // Replace this implementation with code to handle the error appropriately.
     // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     let nsError = error as NSError
     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
     }
     }
     }
     
     private func deleteItems(offsets: IndexSet) {
     withAnimation {
     offsets.map { items[$0] }.forEach(viewContext.delete)
     
     do {
     try viewContext.save()
     } catch {
     // Replace this implementation with code to handle the error appropriately.
     // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
     let nsError = error as NSError
     fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
     }
     }
     }*/
}




extension UINavigationBarAppearance {
    func setColor(title: UIColor? = nil, background: UIColor? = nil) {
        configureWithTransparentBackground()
        if let titleColor = title {
            largeTitleTextAttributes = [.foregroundColor: titleColor]
            titleTextAttributes = [.foregroundColor: titleColor]
        }
        backgroundColor = background
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
    }
}

/*private let itemFormatter: DateFormatter = {
 let formatter = DateFormatter()
 formatter.dateStyle = .short
 formatter.timeStyle = .medium
 return formatter
 }()
 */


struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            TicketsView()
                .tabItem{
                    Label("Tickets", systemImage: "ticket")
                }
            RoutesView()
                .tabItem{
                    Label("Routes", systemImage: "map")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.black)
        .previewInterfaceOrientation(.portrait)
    }
}
