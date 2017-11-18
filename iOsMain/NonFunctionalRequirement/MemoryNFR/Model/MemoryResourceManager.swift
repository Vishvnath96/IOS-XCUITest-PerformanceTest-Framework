
import Foundation

class MemoryResourceManager {
    
    func report_memory(_ memoryModel:MemoryModelIos?) {
        
        guard let memoryModel = memoryModel else {
            return
        }
        
        let mem = MemoryResource()
       
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            print("Memory used in bytes: \(taskInfo.resident_size)")
            var used_bytes: Int = (Int(taskInfo.resident_size))/(1024 * 1024)
            //var total_bytes: Float = Float(ProcessInfo.processInfo().physicalMemory)
            var totalMemUsed: Int = (Int(ProcessInfo.processInfo.physicalMemory))/(1024 * 1024)
            //print("Used: \(used_bytes / 1024.0 / 1024.0) MB out of \(tot / 1024.0 / 1024.0) MB (\(used_bytes * 100.0 / tot)%%)")
            //let memoryModel = MemoryModelIos()
            memoryModel.memUsedApp = used_bytes
            memoryModel.totalUsedMemSwift = totalMemUsed
            let array = mem.freeMemory()
            memoryModel.memUsedTotal = (array?[0] as? NSNumber)?.intValue
            memoryModel.memUsedFree = (array?[1] as? NSNumber)?.intValue
            memoryModel.memUsedWired = (array?[2] as? NSNumber)?.intValue
            print(memoryModel)
           
        }
        else {
            print("Error with task_info(): " + (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
        }
    }
}
