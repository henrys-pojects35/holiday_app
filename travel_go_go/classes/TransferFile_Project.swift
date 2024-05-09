//
//  TransferFile_Project.swift
//  travel_go_go
//
//  Created by henry durrance on 05/01/2021.
//

import Foundation


class TransferFile_Project {
    
    
    var chosen_task = tasks()
    
    var chosenProject = Projects()
    
    
    init(){}
    
    
    init(task: tasks, projects: Projects) {
        
        chosen_task = task
        chosenProject = projects
        
    }
    
}
