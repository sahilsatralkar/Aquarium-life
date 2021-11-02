//
//  SettingsView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 25/11/20.
//

import SwiftUI
import StoreKit

struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}

struct SettingsView: View {
    
    @StateObject var storeManager: StoreManager
    
    private func openTwitter(appURL: String, webURL: String) {
        if let appURL = URL(string: appURL), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            guard let webURL = URL(string: webURL) else { return }
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    @State private var isSharePresented: Bool = false
    
    @State private var notificationToggle : Bool = true
    
    //Unit conversion variables
    @State private var lengthUnits : LengthUnits = LengthUnits.Centimeters
    @State private var weightUnits : WeightUnits = WeightUnits.Kilograms
    @State private var volumeUnits : VolumeUnits = VolumeUnits.Liters
    @State private var temperatureUnits : TemperatureUnits = TemperatureUnits.Celsius
    
    var body: some View {
        NavigationView {
            Form {
                
                Section (header: Text(LocalizedStringKey("In-App Purchases"))) {
                    
                    if (storeManager.myProducts.isEmpty) {
                        
                        List {
                            HStack {
                                Image(systemName: "checkmark.seal").frame(width:20)
                                    .foregroundColor(.green)
                                VStack(alignment: .leading) {
                                    
                                    Text(LocalizedStringKey("Plants pack"))
                                        
                                }
                                Spacer()
                                Text(LocalizedStringKey("Unable to connect"))
                                    .foregroundColor(.red)
                            }
                            HStack {
                                Image(systemName: "checkmark.seal").frame(width:20)
                                    .foregroundColor(.green)
                                VStack(alignment: .leading) {
                                    
                                    Text(LocalizedStringKey("Shrimps pack"))
                                        
                                }
                                Spacer()
                                Text(LocalizedStringKey("Unable to connect"))
                                    .foregroundColor(.red)
                            }

                        }
                    }
                    else {
                    List (storeManager.myProducts, id:\.self ){ product in
                        HStack {
                            Image(systemName: "checkmark.seal").frame(width:20)
                                .foregroundColor(.green)
                            VStack(alignment: .leading) {
                                
                                //Text(LocalizedStringKey(product.localizedTitle))
                                Text(product.localizedTitle)
                                //remove PRINT
                                //print("dasdasdasdee")
                                //print(product.localizedTitle)
                                    
                            }
                            Spacer()
                            if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                                Text(LocalizedStringKey("Purchased"))
                                    .foregroundColor(.green)
                            } else {
                                Button(action: {
                                    //Purchase particular IAP product
                                    storeManager.purchaseProduct(product: product)
                                    
                                }) {
                                    HStack {
                                        Text(LocalizedStringKey("Buy for"))
                                        Text("\(priceStringForProduct(item: product) ?? "")")
                                        
                                    }
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                }
                }
                Section() {
                    
                    NavigationLink(
                        destination: NotificationsView()){
                        
                        Image(systemName: "bell.badge").frame(width:20)
                            .foregroundColor(.green)
                        Text(LocalizedStringKey("Set notifications"))
                    }
                }
                
                //Language
                Section() {
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)

                    }, label: {
                        HStack(spacing: 8) {
                            Image(systemName: "textbox").frame(width:20)
                                .foregroundColor(.green)
                            Text(LocalizedStringKey("Select language / भाषा चुनें"))
                        }
                        .foregroundColor(.primary)
                        
                    })
                }
                
                Section(header: Text(LocalizedStringKey("Feedback"))) {
                    //Twitter
                    Button(action: {
                        openTwitter(appURL: Constants.Twitter.appURL, webURL: Constants.Twitter.webURL)
                    }, label: {
                        HStack(spacing: 8) {
                            Image(systemName: "at").frame(width:20)
                                .foregroundColor(.green)
                            Text(LocalizedStringKey("Twitter"))
                        }
                        .foregroundColor(.primary)
                    })
                    
                    //Email
                    Button(action: {
                        let bodyString = "</br></br>App version: \(UIApplication.appVersion!) </br> iOS version: \(getOSInfo()) </br> Device: \(getDeviceName())"
                        EmailHelper.shared.sendEmail(subject: "Feedback for Aquarium Life",
                                                     body:bodyString ,
                                                     to: Constants.Email.emailID)
                    }, label: {
                        HStack(spacing: 8) {
                            Image(systemName: "envelope").frame(width:20)
                                .foregroundColor(.green)
                            Text(LocalizedStringKey("Email"))
                        }
                        .foregroundColor(.primary)
                    })
                    
                    //Share Aquarium Life
                    Button(action: {
                        self.isSharePresented = true
                        
                    }, label: {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up").frame(width:20)
                                .foregroundColor(.green)
                            Text(LocalizedStringKey("Share with friends"))
                        }
                        .foregroundColor(.primary)
                    })
                    .sheet(isPresented: $isSharePresented, onDismiss: {
                    }, content: {
                        ActivityViewController(activityItems: [URL(string: "https://apps.apple.com/us/app/aquarium-life/id\(Constants.appAppleID)")!])
                    }
                    )
                    
                    //Rate Aquarium Life
                    Button(action: {
                        
                        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id\(Constants.appAppleID)?action=write-review")
                        else { fatalError("Expected a valid URL") }
                        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
                        
                    }, label: {
                        HStack(spacing: 8) {
                            Image(systemName: "star").frame(width:20)
                                .foregroundColor(.green)
                            Text(LocalizedStringKey("Rate Aquarium Life"))
                        }
                        .foregroundColor(.primary)
                    })
                    
                }
                
                Section(header: Text(LocalizedStringKey("About")), footer:
                            Text(LocalizedStringKey("Made with love by Sahil Satralkar"))
                            .frame(maxWidth: .infinity, alignment: .center)
                ){
                    
                    NavigationLink(
                        destination: AdditionalInfoView()){
                        
                        Image(systemName: "text.bubble").frame(width:20)
                            .foregroundColor(.green)
                        
                        Text(LocalizedStringKey("Additional information"))
                    }
                }
            }
            
            .navigationBarTitle(Text(LocalizedStringKey("Settings")))
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //Restore products already purchased
                        storeManager.restoreProducts()
                    }) {
                        Text(LocalizedStringKey("Restore Purchases"))
                    }
                }
            })
        }
    }

    func priceStringForProduct(item: SKProduct) -> String? {
        let price = item.price
        if price == 0 {
            return "Free" //or whatever you like really... maybe 'Free'
        } else {
            let numberFormatter = NumberFormatter()
            let locale = item.priceLocale
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = locale
            return numberFormatter.string(from: price)
        }
    }

}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(storeManager: StoreManager())
    }
}
