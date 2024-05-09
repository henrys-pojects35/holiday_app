//
//  CreateMapViewController.swift
//  travel_go_go
//
//  Created by henry durrance on 03/01/2021.
//

import UIKit
import MapKit

class CreateMapViewController: UIViewController  {
    

    @IBOutlet weak var MapView_create: MKMapView!
    var selectedPlace : MKPlacemark? = nil
    var Address : String = ""
    var latitude  = 0.0
    var longitude :Double  = 0.3
    var Location :String = ""
    
    var proj = Projects()
   
    
    @IBOutlet weak var SearchBar: UISearchBar!
    //map delegagte via storyboard already donee!!
     
    var resultSearchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView_create.delegate = self
        //MapView_create.showsUserLocation = true
        
       // MapView_create.register(myAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        

        
        
       // let intialLocation = CLLocation(latitude: 52.5926262, longitude: -0.7263919)
        
        //centerMapOnLocation(location: intialLocation)
        
     
        
        
        //set up search results table
        let locationSearchTable = storyboard!.instantiateViewController(identifier: "LocationSearchTabble") as! SearchMapTableViewController
        
        
      
           
        resultSearchController =  UISearchController(searchResultsController : locationSearchTable)
        
        resultSearchController?.searchResultsUpdater = locationSearchTable as! UISearchResultsUpdating
        
        
        
        locationSearchTable.mapView = MapView_create
        locationSearchTable.handleMapSearchDelegate = self
        locationSearchTable.handleAddressDelegate = self
       
        
        
        
        let seachBar = resultSearchController!.searchBar
        seachBar.sizeToFit()
        seachBar.placeholder = " search for places of intrest"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
   
    
    // MARK: - AddButton
    @IBAction func add_buttonTapped(_ sender: Any) {
        
      
        
        proj.task_list.location_latitude = latitude
        proj.task_list.loction_longitude = longitude
        proj.task_list.event_location = Location
        proj.task_list.address = Address
        
        
        performSegue(withIdentifier: "send_location", sender: proj)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let task_form_controller = segue.destination as? CreateTaskViewController{
            
            if let location_name = (sender) as? Projects{
                
               
                task_form_controller.proj = location_name
                
            }
        }
    
    }
    
    
    
    
    
    
    
        
    
    
    
    //helper function that gets the intial location and centers the map arounf that point
    //region is area of screen visible to the user
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location : CLLocation){
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        MapView_create.setRegion(coordinateRegion, animated: true)
    }
   

}

//annotation configuration
extension CreateMapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
        return nil
    }
        
}
   


protocol  HandleMapSearch {
    
    func dropPinZoomIN(placemark: MKPlacemark)
}


protocol handle_address {
    
    func saving_location(location: String ,location_address: String, lat: Double, long: Double)
}




extension CreateMapViewController : HandleMapSearch
{
    func dropPinZoomIN(placemark: MKPlacemark) {
        
        //cache pin
        selectedPlace = placemark
        //clear existing pin
        MapView_create.removeAnnotations(MapView_create.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        if let city = placemark.locality,
        let area = placemark.administrativeArea
        {
            annotation.subtitle = "\(city) \(area)"
        }
        
        MapView_create.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        MapView_create.setRegion(region, animated: true)
        
        
       
        
    }
    
}
    
extension CreateMapViewController : handle_address{
        
    func saving_location(location : String ,location_address: String,lat: Double, long: Double){
            
            Location = location
            Address = location_address
            latitude = lat
            longitude = long
        }
        
        
    }



    


