//
//  DLog.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import Foundation
//自定义 log

func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):\(lineNum))-\(message)");
        
    #endif
}
