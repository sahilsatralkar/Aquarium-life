//
//  SceneDelegate.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import UIKit
import SwiftUI
import StoreKit

import UIKit
import SwiftUI
import StoreKit
// Modified since - v.1.4.1
class SceneDelegate2: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.

        //**v1.3 -> Code to request App Store review

        // get current number of times app has been launched
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")

        // increment received number by one
        if currentCount < 200 {
            UserDefaults.standard.set(currentCount+1, forKey:"launchCount")
        }
        if UserDefaults.standard.integer(forKey: "launchCount") == 10
        {
            guard let sceneForReview = (scene as? UIWindowScene) else {
                return
            }
            SKStoreReviewController.requestReview(in: sceneForReview)
        }

    }
    
    // v.1.4
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

    }

}
