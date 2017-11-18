

import UIKit
import XCTest

enum lobs {
    case testFlight
}

class BaseTest: XCTest {
    let testRunVar: XCTestRun?
    var tcname: String?
    init(_ testRunVar: XCTestRun?,_ testName: String?) {
        self.testRunVar = testRunVar
        self.tcname = testName
    }
    // error: cannot override with a stored property 'testRun'
    //let testRun: XCTestRun?

    
    public func onTestSucceed(){
        var statusArray: [String]?
        guard let run = testRunVar else {
            return
        }
        if run.failureCount > 0 {
            print("failed")
        }
        else {
            print("Pass")
            guard let tcName = tcname else {
                return
            }
            let ind = tcName.index(tcName.startIndex, offsetBy: 0)
            var array = tcName.substring(from: ind).replacingOccurrences(of: "-[", with: "").replacingOccurrences(of: "]", with: "").components(separatedBy: "_")
            var testMethod: String = array[2]
            var lobName: String? = array.count > 3 ? array[3].replacingOccurrences(of: "]", with: "") : nil
            print(lobName)
            statusArray = [testMethod]
            
            if let lobName = lobName {
                statusArray?.append(lobName)
            }
            
            print(statusArray)
            if let statusArray = statusArray {
                captureNFRStats(statusArray)
            }
        }
    }
    
    private func captureNFRStats(_ statusArray: [String]){
        //        guard let statusArray = statusArray else {
        //            return
        //        }
        let memoryController = StartViewControllerMemory(statusArray: statusArray)
        let cpuController = StartViewControllerCPU(statusArray: statusArray)
        let networkController = StartViewControllerNetwork(statusArray: statusArray)
        do{
            try memoryController.getMemoryUsage()
            try cpuController.getCPUUsage()
            try networkController.getNetworkUsage()
        }
        catch let error as NSError{
            print("error ")
        }
        
        
        print("Error in capturing NFR stats")
        
    }
}
