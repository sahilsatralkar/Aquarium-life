//
//  NotificationsView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 20/01/21.
//

import SwiftUI
import UserNotifications

enum NotificationsActiveAlert {
    case first, second, third, fourth, fifth, zero
}

struct NotificationsView: View {
    @State private var notificationsActiveAlert: NotificationsActiveAlert = .zero
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Notifications.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notifications.date, ascending: false)]) var notificationResults: FetchedResults<Notifications>
    
    @State private var activateNotification = UserDefaults.standard.bool(forKey: "ActivateNotification")
    
    @State private var notificationAlerts = false
    
    @State private var showingAddNotificationSheet = false
    
    var body: some View {
        Form {
            Section (header: Text(LocalizedStringKey("Notification list")), footer: Text(LocalizedStringKey("Tap on + to add Notification"))){
                List {
                    ForEach(notificationResults) {notification in
                        
                        VStack(alignment: .leading){
                            Text("\(notification.label ?? "")")
                                .font(.headline)
                                .padding(1)
                            HStack {
                                Image(systemName: "repeat").frame(width:20)
                                Text("\(notification.repeatNotifications ?? "")")
                            }
                            .font(.footnote).foregroundColor(.green)
                            HStack {
                                Image(systemName: "clock").frame(width:20)
                                Text("\(notification.notificationDate ?? "")")
                            }
                            .font(.footnote).foregroundColor(.green)
                            .padding(.top,1)
                            .padding(.bottom,1)
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
            }

        }
        .alert(isPresented: $notificationAlerts){
            switch notificationsActiveAlert {
            
            case .first:
                return Alert(title : Text(LocalizedStringKey("Notifications disabled!")), message: Text(LocalizedStringKey("Please Turn on Notifications")), dismissButton: .default(Text(LocalizedStringKey("OKButton"))))
            case .second:
                return Alert(title: Text(LocalizedStringKey("Permission not granted!")),message : Text(LocalizedStringKey("Please enable notifications from iPhone Settings > Notifications > Aquarium Life > Allow Notifications")) , dismissButton: .default(Text(LocalizedStringKey("OKButton"))) {
                    
                })
            case .third:
                return Alert(title: Text("Are you sure you want to delete all notifications?"), primaryButton:  .destructive(Text(Constants.Button.yesText)) {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    
                }, secondaryButton: .default(Text(Constants.Button.noText)){
                })
            case .fourth:
                return Alert(title : Text("Notifications list is empty!"), message: Text("Please tap on + sign to create new notification"), dismissButton: .default(Text(Constants.Button.okText)))
            case .fifth:
                return Alert(title : Text("Notifications limit reached!"), message: Text("Please delete notifications to add new"), dismissButton: .default(Text(Constants.Button.okText)))
            
            case .zero:
                return Alert(title : Text("Alert"), dismissButton: .default(Text(Constants.Button.okText)))
                
            }
        }
        .sheet(isPresented: $showingAddNotificationSheet) {
            AddNotificationView()
        }
        .navigationBarItems(trailing: Button(action : {
            
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        UserDefaults.standard.set(true, forKey: "ActivateNotification")
                        self.showingAddNotificationSheet = true
                    } else if let error = error {
                        print(error.localizedDescription)
                        
                    } else {
                        UserDefaults.standard.set(false, forKey: "ActivateNotification")
                        self.notificationsActiveAlert = .second
                        self.notificationAlerts = true
                    }
                }
            
            
        }){
            Image(systemName: "plus")
        }.accessibility(label: Text(LocalizedStringKey("Add new Notification")))
        )
        .navigationBarTitle(LocalizedStringKey("Notifications"), displayMode: .inline)
    }
    //Function to remove individual items
    func delete( at offsets : IndexSet) {
        for offset in offsets {
            
            let notification = self.notificationResults[offset]
            
            moc.delete(notification)
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationResults[offset].id!.uuidString])
            
        }
        try? moc.save()
        
    }
    
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

