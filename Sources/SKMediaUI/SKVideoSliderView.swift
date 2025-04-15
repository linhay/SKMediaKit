//
//  SwiftUIView.swift
//  SKMediaPlayer
//
//  Created by linhey on 4/15/25.
//

import SwiftUI

@Observable
public class SKVideoSliderReducer {
    
    var current: TimeInterval?
    var duration: TimeInterval = 0
    var value: TimeInterval = 0
    var enableReceive = true
    public var seekAction: ((TimeInterval) -> Void)?
    
    public init() {}
    
    public func receive(current: TimeInterval, duration: TimeInterval) {
        guard enableReceive else { return }
        self.current = current
        self.duration = duration
        self.value = current
    }
    
    public func string(of time: TimeInterval?) -> String {
        guard let time = time, time.isNormal, time > 0 else { return "--:--" }
        let hour   = Int(time) / 3600
        let minute = Int(time) % 3600 / 60
        let second = Int(time) % 60
        
        if hour == 0 {
            return String(format: "%02d:%02d", minute, second)
        } else {
            return String(format: "%02d:%02d:%02d", hour, minute, second)
        }
    }
    
}

struct SKVideoSliderView: View {
    
    @State var store: SKVideoSliderReducer
    
    var body: some View {
        ProgressView(value: store.value, total: store.duration)
            .tint(.white)
            .colorMultiply(.white)
            .scaleEffect(.init(width: 1, height: store.enableReceive ? 1 : 2), anchor: .center)
            .animation(.default, value: store.enableReceive)
            .overlay {
                Slider(value: $store.value, in: 0...store.duration, onEditingChanged: { isDragging in
                    if isDragging {
                        store.enableReceive = false
                    } else {
                        store.seekAction?(store.value)
                        store.enableReceive = true
                    }
                })
                .colorMultiply(.clear)
            }
    }
    
}

#Preview {
    @Previewable @State var store = SKVideoSliderReducer()
    ZStack {
        Color.yellow.ignoresSafeArea()
        VStack {
            Spacer()
            SKVideoSliderView(store: store)
        }
        .scenePadding()
    }
    .onAppear {
        store.receive(current: 10, duration: 100)
    }
}
