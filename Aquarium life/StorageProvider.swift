//
//  StorageProvider.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 07/08/21.
//  Since v1.4.1

import CoreData

public class StorageProvider {
    
    public static var standard = StorageProvider()
    public let persistentContainer : NSPersistentCloudKitContainer
    
    public init () {
        
        persistentContainer = NSPersistentCloudKitContainer(name: "AquariumLifeModel")
        
        //use the new store
        if !FileManager.default.fileExists(atPath: oldStoreURL.path) {
            persistentContainer.persistentStoreDescriptions.first!.url = sharedStoreURL
        }
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
        
        //perform migration
        migrateStore(for: persistentContainer)
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        //Code for iCloud
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSObject, forKey: NSPersistentHistoryTrackingKey)
        
    }
    
    private var oldStoreURL : URL {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return appSupport.appendingPathComponent("AquariumLifeModelShared.sqlite")
    }
    
    private var sharedStoreURL : URL {
        let id = "group.com.sahil.satralkar.AquariumLife"
        let groupContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: id)!
        return groupContainer.appendingPathComponent("AquariumLifeModelShared.sqlite")
    }
    
    func migrateStore(for container: NSPersistentCloudKitContainer) {
        
        //Check if persistent store is copied to shared location
        guard !FileManager.default.fileExists(atPath: sharedStoreURL.path) else {
            return
        }
        
        let coordinator = container.persistentStoreCoordinator
        guard let oldStore = coordinator.persistentStore(for: oldStoreURL) else {
            return
        }
        
        do {
            try coordinator.migratePersistentStore(oldStore, to: sharedStoreURL, options: nil, withType: NSSQLiteStoreType)
        
        } catch {
            fatalError("Something went wrong while migrating the store: \(error)")
        }
        do {
            try FileManager.default.removeItem(at: oldStoreURL)
            
        } catch {
            //fatalError("Something went wrong while deleting the old store: \(error)")
            //Condition if persistent store is copied to new shared location but deleting old store failed
            print("Something went wrong while deleting the old store \(error)")
        }
    }
}
