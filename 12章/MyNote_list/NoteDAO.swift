

import Foundation

class NoteDAO {
    
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
        
        let fileManager = FileManager.default
        let dbexits = fileManager.fileExists(atPath: self.plistFilePath)
        if (!dbexits) {
            
            let frameworkBundle = Bundle(for: NoteDAO.self)
            let frameworkBundlePath = frameworkBundle.resourcePath as NSString?
            let defaultDBPath = frameworkBundlePath!.appendingPathComponent("NotesList.plist")
            
            do {
                try fileManager.copyItem(atPath: defaultDBPath, toPath: self.plistFilePath)
            } catch let error as NSError {
                print("数据保存错误：", error.localizedDescription)
                assert(false, "错误写入文件")
            }
        }
    }
    
    private func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = (documentDirectory[0] as NSString).appendingPathComponent("NotesList.plist")
        print("沙箱目录 ：", path)
        return path
    }

    //插入Note方法
    func create(_ model: Note) -> Int {
        
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        let strDate = self.dateFormatter.string(from: model.date as Date)
        let dict = NSDictionary(objects: [strDate, model.content], forKeys: ["date" as NSCopying, "content" as NSCopying])
        
        array.add(dict)
        array.write(toFile: self.plistFilePath, atomically: true)
        
        return 0
    }

    //删除Note方法
    func remove(_ model: Note) -> Int {
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date {
                array.remove(dict)
                array.write(toFile: self.plistFilePath, atomically: true)
                break
            }
        }
        return 0
    }

    //修改Note方法
    func modify(_ model: Note) -> Int {
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date {
                dict.setValue(model.content, forKey: "content")
                array.write(toFile: self.plistFilePath, atomically: true)
                break
            }
        }
        return 0
    }

    //查询所有数据方法
    func findAll() -> [Note] {
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        var listData = [Note]()
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            let note = Note(date: date, content: content)
            
            listData.append(note)
        }
        
        return listData
    }

    //按照主键查询数据方法
    func findById(_ model: Note) -> Note? {
        let array = NSMutableArray(contentsOfFile: self.plistFilePath)!
        
        for item in array {
            
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            //比较日期主键是否相等
            if date == model.date as Date {
                let note = Note(date: date, content: content)
                return note
            }
        }
        return nil
    }
}
