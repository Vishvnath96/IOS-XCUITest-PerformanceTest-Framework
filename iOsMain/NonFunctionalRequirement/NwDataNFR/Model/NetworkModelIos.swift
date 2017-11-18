
import UIKit

class NetworkModelIos {

    var methodName: String
    var deviceId: String
    var apkVersion: String
    var lobName: String
    var timeStamp: String
    var mobileTxData: Int?
    var mobileRxData: Int?
    var mobileTotalData: Int?
    var wifiTxData:Int?
    var wifiRxData: Int?
    var wifiTotalData: Int?
    var networkType: String?
    
    
    init?(methodName: String,deviceId: String?,apkVersion: String,lobName: String,
          timeStamp: String) {
        guard let id = deviceId else {
            return nil
        }
        self.methodName = methodName 
        self.deviceId = id
        self.apkVersion = apkVersion
        self.lobName = lobName
        self.timeStamp = timeStamp
    }}
