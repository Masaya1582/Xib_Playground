//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import ImageSlideshow

class HomeViewController: UIViewController {

    @IBOutlet private weak var imageSlideShow: ImageSlideshow!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageSlideShow()
    }

    // 表示する画像を設定する
    private func setupImageSlideShow() {
        imageSlideShow.setImageInputs([
            ImageSource(image: UIImage(named: "img_mukkorosu")!),
            ImageSource(image: UIImage(named: "img_betray")!),
            ImageSource(image: UIImage(named: "img_oppeke")!)
        ])
    }

}
