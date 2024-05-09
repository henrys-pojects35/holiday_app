//
//  UpdateMapTableViewController.swift
//  travel_go_go
//
//  Created by henry durrance on 05/01/2021.
//

import UIKit
import MapKit

class UpdateMapTableViewController: UITableViewController {
    
    
    var MatchingItems : [MKMapItem] = []
    var mapView : MKMapView? = nil
    var handleMapSearchUpdateDelegate : HandleMapUpdateSearch? = nil
    var handleAddressUpdateDelegate : handle_Updateaddress? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }

    func parseAddress(selectedItem: MKPlacemark) ->String {
      
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " ": ""
        
        let comma = ( selectedItem != nil || selectedItem.thoroughfare != nil ) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", ": ""
        
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&  selectedItem.administrativeArea != nil) ? " ": ""
        
        
        let addressLine = String(format: "%@%@%@%@%@%@%@",
                                 //street number
                                 selectedItem.subThoroughfare ?? "",firstSpace,
                                 //Street number
                                 selectedItem.thoroughfare ?? "",comma,
                                 //city
                                 selectedItem.locality ?? "", secondSpace,
                                 //state
                                 selectedItem.administrativeArea ?? ""
                                 )
        
        return addressLine
        
    }
  
    
    
    

}






// MARK: - Extrnsion

extension UpdateMapTableViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else{ return }
       
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { ( response, error) in
            
            guard let response = response else {return}
            
            self.MatchingItems = response.mapItems
            self.tableView.reloadData()
            
        }
        
    }
    
}


extension UpdateMapTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int ) -> Int {
        
        
        return MatchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateCell")!
        
        let selectedItem = MatchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        
        return cell
    }
    
    
    
    //address that was tapped uses handlemap delegate to send data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let selectedItem = MatchingItems[indexPath.row].placemark
        handleMapSearchUpdateDelegate?.dropPinZoomIN(placemark: selectedItem)
       
        let selectedAddress = parseAddress(selectedItem: selectedItem)
        let longtude = selectedItem.coordinate.longitude
        let latitude = selectedItem.coordinate.latitude
        let LLocation = selectedItem.title
        
        
        
        handleAddressUpdateDelegate?.saving_location(location: LLocation! ,location_address: selectedAddress, lat: latitude, long: longtude)
        
        
       
        
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
}
