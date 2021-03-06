

import Foundation

class NoteDAO {
    
    let DBFILE_NAME = "NotesList1.sqlite3"
    var db: OpaquePointer? = nil
    
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    //私有的沙箱目录中属性列表文件路径
    private var plistFilePath: String!

    static let sharedInstance: NoteDAO = {
        
        let instance = NoteDAO()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()

        return instance
    }()

    
    //初始化属性列表文件
    private func createEditableCopyOfDatabaseIfNeeded() {
        
        let writableDBPath = self.applicationDocumentsDirectoryFile()
        let cpath = writableDBPath.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "CREATE TABLE IF NOT EXISTS Note (name TEXT PRIMARY KEY, number TEXT,imagepath TEXT)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            if sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK {
                sqlite3_close(db)
                assert(false, "建表失败。")
            }
            sqlite3_close(db)
        }
    }
    
    private func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = (documentDirectory[0] as NSString).appendingPathComponent(DBFILE_NAME)
        print("沙箱目录 ：", path)
        return path
    }

    //插入Note方法
    func create(_ model: Note) -> Int {
        
        let path = self.applicationDocumentsDirectoryFile()
        let cpath = path.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "INSERT OR REPLACE INTO note (name, number, imagepath) VALUES (?,?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                

                
                let name = model.name.cString(using: String.Encoding.utf8)
                
                let number = model.number.cString(using: String.Encoding.utf8)
                let imagepath = model.imagepath.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, name!, -1, nil)
                sqlite3_bind_text(statement, 2, number!, -1, nil)
                sqlite3_bind_text(statement, 3, imagepath!, -1, nil)

                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false, "插入数据失败。")
                }

            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        return 0
    }

    //删除Note方法
    func remove(_ model: Note) -> Int {
        
        let path = self.applicationDocumentsDirectoryFile()
        let cpath = path.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "DELETE from note where name =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {

                let name = model.name.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, name!, -1, nil)
                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false, "删除数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }

    //修改Note方法
    func modify(_ model: Note) -> Int {
        
        let path = self.applicationDocumentsDirectoryFile()
        let cpath = path.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "UPDATE note set name=? where number =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let name = model.name.cString(using: String.Encoding.utf8)
                let number = model.number.cString(using: String.Encoding.utf8)
                //绑定参数开始
                sqlite3_bind_text(statement, 1, name!, -1, nil)
                sqlite3_bind_text(statement, 2, number!, -1, nil)
                
                //执行插入
                if sqlite3_step(statement) != SQLITE_DONE {
                    assert(false, "修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }

    //查询所有数据方法
    func findAll() -> [Note] {
        
        var listData = [Note]()
        
        let path = self.applicationDocumentsDirectoryFile()
        let cpath = path.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            assert(false, "数据库打开失败。")
        } else {
            let sql = "SELECT name,number,imagepath FROM Note"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            //语句对象
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                //执行查询
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let note = Note()
                    if let name = getColumnValue(index:0, stmt:statement!) {
                        //let date : Date = self.dateFormatter.date(from: strDate)!
                        note.name = name                    }
                    if let number = getColumnValue(index:1, stmt:statement!) {
                        note.number = number
                    }
                    if let imagepath = getColumnValue(index:2, stmt:statement!) {
                        note.imagepath = imagepath
                    }
                    listData.append(note)                }
                
                sqlite3_finalize(statement)
                sqlite3_close(db)
                
                return listData
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return listData
    }

    //按照主键查询数据方法
    func findById(_ model: Note) -> Note? {

        let path = self.applicationDocumentsDirectoryFile()
        let cpath = path.cString(using: String.Encoding.utf8)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            assert(false, "数据库打开失败。")
        } else {
            let sql = "SELECT name,number,imagepath FROM Note where name =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement: OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                //准备参数
                //let strDate = self.dateFormatter.string(from: model.date as Date)
                //let cDate = strDate.cString(using: String.Encoding.utf8)
                let name = model.name.cString(using: String.Encoding.utf8)

                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, name!, -1, nil)
                
                //执行查询
                if sqlite3_step(statement) == SQLITE_ROW {
                    
                    let note = Note()
                    if let strDate = getColumnValue(index:0, stmt:statement!) {
                        //let date : Date = self.dateFormatter.date(from: strDate)!
                        note.name = strDate
                    }
                    if let strContent = getColumnValue(index:1, stmt:statement!) {
                        note.number = strContent
                    }
                    if let imagepath = getColumnValue(index:2, stmt:statement!) {
                        note.imagepath = imagepath
                    }
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return note
                }
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(db)
        return nil
        
    }
    
    //获得字段数据
    private func getColumnValue(index:CInt, stmt:OpaquePointer)->String? {
        
        if let ptr = UnsafeRawPointer.init(sqlite3_column_text(stmt, index)) {
            let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
            let txt = String(validatingUTF8:uptr)
            return txt
        }
        return nil
    }
    
}
