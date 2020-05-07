//
//  Utilities.swift
//  SwiftHook
//
//  Created by Yanni Wang on 7/5/20.
//  Copyright © 2020 Yanni. All rights reserved.
//

import Foundation

func getMethodWithoutSearchingSuperClasses(targetClass: AnyClass, selector: Selector) -> Method? {
    var length: UInt32 = 0
    let firstMethod = class_copyMethodList(targetClass, UnsafeMutablePointer(&length))
    let bufferPointer = UnsafeBufferPointer.init(start: firstMethod, count: Int(length))
    for method in bufferPointer {
        if method_getName(method) == selector {
            return method
        }
    }
    return nil
}
