//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import CropViewController

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var trimImageButton: UIButton!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: ())
    }

    // アルバムを開く
    private func setImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        trimImageButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.setImagePicker()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }

    // 加工画面を閉じて画像を表示する
    func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        imageView.image = image
        cropViewController.dismiss(animated: true, completion: nil)
    }

}

extension HomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }

        // CropViewControllerを初期化する。pickerImageを指定する。
        let cropController = CropViewController(croppingStyle: .default, image: pickerImage)
        cropController.delegate = self

        // AspectRatioのサイズをimageViewのサイズに合わせる。
        cropController.customAspectRatio = imageView.frame.size

        // 今回は使わない、余計なボタン等を非表示にする。
        //        cropController.aspectRatioPickerButtonHidden = true
        //        cropController.resetAspectRatioEnabled = false
        //        cropController.rotateButtonsHidden = true

        // cropBoxのサイズを固定する。
        cropController.cropView.cropBoxResizeEnabled = false

        // pickerを閉じたら、cropControllerを表示する。
        picker.dismiss(animated: true) {
            self.present(cropController, animated: true, completion: nil)
        }
    }

}
