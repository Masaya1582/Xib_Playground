//
//  TabBarController.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2023/07/31.
//  Copyright (c) 2023 ReNKCHANNEL. All rihgts reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEachTabView()
    }

    // 各Tabのタイトル、アイコン画像を設定する
    private func setupEachTabView() {
        let homeViewController = HomeViewController()
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        homeViewController.tabBarItem = homeTabItem

        let driveViewController = DriveViewController()
        let driveTabItem = UITabBarItem(title: "Drive", image: UIImage(systemName: "car"), tag: 2)
        driveViewController.tabBarItem = driveTabItem

        let shoppingViewController = ShoppingViewController()
        let shoppingTabItem = UITabBarItem(title: "Shopping", image: UIImage(systemName: "bag"), tag: 3)
        shoppingViewController.tabBarItem = shoppingTabItem

        let settingViewController = SettingViewController()
        let settingTabItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        settingViewController.tabBarItem = settingTabItem

        self.viewControllers = [homeViewController, driveViewController, shoppingViewController, settingViewController]
    }

}
