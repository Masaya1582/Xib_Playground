// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import RxDataSources
import Action

struct President {
    var name: String
    var description: String
    var image: UIImage

    init(name: String, description: String, image: UIImage) {
        self.name = name
        self.description = description
        self.image = image
    }
}

protocol HomeViewModelInputs: AnyObject {
}

protocol HomeViewModelOutputs: AnyObject {
    var listItem: Driver<[HomeViewModel.ListItem]> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    // MARK: - Input Sources
    // MARK: - Output Sources
    let listItem: Driver<[ListItem]>

    // MARK: - Properties
    private let presidentArray: [President] = [
        President(name: "George Washington", description: "The First President", image: Asset.Assets.imgGeorgeW.image),
        President(name: "Abraham Lincoln", description: "Emancipator and Union Preserver", image: Asset.Assets.imgDonald.image),
        President(name: "Franklin D. Roosevelt", description: "New Deal Leader", image: Asset.Assets.imgJimmy.image),
        President(name: "John F. Kennedy", description: "Ask Not What Your Country Can Do For You", image: Asset.Assets.imgGeorgeW.image),
        President(name: "Ronald Reagan", description: "The Great Communicator", image: Asset.Assets.imgRonald.image),
        President(name: "Barack Obama", description: "Change We Can Believe In", image: Asset.Assets.imgBarack.image)
    ]
    private let _listItem = BehaviorRelay<[HomeViewModel.ListItem]>(value: [])
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        let presidentContent = presidentArray.map { ListItem.content($0) }
        let presidentListItem = [ListItem.header] + presidentContent + [ListItem.footer]
        _listItem.accept(presidentListItem)
        self.listItem = _listItem.asDriver(onErrorDriveWith: .empty())
    }

}

extension HomeViewModel {
    enum ListItem {
        case header
        case content(President)
        case footer
    }
}
