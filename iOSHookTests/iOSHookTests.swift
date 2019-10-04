//
//  iOSHookTests.swift
//  iOSHookTests
//
//  Created by Yanni Wang on 1/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest
@testable import iOSHook

class MyObject: NSObject {
    @objc func test() -> String {
        print("MyObject->test")
        return ""
    }
}

class iOSHookTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // #selector(MyObject.test)
        MyObject.init().hookAfter(selector: #selector(MyObject.test)) { (obj, result, args) in
            
        }
        
        MyObject.hookAfter(selector: #selector(MyObject.test)) { (obj, result, args) in
            
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}