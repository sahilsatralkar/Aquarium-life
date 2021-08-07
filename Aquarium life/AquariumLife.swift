//
//  AquariumLife.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 07/08/21.
//  Since v1.4.1
//

import SwiftUI
import CoreData

@main
struct AquariumLife : App {
    
    var persistentContainer = StorageProvider().persistentContainer
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var selectedTabObj = SelectedTab()
    
    var body: some Scene {
        WindowGroup {
            ParentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .environmentObject(selectedTabObj)
        }
        .onChange(of : scenePhase) { phase in
            switch phase {
            case .background:
                saveContext()
            case .active:
                guard appDelegate.shortcutItemToProcess != nil else { return }
                
                if appDelegate.shortcutItemToProcess?.type == Constants.QuickActions.calculators
                {
                    selectedTabObj.tabNumber = .calculators
                }
                else if appDelegate.shortcutItemToProcess?.type == Constants.QuickActions.careSheets
                {
                    selectedTabObj.tabNumber = .careSheets
                }
                else if appDelegate.shortcutItemToProcess?.type == Constants.QuickActions.myNotes
                {
                    selectedTabObj.tabNumber = .myNotes
                }
            default: return
            }
        }
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

enum TabIdentifier: Hashable {
    case myAquariums, careSheets, calculators, myNotes, settings
}

extension URL {
    var isDeeplink: Bool {
        return scheme == "aquarium-life" // matches aquarium-life://<rest-of-the-url>
    }
    
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else { return nil }
        
        switch host {
        case "myAquariums":
            
            return .myAquariums // matches aquarium-life://myAquariums/
        case "settings":
            return .settings // matches aquarium-life://settings/
        default: return nil
        }
    }
}
