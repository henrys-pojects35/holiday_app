//
//  tasks.swift
//  travel_go_go
//
//  Created by henry durrance on 28/12/2020.
//

import Foundation

class tasks{
    
    var  Event_id : String = ""
    
    var event_rating : Float = 0.0
    
    var  Event_name : String = ""
    
    var  event_location : String = ""
    
    var event_begin: String = ""
    
    var event_end: String = ""
    
    var event_status : String = ""
    
    var address : String  = ""
    var location_latitude : Double = 0.000000
    
    var loction_longitude : Double = 0.0000000
    
    var projectId = ""
    
    init() {
        
    }
    
    
    
    init(name : String , begins : String , ends : String , id : String , rate : Float , stat : String , location : String ,addres : String , lat : Double , long : Double) {
        
        Event_name = name
        event_begin = begins
        event_end = ends
        event_rating = rate
        Event_id = id
        event_status = stat
        event_location = location
        address = addres
        location_latitude = lat
        loction_longitude = long
        
    }
    
    
}
