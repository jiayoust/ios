

import Foundation

class NoteBL {

    //插入Note方法
    func create(_ model: Note) ->  [Note] {
        let dao: NoteDAO = NoteDAO.sharedInstance
        dao.create(model)
        return dao.findAll()
    }

    //删除Note方法
    func remove(_ model: Note) ->  [Note] {
        let dao: NoteDAO = NoteDAO.sharedInstance
        dao.remove(model)
        return dao.findAll()
    }

    //查询所用数据方法
    func findAll() ->  [Note] {
        let dao: NoteDAO = NoteDAO.sharedInstance
        return dao.findAll()
    }

}
