//
//  DynamicClassTests.swift
//  SwiftHookTests
//
//  Created by Yanni Wang on 15/5/20.
//  Copyright © 2020 Yanni. All rights reserved.
//

import XCTest
@testable import SwiftHook

class DynamicClassTests: XCTestCase {
    
    let InternalWrapDynamicClass = 68
    let InternalUnwrapNonDynamicClass = 86
    
    func testNormal() {
        do {
            let testObject = TestObject()
            XCTAssertFalse(try testIsDynamicClass(object: testObject))
            _ = try wrapDynamicClass(object: testObject)
            XCTAssertTrue(try testIsDynamicClass(object: testObject))
            try unwrapDynamicClass(object: testObject)
            XCTAssertFalse(try testIsDynamicClass(object: testObject))
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testWrapDynamicClass() {
        do {
            let testObject = TestObject()
            XCTAssertFalse(try testIsDynamicClass(object: testObject))
            
            _ = try wrapDynamicClass(object: testObject)
            XCTAssertTrue(try testIsDynamicClass(object: testObject))
            
            do {
                _ = try wrapDynamicClass(object: testObject)
                XCTFail()
            } catch SwiftHookError.internalError(file: let file, line: let line) {
                XCTAssertTrue(file.hasSuffix("DynamicClass.swift"))
                XCTAssertEqual(line, InternalWrapDynamicClass)
            } catch {
                XCTAssertNil(error)
            }
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testUnwrapNonDynamicClass() {
        do {
            let testObject = TestObject()
            XCTAssertFalse(try testIsDynamicClass(object: testObject))
            do {
                try unwrapDynamicClass(object: testObject)
                XCTFail()
            } catch SwiftHookError.internalError(file: let file, line: let line) {
                XCTAssertTrue(file.hasSuffix("DynamicClass.swift"))
                XCTAssertEqual(line, InternalUnwrapNonDynamicClass)
            } catch {
                XCTAssertNil(error)
            }
            _ = try wrapDynamicClass(object: testObject)
            XCTAssertTrue(try testIsDynamicClass(object: testObject))
            try unwrapDynamicClass(object: testObject)
            XCTAssertFalse(try testIsDynamicClass(object: testObject))
            do {
                try unwrapDynamicClass(object: testObject)
                XCTFail()
            } catch SwiftHookError.internalError(file: let file, line: let line) {
                XCTAssertTrue(file.hasSuffix("DynamicClass.swift"))
                XCTAssertEqual(line, InternalUnwrapNonDynamicClass)
            } catch {
                XCTAssertNil(error)
            }
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_Duplicated_Dynamic_Class_Name1() {
        class MyObject {
            @objc dynamic func sayHello() {
            }
        }
        do {
            try hookBefore(object: MyObject.init(), selector: #selector(MyObject.sayHello)) {
            }
        } catch {
            XCTFail()
        }
    }
    
    func test_Duplicated_Dynamic_Class_Name2() {
        class MyObject {
            @objc dynamic func sayHello() {
            }
        }
        do {
            try hookBefore(object: MyObject.init(), selector: #selector(MyObject.sayHello)) {
            }
        } catch {
            XCTFail()
        }
    }
    
}
