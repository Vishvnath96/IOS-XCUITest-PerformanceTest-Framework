
import UIKit

class MemoryHelper: MemoryResourceManager {
    
    let memoryModel: MemoryModelIos?
    
     init(statusArray: [String]) {
        memoryModel = MemoryModelIos.init(methodName: statusArray[0] ,deviceId: NFRHelper.getDeviceName(), apkVersion:NFRHelper.getApkVersion(), lobName: statusArray[1], timeStamp: NFRHelper.getCurrentTimeStamp())
    }
    
    public func collectMemoryStats() {
        //getTestCaseData(udid: udid, methodName: methodName, LOB: LOB, memoryModel: memoryModel)
        
            report_memory(memoryModel)
            print(memoryModel)
            var memDict:[String:Any] = createMemDictionaryData(memoryModel)
            publishData(memDict)
        
    }
    
    //method for generating memory dictionary data for memory model ios
    private func createMemDictionaryData(_ memoryModel: MemoryModelIos?) ->[String:Any]{
            //obj: NSObject, apiUrl: ApiUrls
            
            var dict:[String:Any] = [:]
            
            if let methodName = memoryModel?.methodName {
                dict["methodName"] = methodName
                
            }
            if let deviceId = memoryModel?.deviceId{
                dict["deviceId"] = deviceId
            }
            if let apkVersion = memoryModel?.apkVersion{
                dict["apkVersion"] = apkVersion
            }
            if let lobName = memoryModel?.lobName{
                dict["lobName"] = lobName
            }
            if let timeStamp = memoryModel?.timeStamp{
                dict["timeStamp"] = timeStamp
            }
            if let memUsedTotal = memoryModel?.memUsedTotal{
                dict["memUsedTotal"] = memUsedTotal
            }
            if let memUsedFree = memoryModel?.memUsedFree{
                dict["memUsedFree"] = memUsedFree
            }
            if let memUsedWired = memoryModel?.memUsedWired{
                dict["memUsedWired"] = memUsedWired
            }
            if let totalUsedMemSwift = memoryModel?.totalUsedMemSwift{
                dict["totalUsedMemSwift"] = totalUsedMemSwift
            }
            if let memUsedApp = memoryModel?.memUsedApp{
                dict["memUsedApp"] = memUsedApp
            }
        return dict
    }
    
    /*method for publishing data into db ,it will first hit mysql connect api then insert into it
       */
        private func publishData(_ memDict:[String:Any]){
//        guard  let model = memoryModel else {
//            return
//        }
//        let dbrequest = CreateMemDBRequest()
//        dbrequest.createDBConnectRequest(memoryModel)
        let memDbRequest = CreateDBRequest()
        memDbRequest.createApiRequest(memDict, ApiUrls.MemoryUsageUrl.rawValue)
        
    }
    
    
    public func perform(functionality :Functionality ) {
        
        //var memoryModel = MemoryModelIos.init(version, udid, lob, methodname, timestamp)
        guard let model = memoryModel else {
            return
        }
        
        switch (functionality.rawValue.uppercased()) {
        case "COLLECT":
            do
            {
                try collectMemoryStats()
            }
            catch let error as NSError {
                print ("Error")
            }
            
        case "PUBLISH":
            break
        //publish(statement);
        default:
            print("Invalid input received...")
            break
        }
    }
}
