
import UIKit

class NetworkHelper: NetworkResource {
    
    let networkModel: NetworkModelIos?
    
    init(statusArray: [String]) {
        networkModel = NetworkModelIos.init(methodName: statusArray[0],
                                            deviceId: NFRHelper.getDeviceName(),
                                            apkVersion: NFRHelper.getApkVersion(),
                                            lobName: statusArray[1],
                                            timeStamp: NFRHelper.getCurrentTimeStamp())
    }
    
    public func collectNetworkStats(){
        guard let networkModel = networkModel else {
            print("network model is empty")
            return
        }
        //let array = networkDataCounters()
        let array = (networkDataCounters() as NSArray?) as? [Int]
        print(array)
        pushNetworkModelData(arr: array)
        let networkDict:[String:Any] = createNetworkDictionaryData(networkModel)
        publishData(networkDict)
        
    }
    
    private func publishData(_ networkDict:[String:Any]){
        
        let networkRequest = CreateDBRequest()
        networkRequest.createApiRequest(networkDict, ApiUrls.NetworkUsageUrl.rawValue)
    }
    
    private func createNetworkDictionaryData(_ networkModel: NetworkModelIos?) -> [String:Any]{
        var dict:[String:Any] = [:]
        
        if let methodName = networkModel?.methodName {
            dict["methodName"] = methodName
            
        }
        if let deviceId = networkModel?.deviceId{
            dict["deviceId"] = deviceId
        }
        if let apkVersion = networkModel?.apkVersion{
            dict["apkVersion"] = apkVersion
        }
        if let lobName = networkModel?.lobName{
            dict["lobName"] = lobName
        }
        if let timeStamp = networkModel?.timeStamp{
            dict["timeStamp"] = timeStamp
        }
        if let mobileRxData = networkModel?.mobileRxData{
            dict["mobileRxData"] = mobileRxData
        }
        if let mobileTxData = networkModel?.mobileTxData{
            dict["mobileTxData"] = mobileTxData
        }
        if let mobileTotalData = networkModel?.mobileTotalData{
            dict["mobileTotalData"] = mobileTotalData
        }
        if let wifiRxData = networkModel?.wifiRxData{
            dict["wifiRxData"] = wifiRxData
        }
        if let wifiTxData = networkModel?.wifiTxData{
            dict["wifiTxData"] = wifiTxData
        }
        if let wifiTotalData = networkModel?.wifiTotalData{
            dict["wifiTotalData"] = wifiTotalData
        }
        if let networkType = networkModel?.networkType{
            dict["networkType"] = networkType
        }
        print(dict)
        return dict
    }
    
    //fucntion to push network data into Network Model class
    private func pushNetworkModelData(arr: [Int]?){
        guard let array = arr else {
            return
        }
        if let array = arr, array.count > 3 {
            let mobileRxData = array[0]/(1024 * 1024)
            let mobileTxData = array[1]/(1024 * 1024)
            let wifiRxData = array[2]/(1024 * 1024)
            let wifiTxData = array[3]/(1024 * 1024)
            networkModel?.mobileRxData = mobileRxData
            networkModel?.mobileTxData = mobileTxData
            networkModel?.mobileTotalData = mobileRxData + mobileTxData
            networkModel?.wifiRxData = wifiRxData
            networkModel?.wifiTxData = wifiTxData
            networkModel?.wifiTotalData = wifiRxData + wifiTxData
            if networkModel?.mobileTotalData == 0{
                networkModel?.networkType = "WiFi"
            }
            else{
            networkModel?.networkType = "mobileData"
            }
            print(networkModel?.wifiTotalData)
        } else {
            debugPrint("array count zero received.. ")
        }
    }
    
    public func perform(functionality: Functionality){
        guard let networkModel = networkModel else {
            return
        }
        
        switch functionality.rawValue.uppercased() {
        case "COLLECT":
            do{
                try collectNetworkStats()
            }
            catch let error as NSError{
                print("unable to collect network stats...!!")
                break
            }
        case "PUBLISH":
            //publish()
            break
        default:
            print("Invalid input received...")
            break
        }
    }
}
