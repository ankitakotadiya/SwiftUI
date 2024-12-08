import SwiftUI

public enum PresentationOption {
    case push
    case popover
    case fullscreenCover
    case sheet
}

protocol Route: Equatable, Hashable, Identifiable {}

extension Route {
    var id: Self {
        self
    }
}

final class Router<T: Route>: ObservableObject {
    @Published var root: T
    @Published var routes: [T]
    @Published var sheet: T?
    @Published var fullscreen: T?
    @Published var popover: T?
    typealias Closure = () -> Void
    
    var onDismiss: (Closure)?
    
    init(root: T) {
        self.root = root
        self.routes = []
    }
    
    func updateRoot(_ route: T) {
        self.root = route
        self.routes.removeAll()
    }
    
    func navigate(to route: T, option: PresentationOption = .push, onDismiss: (Closure)? = nil) {
        switch option {
        case .push:
            push(to: route)
        case .popover:
            presentPopover(route)
        case .fullscreenCover:
            presentFullScreen(route, onDismiss: onDismiss)
        case .sheet:
            presentSheet(route, onDismiss: onDismiss)
        }
    }
    
    func dismiss(_ option: PresentationOption? = nil) {
        switch option {
        case .fullscreenCover:
            fullscreen = nil
        case .push:
            pop()
        case .sheet:
            sheet = nil
        case .popover:
            popover = nil
        case .none:
            if sheet != nil {
                sheet = nil
            } else if fullscreen != nil {
                fullscreen = nil
            } else if popover != nil {
                popover = nil
            } else {
                pop()
            }
        }
    }
    
    private func push(to route: T) {
        self.routes.append(route)
    }
    
    private func pop() {
        self.routes.removeLast()
    }
    
    private func presentSheet(_ route: T, onDismiss: (Closure)? = nil) {
        sheet = route
        self.onDismiss = onDismiss
    }
    
    private func presentFullScreen(_ route: T, onDismiss: (Closure)? = nil) {
        fullscreen = route
        self.onDismiss = onDismiss
    }
    
    private func presentPopover(_ route: T) {
        popover = route
    }
}

