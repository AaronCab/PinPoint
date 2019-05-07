//
//  MapViewController.swift
//  PinPoint
//
//  Created by Aaron Cabreja on 5/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    private var locationManager = CLLocationManager()
    private var previousLocation: CLLocation?
    var directions = [MKDirections]()
    
    //private var longPress: UILongPressGestureRecognizer!
    public var venues: [EventCreatedByUser]!
    
    private var annotations = [MKAnnotation]()
    
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapView.delegate = self
        self.view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        title = "My Map"
        view.addSubview(mapView)
        checkLocationServices()
        makeAnnotations()
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorized()
        } else {
            showAlert(title: "Error Message", message: "Turn on your locations, please.")
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        
    }
    
    private func checkLocationAuthorized() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
        
    }
    
    
    private func startTrackingUserLocation() {
        mapView.mapView.showsUserLocation = true
                if let location = locationManager.location?.coordinate {
                    setAndCenterRegionOnMap(coordiate: location, meters: 5000)
                }
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView.mapView)
        
        
    }
}

extension MapViewController {
    private func setAndCenterRegionOnMap(coordiate: CLLocationCoordinate2D, meters: Double) {
        let region = MKCoordinateRegion.init(center: coordiate, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.mapView.setRegion(region, animated: true)
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        return CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    }
    
    private func makeAnnotations() {
        mapView.mapView.removeAnnotations(annotations)
        annotations.removeAll()
        for venue in venues {
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D.init(latitude: (venue.lat), longitude: venue.long)
            annotation.coordinate = coordinate
            annotation.title = venue.displayName
            self.annotations.append(annotation)
        }
        mapView.mapView.showAnnotations(self.annotations, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorized()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let index = annotations.firstIndex { $0.title == view.annotation!.title }
        let selectedVenue = venues[index!]
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let directions = UIAlertAction(title: "Get Directions", style: .default) { (action) in
            guard let userLocation = self.locationManager.location?.coordinate,
                let destination = view.annotation?.coordinate else {
                    guard let venueLat = self.venues.first?.lat,
                        let venueLong = self.venues?.first?.long else {return}
                    let coordinate = CLLocationCoordinate2DMake(venueLat,venueLong)
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                    mapItem.name = "Target location"
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                    return
            }
            self.getDirections(from: userLocation, destination: destination)
        }
//        let segue = UIAlertAction(title: "Venue Info", style: .default) { (action) in
//            let detailVC = DiscoverViewController()
//            detailVC.discoverVie = selectedVenue
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(directions)
//        actionSheet.addAction(segue)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func getDirections(from: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = createDirectionsRequest(fromCoordinate: from, toDestination: destination)
        let directions = MKDirections(request: request)
        let url = "http://maps.apple.com/maps?saddr=\(from.latitude),\(from.longitude)&daddr=\(destination.latitude),\(destination.longitude)"
        UIApplication.shared.openURL(URL(string:url)!)
       // resetMapView(newDirections: directions)
        
        directions.calculate { [unowned self] (response, error) in
            if let error = error {
                print("Can't get directions: \(error)")
                self.showAlert(title: "Can't get Directions", message: "\(error)" )
            } else if let response = response {
                for route in response.routes {
                                        // extra TODO: show directions word
                    var stepsStr = ""
                    let steps = route.steps
                    steps.forEach { stepsStr += "\($0.instructions)\n" }
                    self.mapView.mapView.addOverlay(route.polyline)
                    self.mapView.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    self.showAlert(title: "Directions", message: stepsStr)
                    break
                }
            }
        }
    }
    
    private func createDirectionsRequest(fromCoordinate: CLLocationCoordinate2D, toDestination: CLLocationCoordinate2D) -> MKDirections.Request {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: fromCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toDestination))
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        return request
    }
    
    private func resetMapView(newDirections: MKDirections) {
        directions = [MKDirections]()
        mapView.mapView.removeOverlays(mapView.mapView.overlays)
        directions.append(newDirections)
        let _ = directions.map { $0.cancel() }
    }
    


}
