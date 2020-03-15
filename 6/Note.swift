

import Foundation

class Note {

    var name: String
    var number: String
    var imagepath:String
    
    
    init(name: String, number: String,imagepath:String) {
        self.name = name
        self.number = number
        self.imagepath=imagepath
    }
    
    init() {
        self.name = ""
        self.number = ""
        self.imagepath=""
    }
}
