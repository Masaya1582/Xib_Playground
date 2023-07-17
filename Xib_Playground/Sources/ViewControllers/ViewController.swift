//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func takeAllScreenShot() -> UIImage {
        let width: CGFloat = UIScreen.main.bounds.size.width
        let height: CGFloat = UIScreen.main.bounds.size.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let screenShotImage = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("スクショ取得失敗")
        }
        UIGraphicsEndImageContext()
        return screenShotImage
    }

    private func takePortionScreenShot() -> UIImage {
        let width: CGFloat = imageView.bounds.size.width
        let height: CGFloat = imageView.bounds.size.height
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        guard let screenShotImage = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("スクショ取得失敗")
        }
        UIGraphicsEndImageContext()
        return screenShotImage
    }

    @IBAction func allScreenAction(_ sender: Any) {
        let image = takeAllScreenShot()
        let text = "画面全体のスクショだよ"
        let items = [text, image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true)
    }

    @IBAction func imageOnlyAction(_ sender: Any) {
        let image = takePortionScreenShot()
        let text = "画像だけのスクショだよ"
        let items = [text, image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true)
    }

}
