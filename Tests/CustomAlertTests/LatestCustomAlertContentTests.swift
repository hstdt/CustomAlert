//
//  LatestCustomAlertContentTests.swift
//  CustomAlert
//
//  Created by tdt on 2026/7/31.
//

import SwiftUI
import Testing

@testable import CustomAlert

@MainActor
struct LatestCustomAlertContentTests {

    @Test func updateReplacesInputAndContentClosure() {
        let storage = LatestCustomAlertContentStorage<String, ProbeView>(
            input: "first",
            alertTitle: { nil },
            alertContent: { ProbeView(value: "old:\($0)") },
            alertActions: { _ in [] }
        )

        #expect(storage.content(fallbackInput: "fallback").value == "old:first")

        storage.update(
            input: "second",
            alertTitle: { nil },
            alertContent: { ProbeView(value: "new:\($0)") },
            alertActions: { _ in [] }
        )

        #expect(storage.content(fallbackInput: "fallback").value == "new:second")
    }

    @Test func fallsBackToPresentedInputWhileDismissalIsFinishing() {
        let storage = LatestCustomAlertContentStorage<String, ProbeView>(
            input: nil,
            alertTitle: { nil },
            alertContent: { ProbeView(value: $0) },
            alertActions: { _ in [] }
        )

        #expect(storage.content(fallbackInput: "presented").value == "presented")
    }
}

private struct ProbeView: View {
    let value: String

    var body: some View {
        EmptyView()
    }
}
