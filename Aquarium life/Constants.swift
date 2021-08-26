//
//  Constants.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 24/01/21.
//

import Foundation

struct Constants {
    
    //v1.5-Start
    
    struct Widget {
        
        static let appGroup = "group.com.sahil.satralkar.AquariumLife"
        static let kind = "AquariumLifeWidget"
    }
    
    //v1.5-End
    
    // v.1.4
    struct QuickActions {
        
        static let calculators = "com.sahil.satralkar.AquariumLife.calculators"
        static let careSheets = "com.sahil.satralkar.AquariumLife.CareSheets"
        static let myNotes = "com.sahil.satralkar.AquariumLife.MyNotes"
    }
    //
    
    //v1.3
    struct TimeInSecs {
        
        static let thirteenDays : Double = 1123200.0
        static let twentyDays : Double = 1728000.0
        static let twentySevenDays : Double = 2332800.0
        static let fiftyNineDays : Double = 5097600.0
        static let eightyNineDays : Double = 7689600.0
        static let sixtyMinutes : Double = 3600.0
        static let twentyFourHours : Double = 86400.0
        static let oneMinute : Double = 60.0
    }
    //
    
    static let emptyString = ""
    
    static let appAppleID = "1551311809"
    
    static let NTSNote = "NTSNote"
    
    struct IAP {
        static let plantsPackAppleID = "1554147419"
        static let shrimpsPackAppleID = "1554147910"
        static let plantsPackProductID = "com.sahil.satralkar.AquariumLife.PlantsPack"
        static let shrimpsPackProductID = "com.sahil.satralkar.AquariumLife.ShrimpsPack"
        
    }
    
    struct Twitter {
        static let appURL = "twitter://user?screen_name=AquariumLifeApp"
        static let webURL = "https://www.twitter.com/AquariumLifeApp"
    }
    struct Email {
        static let emailID = "aquariumlifeapp@gmail.com"
    }
    
    struct Specifier {
        static let zero = "%.0f"
        static let one = "%.1f"
        static let two = "%.2f"
        
    }
    
    struct File {
        static let fishJSON = "fish.json"
        static let plantJSON = "plant.json"
        static let shrimpJSON = "shrimp.json"
        static let guideJSON = "guide.json"
    }
    struct Button {
        static let dismissText = "Dismiss"
        static let saveText = "Save"
        static let okText = "OK"
        static let yesText = "Yes"
        static let noText = "No"
    }
    
}
