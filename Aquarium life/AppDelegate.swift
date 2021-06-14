//
//  AppDelegate.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import UIKit
import CoreData

// v.1.4
//Declaration outside class
var selectedTabObj = SelectedTab()
var shortcutItemToProcess: UIApplicationShortcutItem?

//Class to handle the quick action selection
class SelectedTab : ObservableObject {
    @Published var tabNumber : Int = 1
    
}
//

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        // v.1.4
        //Quick action for Calculators
        if let shortcutItem = options.shortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        if shortcutItemToProcess?.type == Constants.QuickActions.calculators
        {
            selectedTabObj.tabNumber = 3
        }
        else if shortcutItemToProcess?.type == Constants.QuickActions.careSheets
        {
            selectedTabObj.tabNumber = 2
        }
        else if shortcutItemToProcess?.type == Constants.QuickActions.myNotes
        {
            selectedTabObj.tabNumber = 4
        }
        //
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack

    //v.1.4- Cloudkit
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
    //
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        //v.1.4- Cloudkit
        let container = NSPersistentCloudKitContainer(name: "AquariumLifeModel")
        //
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        //v.1.4- Cloudkit
        container.persistentStoreDescriptions.first!.setOption(true as NSObject, forKey: NSPersistentHistoryTrackingKey)
        //
        return container
    }()
    
    // MARK: - Core Data Saving support

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

