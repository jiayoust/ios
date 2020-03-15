

import Foundation

class ScheduleBL {
    
    //查询所有数据方法
    func readData() -> [String : [Schedule]] {
  
        let scheduleDAO = ScheduleDAO.sharedInstance
        let schedules  = scheduleDAO.findAll()
        var resDict = [String : [Schedule]]()
        
        let eventsDAO = EventsDAO.sharedInstance
        
        //延迟加载Events数据
        for schedule in schedules {
            
            let event = eventsDAO.findById(schedule.Event!)
            schedule.Event = event
            
            let allkey = resDict.keys
            
            //把数组结构转化为字典结构
            if allkey.contains(schedule.GameDate!) {
                var value = resDict[schedule.GameDate!]
                value?.append(schedule)
                resDict[schedule.GameDate!] = value
            } else {
                var value = [Schedule]()
                value.append(schedule)
                resDict[schedule.GameDate!] = value
            }
        }
        return resDict
    }
}
