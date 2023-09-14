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
    @IBOutlet private weak var showMyLocationButton: UIButton!
    @IBOutlet private weak var mapKitView: MKMapView!

    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        bind(to: ())
    }

    private func setupMapView() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

}

// MARK: - Bindings
private extension HomeViewController {
    func bind(to dependency: Dependency) {
        showMyLocationButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.locationManager.requestLocation()
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if let error = error {
                print("reverseGeocodeLocation Failed: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                var locationInformation = ""
                locationInformation += "Latitude: \(location.coordinate.latitude)\n"
                locationInformation += "Longitude: \(location.coordinate.longitude)\n\n"
                locationInformation += "Country: \(placemark.country ?? "")\n"
                locationInformation += "State/Province: \(placemark.administrativeArea ?? "")\n"
                locationInformation += "City: \(placemark.locality ?? "")\n"
                locationInformation += "PostalCode: \(placemark.postalCode ?? "")\n"
                locationInformation += "Name: \(placemark.name ?? "")"
            }
        })

        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapKitView.setRegion(coordinateRegion, animated: true)

        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = "ここにいるよ!"
        pointAnnotation.coordinate = location.coordinate

        mapKitView.removeAnnotations(mapKitView.annotations)
        mapKitView.addAnnotation(pointAnnotation)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

}
