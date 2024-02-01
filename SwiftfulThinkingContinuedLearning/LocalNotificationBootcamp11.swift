//
//  LocalNotificationBootcamp11.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 19.07.2023.
//

import SwiftUI
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAutorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success", success)
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was so easy"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 1
        dateComponents.minute = 30
        dateComponents.weekday = 1     // можно добавлять помимо дня недели и другие компоненты времени
        
//        var trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00,
                                                longitude: 50.00)
        
        let region = CLCircularRegion(center: coordinates,
                                      radius: 100,
                                      identifier: UUID().uuidString)
        region.notifyOnExit = true
        region.notifyOnEntry = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()  // удаляем все запланированные нотификации
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()       // удаляем все нотификации с центра уведомлений(со шторки)
    }
}

struct LocalNotificationBootcamp11: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permision") {
                NotificationManager.instance.requestAutorization()
            }
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0  // если добавляем badge то надо его удалить при открытии приложения
        }
    }
}

struct LocalNotificationBootcamp11_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp11()
    }
}
