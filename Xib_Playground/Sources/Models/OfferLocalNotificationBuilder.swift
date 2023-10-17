//
//  OfferLocalNotificationBuilder.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UserNotifications

class OfferLocalNotificationBuilder {
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    private var notificationActions: [UNNotificationAction] = []
    private var notificationContent = UNMutableNotificationContent()

    func setActions() -> OfferLocalNotificationBuilder {
        notificationActions.append(
            UNNotificationAction(identifier: "view",
                                 title: "オファーを確認",
                                 options: [
                                    .foreground,
                                    .authenticationRequired
                                 ])
        )
        notificationActions.append(
            UNNotificationAction(identifier: "skip",
                                 title: "閉じる",
                                 options: [])
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
            "description": """
            Near the center of this sharp cosmic portrait, at the heart of the Orion Nebula, are four hot, massive
            stars known as the Trapezium. Gathered within a region about 1.5 light-years in radius, they dominate the
            core of the dense Orion Nebula Star Cluster. Ultraviolet ionizing radiation from the Trapezium stars,
            mostly from the brightest star Theta-1 Orionis C powers the complex star forming region's entire visible
            glow. About three million years old, the Orion Nebula Cluster was even more compact in its younger years
            and a recent dynamical study indicates that runaway stellar collisions at an earlier age may have formed
            a black hole with more than 100 times the mass of the Sun. The presence of a black hole within the cluster
            could explain the observed high velocities of the Trapezium stars. The Orion Nebula's distance of some
            1,500 light-years would make it the closest known black hole to planet Earth.
            """,
            "imageName": "macbook"
        ]
        return self
    }

    func build() {
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: "OfferItemPhoto",
            content: notificationContent,
            trigger: trigger
        )
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}
