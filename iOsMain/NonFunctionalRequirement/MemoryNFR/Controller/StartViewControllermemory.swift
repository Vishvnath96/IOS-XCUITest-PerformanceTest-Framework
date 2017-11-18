import UIKit


class StartViewControllerMemory {
    
    let memoryHelper: MemoryHelper

    init(statusArray: [String]) {
      memoryHelper = MemoryHelper(statusArray: statusArray)
    }
   
    
    public func getMemoryUsage(){
       memoryHelper.perform(functionality: Functionality.COLLECT)
    }
    
    }
