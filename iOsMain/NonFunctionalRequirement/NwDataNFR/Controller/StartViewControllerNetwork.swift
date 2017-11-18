import UIKit

class StartViewControllerNetwork {
    
    let networkHelper: NetworkHelper
    
    init(statusArray: [String]) {
        networkHelper = NetworkHelper(statusArray: statusArray)
    }
    
    public func getNetworkUsage(){
        networkHelper.perform(functionality: Functionality.COLLECT)
    }
}
