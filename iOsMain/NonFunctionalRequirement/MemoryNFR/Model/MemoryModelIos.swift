
import Foundation

class MemoryModelIos {
    
    
    var methodName: String
    var deviceId: String
    var apkVersion: String
    var lobName: String
    var timeStamp: String
    var memUsedTotal: Int?
    var memUsedFree:  Int?
    var memUsedWired: Int?
    var totalUsedMemSwift: Int?
    var memUsedApp: Int?
    
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
