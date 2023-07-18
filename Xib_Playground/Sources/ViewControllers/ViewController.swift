//
//  ViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet private weak var locationLabel: UILabel!

    private var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func getCurrentLocation() {
        // 緯度、経度表示用のラベル
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied:
            print("It's denied")
        case .notDetermined:
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager?.startUpdatingLocation()
        default:
            break
        }
    }

    @IBAction func getCurrentLocationAction(_ sender: Any) {
        getCurrentLocation()
    }

}

extension ViewController: CLLocationManagerDelegate {
    // 緯度経度が変更された時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        guard let latitude = location?.coordinate.latitude else { return }
        guard let longitude = location?.coordinate.longitude else { return }
        print("Latitude: \(latitude)\nLongitude: \(longitude)")
        locationLabel.text = "Latitude: \(latitude)\nLongitude: \(longitude)"
    }

}
