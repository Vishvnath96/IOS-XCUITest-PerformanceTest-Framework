

import UIKit

class CPUModelIos {
    
    var methodName: String
    var deviceId: String
    var apkVersion: String
    var lobName: String
    var timeStamp: String
    var cpuUsedTotal: Float?
    var usrSpaceTime: Int?
    var systemSpaceTime:Int?
    var threadSleepTime: Int?
  
    
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
    }

}
