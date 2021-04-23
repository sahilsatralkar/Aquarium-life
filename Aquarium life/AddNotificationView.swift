//
//  AddNotificationView.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 21/01/21.
//

import SwiftUI
import AudioToolbox

struct AddNotificationView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationModeNotification
    
    @ObservedObject var textManager = TextFieldCharsManager()
    
    @State private var emptyLabelAlert = false
    
    let repetitionArray = ["Never","Everyday","Every Monday","Every Tuesday","Every Wednesday","Every Thursday","Every Friday","Every Saturday", "Every Sunday",
    // v1.3
        "Every 2 weeks","Every 3 weeks","Every 4 weeks","Every 60 days","Every 90 days"]
    //
    @State private var repetitionArraySelected : Int = 1
    
    @State private var setTime = Date()

    
    var body: some View {
        NavigationView{
        Form {
            Section {
                DatePicker(LocalizedStringKey("Time"), selection: $setTime, displayedComponents: .hourAndMinute)
                Picker("Repeat", selection: $repetitionArraySelected) {
                    ForEach(0 ..< repetitionArray.count) {
                        Text(LocalizedStringKey(self.repetitionArray[$0]))

                    }
                }
                .pickerStyle(DefaultPickerStyle())
                TextField(LocalizedStringKey("Label name"), text: $textManager.userName)
            }
            
        }
        .alert(isPresented: $emptyLabelAlert) {
            Alert(title: Text(LocalizedStringKey("Label is empty!")), message: Text(LocalizedStringKey("Please provide label name for notification")), dismissButton: .default(Text(Constants.Button.okText)))
        }
        .navigationBarTitle(LocalizedStringKey("Add Notification"), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationModeNotification.wrappedValue.dismiss()
        }) {
            Text(LocalizedStringKey("DismissButton"))
        } ,trailing: Button(action : {
            saveButton()
            
        }) {
            Text(LocalizedStringKey("SaveButton"))
        }
        )
        }
    }
    func saveButton(){
        if textManager.userName == Constants.emptyString {
            emptyLabelAlert = true
        } else {
            let content = UNMutableNotificationContent()
            content.title = textManager.userName
            
            content.sound = UNNotificationSound.default
            
            let uuid = UUID()
            
            let components = Calendar.current.dateComponents([.hour, .minute,.year,.weekdayOrdinal,.timeZone,.weekday], from: setTime)
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let year = components.year ?? 0
            let weekdayordinal = components.weekdayOrdinal
            let timezone = components.timeZone
            
            
            var date = DateComponents()
            date.hour = hour
            date.minute = minute
            date.year = year
            date.weekdayOrdinal = weekdayordinal
            date.timeZone = timezone
            
            var date2 = DateComponents()
            date2.hour = hour
            date2.minute = minute
            date2.timeZone = timezone
            
            
            //v1.3
            
            let presentDateTime = Date()
            let componentsPresentTime = Calendar.current.dateComponents([.hour, .minute], from: presentDateTime)
            let presentHour = componentsPresentTime.hour ?? 0
            let presentMinute = componentsPresentTime.minute ?? 0
            //let presentTimeZone = componentsPresentTime.timeZone
            
            //
            
            if repetitionArraySelected == 0 {
                date.weekday = components.weekday
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            } else if repetitionArraySelected == 1 {
                let trigger = UNCalendarNotificationTrigger(dateMatching: date2, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else if repetitionArraySelected == 2{
                date.weekday = 2
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }else if repetitionArraySelected == 3{
                date.weekday = 3
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }else if repetitionArraySelected == 4{
                date.weekday = 4
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
            else if repetitionArraySelected == 5{
                date.weekday = 5
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }else if repetitionArraySelected == 6{
                date.weekday = 6
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }else if repetitionArraySelected == 7{
                date.weekday = 7
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }else if repetitionArraySelected == 8{
                date.weekday = 1
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
            //v1.3
            
            //Every 2 weeks
            else if repetitionArraySelected == 9 {
                
                let timeInterval = Constants.TimeInSecs.thirteenDays
                    + (Double(hour) * Constants.TimeInSecs.sixtyMinutes)
                    + (Double(minute) * Constants.TimeInSecs.oneMinute)
                    - (Double(presentHour) * Constants.TimeInSecs.sixtyMinutes)
                    - (Double(presentMinute) * Constants.TimeInSecs.oneMinute)
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
            //Every 3 weeks
            else if repetitionArraySelected == 10 {
                
                let timeInterval = Constants.TimeInSecs.twentyDays
                    + (Double(hour) * Constants.TimeInSecs.sixtyMinutes)
                    + (Double(minute) * Constants.TimeInSecs.oneMinute)
                    - (Double(presentHour) * Constants.TimeInSecs.sixtyMinutes)
                    - (Double(presentMinute) * Constants.TimeInSecs.oneMinute)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
            //Every 4 weeks
            else if repetitionArraySelected == 11 {
                
                let timeInterval = Constants.TimeInSecs.twentySevenDays
                    + (Double(hour) * Constants.TimeInSecs.sixtyMinutes)
                    + (Double(minute) * Constants.TimeInSecs.oneMinute)
                    - (Double(presentHour) * Constants.TimeInSecs.sixtyMinutes)
                    - (Double(presentMinute) * Constants.TimeInSecs.oneMinute)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
            //Every 60 days
            else if repetitionArraySelected == 12 {
                
                let timeInterval = Constants.TimeInSecs.fiftyNineDays
                    + (Double(hour) * Constants.TimeInSecs.sixtyMinutes)
                    + (Double(minute) * Constants.TimeInSecs.oneMinute)
                    - (Double(presentHour) * Constants.TimeInSecs.sixtyMinutes)
                    - (Double(presentMinute) * Constants.TimeInSecs.oneMinute)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
            //Every 90 days
            else if repetitionArraySelected == 13 {
                
                let timeInterval = Constants.TimeInSecs.eightyNineDays
                    + (Double(hour) * Constants.TimeInSecs.sixtyMinutes)
                    + (Double(minute) * Constants.TimeInSecs.oneMinute)
                    - (Double(presentHour) * Constants.TimeInSecs.sixtyMinutes)
                    - (Double(presentMinute) * Constants.TimeInSecs.oneMinute)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
            }
            
            //
            
            let notification = Notifications(context: moc)
            notification.label = self.textManager.userName
            notification.id = uuid
            notification.date = Date()
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let formattedTime = formatter.string(from: setTime)
            notification.notificationDate = formattedTime
            
            notification.repeatNotifications = self.repetitionArray[repetitionArraySelected]
            
            try? self.moc.save()
            
            self.presentationModeNotification.wrappedValue.dismiss()
            
        }
    }
}

struct AddNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotificationView()
    }
}
