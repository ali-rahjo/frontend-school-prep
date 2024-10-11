// NS managed object conforms to the observable object protocol, which means we can bind any object to part of our user interface.
// There's a managed object context key in the environment designed to store our active core data managed object context

// Xcode's template then injects that context into the initial content view.

// There's that Fetchrequest property wrapper that uses the environment's managed object context to perform fetch requests.
// So we create a managed object context when the app launches, attach it to the environment for our views,then use it Fetch request to load data for the app to use.

import SwiftUI

// MARK: - FORMATTER

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX

let feedback = UINotificationFeedbackGenerator()
