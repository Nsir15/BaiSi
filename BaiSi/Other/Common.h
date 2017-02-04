//
//  Common.h
//  BaiSi
//
//  Created by N-X on 2016/12/10.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define weakify(x)    __weak  typeof(x)weak##x = x    

#ifdef DEBUG
#define NXLog(...)   NSLog(__VA_ARGS__)
#define NXFuncLog()  NSLog(@"%s",__func__)
#else
#define NXLog(...)
#endif

#endif /* Common_h */
