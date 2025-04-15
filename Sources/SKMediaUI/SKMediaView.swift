// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct SKMediaView: UIViewRepresentable {
 
    public typealias UIViewType = UIView
    
    public class Coordinator {
        weak var playerView: UIView?
    }
    
    public let store: SKMediaClient
    public init(store: SKMediaClient) {
        self.store = store
    }
    
    public func makeUIView(context: Context) -> UIViewType {
        let view = UIViewType()
        return view
    }
    
    public func makeCoordinator() -> Coordinator {
        .init()
    }
    
    public func updateUIView(_ view: UIViewType, context: Context) {
        context.coordinator.playerView?.removeFromSuperview()
        if let item = store.view {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.topAnchor.constraint(equalTo: view.topAnchor),
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                item.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
            context.coordinator.playerView = item
        }
    }
    
}
