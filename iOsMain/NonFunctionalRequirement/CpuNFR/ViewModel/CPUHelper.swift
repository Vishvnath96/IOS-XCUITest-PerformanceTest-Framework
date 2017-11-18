
import UIKit

class CPUHelper: CpuResourceManager {
    
    let cpuModel: CPUModelIos?
    
    init(statusArray: [String]){
        cpuModel = CPUModelIos.init(methodName: statusArray[0],
                                    deviceId: NFRHelper.getDeviceName(),
                                    apkVersion: NFRHelper.getApkVersion(),
                                    lobName: statusArray[1],
                                    timeStamp: NFRHelper.getCurrentTimeStamp())
    }
    
    //method for collecting cpu stats and create data in to CPUModelIos class
    public func collectCPUStats() {
        guard let cpuModel = cpuModel else {
            print("cpuUsage is empty")
            return
        }
        print("collectCPUSta")
        cpuUsage(cpuModel)
        print(cpuModel)
        var cpuDict:[String:Any] = createCpuDictionaryData(cpuModel)
        publishData(cpuDict)
        
    }
    
    //method for publishing data into db ,it will first hit mysql connect api then insert into it
    private func publishData(_ cpuDict:[String:Any]){
        guard  let model = cpuModel else {
            return
        }
        let cpuRequest = CreateDBRequest()
        cpuRequest.createApiRequest(cpuDict,ApiUrls.CpuUsageUrl.rawValue)
    }
    
    //method for creating cpu dictionary data
    private func createCpuDictionaryData(_ cpuModel: CPUModelIos?) ->[String:Any]{
        var dict:[String:Any] = [:]
        
        if let methodName = cpuModel?.methodName {
            dict["methodName"] = methodName
            
        }
        if let deviceId = cpuModel?.deviceId{
            dict["deviceId"] = deviceId
        }
        if let apkVersion = cpuModel?.apkVersion{
            dict["apkVersion"] = apkVersion
        }
        if let lobName = cpuModel?.lobName{
            dict["lobName"] = lobName
        }
        if let timeStamp = cpuModel?.timeStamp{
            dict["timeStamp"] = timeStamp
        }
        if let cpuUsedTotal = cpuModel?.cpuUsedTotal{
            dict["cpuUsedTotal"] = cpuUsedTotal
        }
        if let usrSpaceTime = cpuModel?.usrSpaceTime{
            dict["usrSpaceTime"] = usrSpaceTime
        }
        if let systemSpaceTime = cpuModel?.systemSpaceTime{
            dict["systemSpaceTime"] = systemSpaceTime
        }
        if let threadSleepTime = cpuModel?.threadSleepTime{
            dict["threadSleepTime"] = threadSleepTime
        }
        print(dict)
        return dict
        
    }
    
    
    
    public func perform(functionality: Functionality){
        guard let model = cpuModel else {
            return
        }
        switch(functionality.rawValue.uppercased()) {
        case "COLLECT":
            do{
                try collectCPUStats()
            }
            catch let error as NSError {
                print ("capture cpu stats Error")
            }
            break
        case "PUBLISH":
            //publish()
            break
        default:
            print("Invalid input received...")
            break
        } 
    }  
}
