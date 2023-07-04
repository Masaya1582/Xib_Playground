//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonView: UIImageView {}

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    private let snorlaxView = PokemonView()
    private let slowpokeView = PokemonView()
    private let dittoView = PokemonView()

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        bind(to: ())
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchevent = touches.first, let pokemonView = touchevent.view as? PokemonView else {
            return
        }
        let previousLocation = touchevent.previousLocation(in: view)
        let nextLocation = touchevent.location(in: view)
        let deltaX = nextLocation.x - previousLocation.x
        let deltaY = nextLocation.y - previousLocation.y
        pokemonView.frame.origin.x += deltaX
        pokemonView.frame.origin.y += deltaY
    }

    private func addViews() {
        // Orange
        snorlaxView.image = Asset.Assets.imgOrange.image
        snorlaxView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        snorlaxView.isUserInteractionEnabled = true
        // snorlaxView.backgroundColor = .lightGray
        view.addSubview(snorlaxView)

        let snorlaxInteraction = UIContextMenuInteraction(delegate: self)
        snorlaxView.addInteraction(snorlaxInteraction)

        // Pineapple
        slowpokeView.image = Asset.Assets.imgPineapple.image
        slowpokeView.frame = CGRect(x: 250, y: 100, width: 100, height: 100)
        slowpokeView.isUserInteractionEnabled = true
        // slowpokeView.backgroundColor = .lightGray
        view.addSubview(slowpokeView)

        let slowpokeInteraction = UIContextMenuInteraction(delegate: self)
        slowpokeView.addInteraction(slowpokeInteraction)

        // Strawberry
        dittoView.image = Asset.Assets.imgStrawberry.image
        dittoView.frame = CGRect(x: 100, y: 250, width: 100, height: 100)
        dittoView.isUserInteractionEnabled = true
        // dittoView.backgroundColor = .lightGray
        view.addSubview(dittoView)

        let dittoInteraction = UIContextMenuInteraction(delegate: self)
        dittoView.addInteraction(dittoInteraction)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}

extension HomeViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            let fight = UIAction(title: "FIGHT", image: UIImage(systemName: "figure.wave")) { action in
                print("fight")
            }
            let bag = UIAction(title: "BAG", image: UIImage(systemName: "bag")) { action in
                print("bag")
            }
            let pokemon = UIAction(title: "POKEMON", image: UIImage(systemName: "hare")) { action in
                print("pokemon")
            }
            let run = UIAction(title: "RUN", image: UIImage(systemName: "figure.walk")) { action in
                print("run")
            }
            return UIMenu(title: "Menu", children: [fight, bag, pokemon, run])
        })
    }
}
