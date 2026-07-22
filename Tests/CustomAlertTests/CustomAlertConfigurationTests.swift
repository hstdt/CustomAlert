//
//  CustomAlertConfigurationTests.swift
//  CustomAlert
//
//  Created by tdt on 22.07.26.
//

import Dispatch
import SwiftUI
import XCTest
@testable import CustomAlert

final class CustomAlertConfigurationTests: XCTestCase {
    func testDefaultEnvironmentConfigurationDoesNotWaitForMainActor() async {
        let result = await MainActor.run {
            let finished = DispatchSemaphore(value: 0)

            DispatchQueue.global(qos: .userInitiated).async {
                _ = EnvironmentValues().customAlertConfiguration
                finished.signal()
            }

            return finished.wait(timeout: .now() + 1)
        }

        XCTAssertEqual(result, .success)
    }
}
