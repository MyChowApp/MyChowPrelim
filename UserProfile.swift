//
//  UserProfile.swift
//  MyChowPrelim
//
//  Created by Thanapon Sathirathiwat on 11/14/15.
//  Copyright © 2015 Thanapon Sathirathiwat. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

//This user class contains user information: name, dob, emal, goals, and their food options
class UserProfile: Object {
    dynamic var fullName: String? = nil
    dynamic var dob:String? = nil
    dynamic var email:String? = nil
    dynamic var goals: String? = nil
    dynamic var foodFilter: String? = nil
    
    required init() {
        super.init()
    }
    
    required override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    init(firstName: String, lastName: String, dob:String, email:String, goals:String, foodFilter:String) {
        
        if firstName != "" && lastName != ""{
            self.fullName = "\(firstName) \(lastName)"
        }else{
            if firstName == ""{
                self.fullName = lastName
            }
            if lastName == ""{
                self.fullName = firstName
            }
        }
        self.dob = dob
        self.email = email
        self.goals = goals
        self.foodFilter = foodFilter
        super.init()
    }
    
}