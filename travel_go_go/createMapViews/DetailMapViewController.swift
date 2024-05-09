//
//  DetailMapViewController.swift
//  travel_go_go
//
//  Created by henry durrance on 04/01/2021.
//

import UIKit
import MapKit

class DetailMapViewController: UIViewController {

    var taskTapped = tasks()
    var proj = Projects()
    var MatchingItems : [MKMapItem] = []
    var selectedPlace : MKPlacemark? = nil
    var selecteditem = MKMapItem()
    
    @IBOutlet weak var MapView_Detail: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        MapView_Detail.delegate = self
        
        
      
        MapView_Detail.register(myAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
       
        
        let initaillocation = CLLocation(latitude: proj.task_list.location_latitude, longitude: proj.task_list.loction_longitude)
        centerMapOnLocation(location: initaillocation)
       
    }
    

    func setupUI(){
        
        let _annotation = myAnnotaion(tittle: proj.task_list.event_location, locationName: proj.task_list.address, disppline: "A", cordinates: CLLocationCoordinate2DMake(proj.task_list.location_latitude, proj.task_list.loction_longitude))
        
        MapView_Detail.addAnnotation(_annotation)
    }
    
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation (location : CLLocation){
        
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        MapView_Detail.setRegion(coordinateRegion, animated: true)
    }
    
    
    
  

    
   
    
   
    
    
}





//annotation configuration
extension DetailMapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
        return nil
    }
        
}
