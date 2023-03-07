//
//  Characters.swift
//  HIMYM-Book
//
//  Created by Ecem Öztürk on 7.03.2023.
//

import UIKit

class Characters {
    var name : String
    var job : String
    var image : UIImage
    
    init(name: String, job: String, image: UIImage) {
        self.name = name
        self.job = job
        self.image = image
    }
}
