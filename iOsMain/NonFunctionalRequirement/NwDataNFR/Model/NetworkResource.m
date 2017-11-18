

#import "NetworkResource.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

@implementation NetworkResource
   static NSString const *dataCounterKeyWWANSent = @"WWANSent";
   static NSString const *dataCounterKeyWWANReceived = @"WWANReceived";
   static NSString const *dataCounterKeyWiFiSent = @"WiFiSent";
   static NSString const *dataCounterKeyWiFiReceived = @"WiFiReceived";


-(NSMutableArray *) networkDataCounters {
        //NSDictionary *dict;

        struct ifaddrs *addrs;
        const struct ifaddrs *cursor;
        
        u_int64_t WiFiSent = 0;
        u_int64_t WiFiReceived = 0;
        u_int64_t totalWiFiData = 0;
        u_int64_t WWANSent = 0;       //mobile data sent
        u_int64_t WWANReceived = 0;   //mobile data recieved
        u_int64_t totalMobileData = 0;
    
    
        if (getifaddrs(&addrs) == 0)
        {
            cursor = addrs;
            while (cursor != NULL)
            {
                if (cursor->ifa_addr->sa_family == AF_LINK)
                {
               #ifdef DEBUG
                    const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                    if(ifa_data != NULL)
                    {
                        NSLog(@"Interface name %s: sent %tu received %tu",cursor->ifa_name,ifa_data->ifi_obytes,ifa_data->ifi_ibytes);
                    }
                #endif
                    
                    // name of interfaces:
                    // en0 is for WiFi
                    // pdp_ip0 is for WWAN
                    NSString *name = [NSString stringWithFormat:@"%s",cursor->ifa_name];
                    if ([name hasPrefix:@"en"])
                    {
                        const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                        if(ifa_data != NULL)
                        {
                            WiFiSent += ifa_data->ifi_obytes;
                            WiFiReceived += ifa_data->ifi_ibytes;
                        }
                    }
                    
                    if ([name hasPrefix:@"pdp_ip"])
                    {
                        const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                        if(ifa_data != NULL)
                        {
                            WWANSent += ifa_data->ifi_obytes;
                            WWANReceived += ifa_data->ifi_ibytes;
                        }
                    }
                }
                
                cursor = cursor->ifa_next;
            }
            
            freeifaddrs(addrs);
        }
    
    NSLog(@"mobileTx: %ld mobileRx: %ld wifiTx: %ld wifiRx: %ld", WWANSent, WWANReceived, WiFiSent,WiFiReceived);
    

    return [NSArray arrayWithObjects:[NSNumber numberWithLong:WWANSent],[NSNumber numberWithLong:WWANReceived],
            [NSNumber numberWithLong:WiFiSent],[NSNumber numberWithLong:WiFiReceived], nil];

//        return @{dataCounterKeyWiFiSent:[NSNumber numberWithUnsignedInt:WiFiSent],
//                 dataCounterKeyWiFiReceived:[NSNumber numberWithUnsignedInt:WiFiReceived],
//                 dataCounterKeyWWANSent:[NSNumber numberWithUnsignedInt:WWANSent],
//                 dataCounterKeyWWANReceived:[NSNumber numberWithUnsignedInt:WWANReceived]};
//    
}

@end
