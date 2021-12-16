//
//  DataController.swift
//  Unico
//
//  Created by alessandro on 15/12/21.
//
import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Unico")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
             
        }
    }
}
