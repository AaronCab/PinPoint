//
//  LocationResultController.swift
//  PinPoint
//
//  Created by Jason on 4/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
import MapKit

protocol LocationResultsControllerDelegate: AnyObject {
    func didSelectCoordinate(_ locationResultsController: LocationResultController, coordinate: CLLocationCoordinate2D)
    func didScrollTableView(_ locationResultsController: LocationResultController)
}
protocol LocationString {
    func getString(address: String)
}
class LocationResultController: UIViewController{
    var delegate2: LocationString?
    var locationView = LocationView()
    
    private let searchCompleter = MKLocalSearchCompleter()
    private var completerResults = [MKLocalSearchCompletion]()
    
    weak var delegate: LocationResultsControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(locationView)
        locationView.locationTableView.dataSource = self
        locationView.locationTableView.delegate = self
        searchCompleter.delegate = self
    }
}

extension LocationResultController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let suggestion = completerResults[indexPath.row]
        // Each suggestion is a MKLocalSearchCompletion with a title, subtitle
        
        cell.textLabel?.text = suggestion.title
        cell.detailTextLabel?.text = suggestion.subtitle
        cell.backgroundColor = .white
        
        
        return cell
    }
}

extension LocationResultController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = completerResults[indexPath.row]
        let addressString = suggestion.title.isEmpty ? suggestion.subtitle : suggestion.title
        print(addressString)
        LocationService.getCoordinate(addressString: addressString) { (coordinate, error) in
            if let error = error {
                print("error getting coordinate: \(error)")
            } else {
                print(coordinate)
                self.delegate?.didSelectCoordinate(self, coordinate: coordinate)
            }
        }
        self.delegate2?.getString(address: addressString)
        dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension LocationResultController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Ask `MKLocalSearchCompleter` for new completion suggestions based on the change in the text entered in `UISearchBar`.
        searchCompleter.queryFragment = searchController.searchBar.text ?? ""
    }
}

extension LocationResultController: MKLocalSearchCompleterDelegate {
    /// - Tag: QueryResults
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        // Overwrite the existing results, and then refresh the UI with the new results.
        completerResults = completer.results
        locationView.locationTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // Handle any errors returned from MKLocalSearchCompleter.
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription)")
        }
    }
}

extension LocationResultController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScrollTableView(self)
        
    }
}
