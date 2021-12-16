//
//  UnicoApp.swift
//  Unico
//
//  Created by alessandro on 09/12/21.
//
import CoreData
import SwiftUI

@main
struct UnicoApp: App {
    
    @StateObject private var dataController = DataController()
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            /*ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)*/

            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
