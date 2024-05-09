//
//  UpdateMapViewController.swift
//  travel_go_go
//
//  Created by henry durrance on 05/01/2021.
//

import UIKit
import MapKit
class UpdateMapViewController: UIViewController {
    
    
    
    @IBOutlet weak var MapView_Update: MKMapView!
    
    var selectedPlace : MKPlacemark? = nil
    var Address : String = ""
    var latitude  = 0.0
    var longitude :Double  = 0.3
    var Location :String = ""
    
    var proj = Projects()
    
    
    var resultSearchController: UISearchController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        MapView_Update.delegate = self
        
        
        //set up search results table
        let locationSearchUpdateTable = storyboard!.instantiateViewController(identifier: "UpdateSearchTabble") as! UpdateMapTableViewController
        
        
      
           
        resultSearchController =  UISearchController(searchResultsController : locationSearchUpdateTable)
        
        resultSearchController?.searchResultsUpdater = locationSearchUpdateTable as! UISearchResultsUpdating
        
        
        
        locationSearchUpdateTable.mapView = MapView_Update
    
        locationSearchUpdateTable.handleMapSearchUpdateDelegate = self
        locationSearchUpdateTable.handleAddressUpdateDelegate = self
       
        
        
        
        let seachBar = resultSearchController!.searchBar
        seachBar.sizeToFit()
        seachBar.placeholder = " search for places of intrest"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
    

  
    
    
    @IBAction func UpdateMapTapped(_ sender: Any) {
        
        
        
        
        proj.task_list.location_latitude = latitude
        proj.task_list.loction_longitude = longitude
        proj.task_list.event_location = Location
        proj.task_list.address = Address
       
        performSegue(withIdentifier: "sendUpdatedLocation", sender: proj)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let task_detail_controller = segue.destination as? TaskUpdateiewController{
            
            if let selected_project = (sender) as? Projects{
                
               
                task_detail_controller.proj = selected_project
                
            }
        }
    }
    
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location : CLLocation){
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        MapView_Update.setRegion(coordinateRegion, animated: true)
    }

}



//annotation configuration
extension UpdateMapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
        return nil
    }
        
}
   


protocol  HandleMapUpdateSearch {
    
    func dropPinZoomIN(placemark: MKPlacemark)
}


protocol handle_Updateaddress {
    
    func saving_location(location: String ,location_address: String, lat: Double, long: Double)
}




extension UpdateMapViewController : HandleMapUpdateSearch
{
    func dropPinZoomIN(placemark: MKPlacemark) {
        
        //cache pin
        selectedPlace = placemark
        //clear existing pin
        MapView_Update.removeAnnotations(MapView_Update.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        if let city = placemark.locality,
        let area = placemark.administrativeArea
        {
            annotation.subtitle = "\(city) \(area)"
        }
        
        MapView_Update.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        MapView_Update.setRegion(region, animated: true)
        
        
       
        
    }
    
}
    
extension UpdateMapViewController : handle_Updateaddress{
        
    func saving_location(location : String ,location_address: String,lat: Double, long: Double){
            
            Location = location
            Address = location_address
            latitude = lat
            longitude = long
        }
        
        
    }



    


