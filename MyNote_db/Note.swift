

import Foundation

class Note {

    var name: String
    var content: String

    init(name: String, content: String) {
        self.name = name
        self.content = content
    }

    init() {
        self.name = ""
        self.content = ""
    }
}
