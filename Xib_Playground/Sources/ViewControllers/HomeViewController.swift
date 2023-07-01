//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import CLImageEditor

class HomeViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var openAlbumButton: UIButton!
    @IBOutlet private weak var openCameraButton: UIButton!

    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }

    private func setupView() {
        // imageViewに何も入っていない時には一定の画像を表示する
        if imageView.image == nil {
            imageView.image = UIImage(named: "img_no_image")
        }
    }

}

private extension HomeViewController {
    func bind() {
        openAlbumButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // ライブラリ(カメラロール) を指定してピッカーを開く
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let pickerController = UIImagePickerController()
                    pickerController.delegate = self
                    pickerController.sourceType = .photoLibrary
                    self?.present(pickerController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)

        openCameraButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                // カメラを指定してピッカーを開く
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let pickerController = UIImagePickerController()
                    pickerController.delegate = self
                    pickerController.sourceType = .camera
                    self?.present(pickerController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLImageEditorDelegate {
    // 写真を撮影 or 選択した時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            // あとでCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            // CLImageEditorにimageを渡して、加工画面を起動する
            guard let editor = CLImageEditor(image: image) else { return }
            editor.delegate = self
            editor.modalPresentationStyle = .fullScreen
            picker.present(editor, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 編集画面から離れる
        self.dismiss(animated: true, completion: nil)
    }

    func imageEditor(_ editor: CLImageEditor?, didFinishEditingWith image: UIImage?) {
        // 編集が終了した時に呼ばれるメソッド(編集した画面を表示する)
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }

    // CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor?) {
        // トップ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }

}
