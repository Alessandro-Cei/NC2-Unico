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

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
