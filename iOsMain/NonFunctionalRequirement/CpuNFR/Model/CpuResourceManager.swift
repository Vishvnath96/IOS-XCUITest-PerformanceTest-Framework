

import UIKit

class CpuResourceManager {
    
    var usr_space_time: Int = 0
    var system_space_time:Int = 0
    
    public func cpuUsage(_ cpuModel:CPUModelIos?) -> Float {
        guard let cpuModel = cpuModel else {
            print("cpuUsage is empty")

            return -1
        }
        
        print("cpuUsage")

        
        var kr: kern_return_t
        var task_info_count: mach_msg_type_number_t
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
        //            // Put your code which should be executed with a delay here
        //        })
        
        
        task_info_count = mach_msg_type_number_t(TASK_INFO_MAX)
        var tinfo = [integer_t](repeating: 0, count: Int(task_info_count))
        
        kr = task_info(mach_task_self_, task_flavor_t(TASK_BASIC_INFO), &tinfo, &task_info_count)
        if kr != KERN_SUCCESS {
            return -1
        }
        
        var thread_list: thread_act_array_t? = UnsafeMutablePointer(mutating: [thread_act_t]())
        var thread_count: mach_msg_type_number_t = 0
        defer {
            if let thread_list = thread_list {
                vm_deallocate(mach_task_self_, vm_address_t(UnsafePointer(thread_list).pointee), vm_size_t(thread_count))
            }
        }
        
        print("point 1")

        
        kr = task_threads(mach_task_self_, &thread_list, &thread_count)
        
        if kr != KERN_SUCCESS {
            print("point 2")
            return -1
        }
        
        var tot_cpu: Float = 0
        var usr_space_time: Int = 0      //time in ms
        var system_space_time:Int = 0    //time in ms
        var thread_sleep_time: Int = 0   // time in sec
        var counter:Int = 0
        
        if let thread_list = thread_list {
            print("in for loop")

            for j in 0 ..< Int(thread_count) {
                var thread_info_count = mach_msg_type_number_t(THREAD_INFO_MAX)
                var thinfo = [integer_t](repeating: 0, count: Int(thread_info_count))
                kr = thread_info(thread_list[j], thread_flavor_t(THREAD_BASIC_INFO),
                                 &thinfo, &thread_info_count)
                
                let threadBasicInfo = convertThreadInfoToThreadBasicInfo(thinfo)
                
                if threadBasicInfo.flags != TH_FLAGS_IDLE {
                    tot_cpu += (Float(threadBasicInfo.cpu_usage) / Float(TH_USAGE_SCALE)) * 100.0
                    usr_space_time += Int(threadBasicInfo.user_time.microseconds/1000)
                    system_space_time += Int(threadBasicInfo.system_time.microseconds/1000)
                    thread_sleep_time += Int(threadBasicInfo.sleep_time)
                    counter = counter + 1
                }
                print("inside for loop")

            } // for each thread
            
            print("outside for loop")

            if counter != 0 {
                //setCpuData(tot_cpu,usr_space_time,system_space_time)
                setCpuData(tot_cpu: tot_cpu, usr_space_time: usr_space_time, system_space_time: system_space_time, thread_sleep_time: thread_sleep_time,cpuModel: cpuModel)
                print(usr_space_time)
                return -1
            }
        }
        return tot_cpu
    }
    
    fileprivate func convertThreadInfoToThreadBasicInfo(_ threadInfo: [integer_t]) -> thread_basic_info {
        var result = thread_basic_info()
        result.user_time = time_value_t(seconds: threadInfo[0], microseconds: threadInfo[1])
        result.system_time = time_value_t(seconds: threadInfo[2], microseconds: threadInfo[3])
        result.cpu_usage = threadInfo[4]
        result.policy = threadInfo[5]
        result.run_state = threadInfo[6]
        result.flags = threadInfo[7]
        result.suspend_count = threadInfo[8]
        result.sleep_time = threadInfo[9]
        return result
    }
    
    fileprivate func setCpuData(tot_cpu: Float,usr_space_time: Int,system_space_time: Int,thread_sleep_time: Int,
                                cpuModel: CPUModelIos){
        print("setCpuData")
        print(tot_cpu)
        print(usr_space_time)
        print(system_space_time)
        print(thread_sleep_time)
        cpuModel.cpuUsedTotal = tot_cpu
        cpuModel.usrSpaceTime = usr_space_time
        cpuModel.systemSpaceTime = system_space_time
        cpuModel.threadSleepTime = thread_sleep_time
    }
}
