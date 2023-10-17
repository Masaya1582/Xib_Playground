//
//  NotificationViewController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/10/17.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var offerItemImageView: UIImageView!
    @IBOutlet weak var offerMoneyLabel: UILabel!
    @IBOutlet weak var offerCommentLabel: UILabel!
    
    func didReceive(_ notification: UNNotification) {
        if let validTitle = notification.request.content.userInfo["title"] as? String,
           let validDescription = notification.request.content.userInfo["description"] as? String,
           let validImageName = notification.request.content.userInfo["imageName"] as? String {
            offerMoneyLabel.text = validTitle
            offerCommentLabel.text = validDescription
            offerItemImageView.image = UIImage(named: validImageName)
        }
    }

}
