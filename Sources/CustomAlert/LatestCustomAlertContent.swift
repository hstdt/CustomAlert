//
//  LatestCustomAlertContent.swift
//  CustomAlert
//
//  Created by tdt on 2026/7/31.
//

import SwiftUI

/// Keeps the window-hosted builder connected to the newest source-view closures.
///
/// WindowKit retains the builder used to create its hosting controller. SwiftUI can replace
/// the source modifier while that controller is alive, so the retained builder must capture
/// this stable reference instead of a particular modifier value.
@MainActor
final class LatestCustomAlertContentStorage<Input, AlertContent: View>: ObservableObject {
    private var input: Input?
    private var alertTitle: () -> Text?
    private var alertContent: (Input) -> AlertContent
    private var alertActions: (Input) -> [CustomAlertAction]

    init(
        input: Input?,
        alertTitle: @escaping () -> Text?,
        alertContent: @escaping (Input) -> AlertContent,
        alertActions: @escaping (Input) -> [CustomAlertAction]
    ) {
        self.input = input
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }

    func update(
        input: Input?,
        alertTitle: @escaping () -> Text?,
        alertContent: @escaping (Input) -> AlertContent,
        alertActions: @escaping (Input) -> [CustomAlertAction]
    ) {
        self.input = input
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
    }

    func title() -> Text? {
        alertTitle()
    }

    func content(fallbackInput: Input) -> AlertContent {
        alertContent(input ?? fallbackInput)
    }

    func actions(fallbackInput: Input) -> [CustomAlertAction] {
        alertActions(input ?? fallbackInput)
    }
}

@MainActor
@propertyWrapper
struct LatestCustomAlertContent<Input, AlertContent: View>: @MainActor DynamicProperty {
    @StateObject private var storage: LatestCustomAlertContentStorage<Input, AlertContent>

    private let input: Input?
    private let alertTitle: () -> Text?
    private let alertContent: (Input) -> AlertContent
    private let alertActions: (Input) -> [CustomAlertAction]

    init(
        input: Input?,
        alertTitle: @escaping () -> Text?,
        @ViewBuilder alertContent: @escaping (Input) -> AlertContent,
        @ActionBuilder alertActions: @escaping (Input) -> [CustomAlertAction]
    ) {
        self.input = input
        self.alertTitle = alertTitle
        self.alertContent = alertContent
        self.alertActions = alertActions
        self._storage = StateObject(
            wrappedValue: LatestCustomAlertContentStorage(
                input: input,
                alertTitle: alertTitle,
                alertContent: alertContent,
                alertActions: alertActions
            )
        )
    }

    var wrappedValue: LatestCustomAlertContentStorage<Input, AlertContent> {
        storage
    }

    mutating func update() {
        storage.update(
            input: input,
            alertTitle: alertTitle,
            alertContent: alertContent,
            alertActions: alertActions
        )
    }
}
