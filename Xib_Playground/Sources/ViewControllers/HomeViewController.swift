//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    @IBOutlet private weak var mapView: MKMapView!

    private let disposeBag = DisposeBag()
    // private let viewMoel = <#ViewModel名#>

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        bind(to: ())
    }

    // MapViewの初期設定
    private func setupMapView() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(onTap(sender:)))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        mapView.frame = view.bounds
        mapView.delegate = self
        view.addSubview(mapView)
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: mapView)
        let location = mapView.convert(tapPoint, toCoordinateFrom: mapView)
        let circle = MKCircle(center: location, radius: 10000)
        mapView.addOverlay(circle)
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {

    }
}

// MapViewDelegateの記述
extension HomeViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.strokeColor = .black
            circleRenderer.fillColor = .black
            circleRenderer.lineWidth = 1.5
            return circleRenderer
        }
        return MKOverlayRenderer()
    }

}
