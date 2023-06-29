//
//  SceneDelegate.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        // 追記 -----ここから (NavigationControllerを使用する場合)
//        window = UIWindow(windowScene: scene as! UIWindowScene)
//        window?.makeKeyAndVisible()
//        let <#名前#>ViewController = <#ファイル名#>()
//        let rootViewController = UINavigationController(rootViewController: <#名前#>ViewController)
//        window?.rootViewController = rootViewController
        // 追記 -----ここまで

        // 追記 -----ここから (NavigationControllerを使用しない場合)
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.makeKeyAndVisible()
        let homeViewController = HomeViewController()
        window?.rootViewController = homeViewController
        // 追記 -----ここまで
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

