

import Foundation

class Note {

    var name: String
    var telno: String

    init(name: String, number: String) {
        self.name = name
        self.telno = number
    }

    init() {
        self.name = ""
        self.telno = ""
    }
}
