//
//  Retrieve.swift
//  Jabeerah
//
//  Created by Mariah Sami Khayat on 9/9/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import Foundation

class Retrieve: NSObject {
    var name: String
    var phone: Int
    var city: String
 // var image: UIImage
    
    init?(name: String, phone: Int, city: String /*, image: UIImage*/) {
        self.name = name
        self.phone = phone
       // self.image = image
        self.city = city
        super.init()
      
}

}