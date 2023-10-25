//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import UserNotifications

final class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var registerButton: DesignableButton!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerAction(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "通知だよ" // 通知タイトル
        content.body = "確認してね" // 通知内容
        content.sound = UNNotificationSound.default // 通知音
        // ローカル通知が発動するTrigger（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        // identifier, content, triggerからローカル通知を作成
        let identifier = "MyNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }

        // 未通知のローカル通知一覧をログ出力
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
            }
        }
        guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
        dateLabel.text = "\(hour)時\(minute)分に通知が届くよ！"
    }

}
