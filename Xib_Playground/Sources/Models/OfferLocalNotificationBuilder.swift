//
//  OfferLocalNotificationBuilder.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation
import UserNotifications

class OfferLocalNotificationBuilder {
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    private var notificationActions: [UNNotificationAction] = []
    private var notificationContent = UNMutableNotificationContent()

    func setActions() -> OfferLocalNotificationBuilder {
        notificationActions.append(
            UNNotificationAction(identifier: "view", title: "オファーを確認", options: [.foreground, .authenticationRequired])
        )
        notificationActions.append(
            UNNotificationAction(identifier: "skip", title: "閉じる", options: [])
        )
        return self
    }

    func setCategory() -> OfferLocalNotificationBuilder {
        let notificationCategory = UNNotificationCategory(
            identifier: "OfferItemPhoto",
            actions: notificationActions,
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )
        notificationCenter.setNotificationCategories(
            [notificationCategory]
        )
        return self
    }

    func setContent() -> OfferLocalNotificationBuilder {
        notificationContent.title = "オファーが届きました!"
        notificationContent.body = "ロングタップで確認する"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.categoryIdentifier = "OfferItemPhoto"
        notificationContent.userInfo = [
            "title": "12,000円",
            "description": "とても良い状態ですね、ぜひ当店にお売りください。",
            "imageName": "macbook"
        ]
        return self
    }

    func build() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "OfferItemPhoto", content: notificationContent, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}
