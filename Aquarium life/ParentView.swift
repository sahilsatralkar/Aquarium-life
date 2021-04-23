//
//  ParentView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import SwiftUI
import StoreKit

//Code to hide keyboard/decimalpad
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// Get app version
extension UIApplication {
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
}
//Get iOS version
func getOSInfo()->String {
    let os = ProcessInfo().operatingSystemVersion
    return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
}

//Get Device name
func getDeviceName() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    return machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
}

enum LengthUnits: String, CaseIterable {
    case Centimeters
    case Inches
}

enum WeightUnits: String, CaseIterable {
    case Kilograms
    case Pounds
}

enum VolumeUnits: String, CaseIterable {
    case Liters
    case USGallons = "US Gallons"
    case UKGallons = "UK Gallons"
}

enum TemperatureUnits: String, CaseIterable {
    case Celsius
    case Fahrenheit
}

struct ParentView: View {
    
    //IAP product ID's
    let productIDs = [
            //Use your product IDs
        Constants.IAP.shrimpsPackProductID,
        Constants.IAP.plantsPackProductID
        ]
    
    @StateObject var storeManager = StoreManager()
    
    var body: some View {
        TabView {
            MyTankView()
                .tabItem {
                    Image(systemName: "cube")
                    Text(LocalizedStringKey("MyAquariums"))
                }
            
            LiveStockView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text(LocalizedStringKey("CareSheets"))
                }
            
            CalculatorView()
                .tabItem {
                    Image(systemName: "plus.slash.minus")
                    Text(LocalizedStringKey("Calculators"))
                }
            NotesView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text(LocalizedStringKey("MyNotes"))
                }
            SettingsView(storeManager: self.storeManager)
                .tabItem {
                    Image(systemName: "gear")
                    Text(("Settings"))
                }
                .background(Color(.blue))
        }
        .onAppear(perform:{
            SKPaymentQueue.default().add(storeManager)
            storeManager.getProducts(productIDs: productIDs)
        })
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView(storeManager: StoreManager())
    }
}
