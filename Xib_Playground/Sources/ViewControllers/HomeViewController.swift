//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import CLImageEditor
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var openAlbumButton: DesignableButton!
    @IBOutlet private weak var openCameraButton: DesignableButton!

    private let disposeBag = DisposeBag()
    private let viewModel: Dependency

    // MARK: - Initialize
    init(dependency: Dependency) {
        self.viewModel = dependency
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        openAlbumButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
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

// MARK: - CLImageEditorDelegate
extension HomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLImageEditorDelegate {
    // 写真を撮影 or 選択した時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
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

    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        // 編集が終了した時に呼ばれるメソッド(編集した画面を表示する)
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }

    // CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        // トップ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
