import UIKit

class StartViewControllerCPU {

    
    let cpuHelper: CPUHelper
    
    init(statusArray: [String]) {
        cpuHelper = CPUHelper(statusArray: statusArray)
    }
    
    
    public func getCPUUsage(){
        cpuHelper.perform(functionality: Functionality.COLLECT)
    }
    
}
