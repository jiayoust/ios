

import Foundation

class Note {

    var date: Date
    var content: String

    init(date: Date, content: String) {
        self.date = date
        self.content = content
    }

    init() {
        self.date = Date()
        self.content = ""
    }
}
