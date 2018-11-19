Performance testing is an important weapon before launching any product in market because customer reviews are highly based on performance. 
This is caused when there are either hardware issues or coding error.this cause a decrease of output under specific load conditions. Bottleneck is generally fixed by identifying cause and fixing poor process.

# Some common bottlenecks are:
1. Disk usage
2. Memory utilization
3. Network utilization
4. Operating System limitations
5. CPU utilization

# IOS-XCUITest-PerformanceTest-Framework
IOS Performance Test Framework by using XCUITEST for extracting memory cpu and network usage data automatically by using ios api.


Ios XCUITest Performance Test Framework for extracting memory cpu and network usage data automatically by using google api. By Using this Framework we can easily capture android performance stats like CPU(user space,system space),Memory(Native,Dalvik,Private shared etc), Network(RX/TX for mobile and WiFi data usage).
This performance data is being captured after every ui test success.

# Metrices to measure:
1. Memory used App : memory used by app.
2. Memory used total: The total amount of memory that was used while performing the all app. 
3. Physical Memory Wired : The amount of memory being used by the operating system.
4. Physical Memory Free: The amount of available memory.
5. Total CPU Used: Total CPU used in % by running application
6. User-Space CPU Time: Amount of time the processor worked on the specific program
7. System-Space CPU: Amount of time the processor worked on operating system's functions connected to that specific program.
8. N/W RX Data: data received by package
9. N/W TX Data: data transmitted by package


# Architecture
1![](https://github.com/Vishvnath96/IOS-XCUITest-PerformanceTest-Framework/blob/master/iosNfrArch.png)

After test case is passed we only capture memory ,cpu and network utilization for respected test cases.
