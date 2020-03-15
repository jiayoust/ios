
import Foundation

class EventsBL {
    
   //查询所有数据方法
    func readData() -> [Events] {
        let dao = EventsDAO.sharedInstance
        let list  = dao.findAll()
        return list
    }
}
