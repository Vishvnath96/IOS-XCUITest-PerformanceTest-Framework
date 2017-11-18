

#import "MemoryResource.h"
#import <mach/mach.h>
#import <mach/mach_host.h>

@implementation MemoryResource
    
    -(NSMutableArray *)  freeMemory {
        
        mach_port_t host_port = mach_host_self();
        mach_msg_type_number_t  host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
        vm_size_t pagesize;
        vm_statistics_data_t vm_stat;
        
        host_page_size(host_port, &pagesize);
        
        if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) NSLog(@"Failed to fetch vm statistics");
        
        long mem_used = ((vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize)/(1024 * 1024);
        long mem_free = (vm_stat.free_count * pagesize)/(1024 * 1024);     //in kb
        long mem_wired = (vm_stat.wire_count * pagesize)/(1024 * 1024);    //in kb
        //long mem_total = mem_used + mem_free;
        NSLog(@"used: %ld free: %ld wired: %ld", mem_used, mem_free, mem_wired);

        //return [NSArray arrayWithObjects:@(mem_used), nil];
        return [NSArray arrayWithObjects:[NSNumber numberWithLong:mem_used],[NSNumber numberWithLong:mem_free],
                [NSNumber numberWithLong:mem_wired], nil];
        //[NSArray arrayWithObjects:[NSNumber numberWithInt:a], [NSNumber numberWithInt:b], nil];
    }
    
    -(NSString *) getApkVer {
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSLog(version);
        return version;
    }


@end
