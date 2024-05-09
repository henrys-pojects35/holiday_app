//
//  Projects.swift
//  travel_go_go
//
//  Created by henry durrance on 28/12/2020.
//

import Foundation
import Firebase
import FirebaseAuth

class Projects {
    
    var project_name = ""
    
    
   

    
    
    var  begin = ""
    
    var end = ""
    
    var project_id = ""
    
    var rating : Float = 0
    
    var status = ""
    
    var task_list = tasks()
    
    init() {
        
    }
    
    init(name : String , begins : String , ends : String , id : String , rate : Float , stat : String) {
        
        project_name = name
        begin = begins
        end = ends
        rating = rate
        project_id = id
        status = stat
        
    }
    
    
   
}

    
    

