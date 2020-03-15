
import Foundation

class NoteDAO {
    //保存数据列表
    var listData = [Note]()
    
    static let sharedInstance: NoteDAO = {
        
        let instance = NoteDAO()
        
        //添加一些测试数据
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1: Date = dateFormatter.date(from: "2017-01-01 16:01:03")!
        let note1: Note = Note(date: date1, content: "Welcome to MyNote.")
        
        let date2: Date = dateFormatter.date(from: "2017-01-02 8:01:03")!
        let note2: Note = Note(date: date2, content: "欢迎使用MyNote。")
        
        instance.listData.append(note1)
        instance.listData.append(note2)
        
        return instance
    }()
    
    
    //插入Note方法
    func create(_ model: Note) -> Int {
        self.listData.append(model)
        return 0
    }
    
    //删除Note方法
    func remove(_ model: Note) -> Int {
        for (index, note) in self.listData.enumerated() {
            //比较日期主键是否相等
            if note.date == model.date {
                self.listData.remove(at: index)
                break
            }
        }
        return 0
    }
    
    //修改Note方法
    func modify(_ model: Note) -> Int {
        for (index, note) in self.listData.enumerated() {
            //比较日期主键是否相等
            if note.date == model.date {
                note.content = model.content
                self.listData[index] = note
                break
            }
        }
        return 0
    }
    
    //查询所有数据方法
    func findAll() -> [Note] {
        return self.listData
    }
    
    //按照主键查询数据方法
    func findById(_ model: Note) -> Note? {
        for note in self.listData {
            //比较日期主键是否相等
            if note.date == model.date {
                return note
            }
        }
        return nil
    }
    
}

