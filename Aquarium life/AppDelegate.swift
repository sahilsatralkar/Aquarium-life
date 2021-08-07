//
//  AppDelegate.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import UIKit
import CoreData

// v.1.4.1
//Declaration outside class
//var selectedTabObj = SelectedTab()
//var shortcutItemToProcess: UIApplicationShortcutItem?

//Class to handle the quick action selection
class SelectedTab : ObservableObject {
    // v.1.4.1
    @Published var tabNumber : TabIdentifier = TabIdentifier.myAquariums
    
}
//

class AppDelegate: UIResponder, UIApplicationDelegate {
    // v.1.4.1 - Start
    var shortcutItemToProcess: UIApplicationShortcutItem? { AppDelegate.shortcutItemToProcess }
    
    fileprivate static var shortcutItemToProcess: UIApplicationShortcutItem?
    // v.1.4.1 - End
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
            // v.1.4.1
            AppDelegate.shortcutItemToProcess = shortcutItem
        }
        
        let sceneConfiguration = UISceneConfiguration(
            name: "Scene Configuration",
            sessionRole: connectingSceneSession.role
        )
        sceneConfiguration.delegateClass = SceneDelegate.self
        
        return sceneConfiguration
    }
}
// v.1.4.1
private final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        AppDelegate.shortcutItemToProcess = shortcutItem

        completionHandler(true)
    }
}

