//
//  File.swift
//  SKMediaPlayer
//
//  Created by linhey on 4/15/25.
//

import UIKit
import Combine

@Observable
public class SKTestClient: SKMediaClient {
    
    public var state: SKMediaPlayerState = .initialized
    public var resource: SKMediaResource? = nil
    public var time: SKVideoSliderReducer = SKVideoSliderReducer()
    public var view: UIView? { nil }
    public var isPipActive: Bool = false
    public var speed: Float = 1.0
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.time.receive(current: self.time.value + 1, duration: 1000.0)
            }
            .store(in: &cancellables)
    }
    
    public func seek(time: TimeInterval, autoPlay: Bool, completion: @escaping ((Bool) -> Void)) {
        self.time.receive(current: time, duration: 1000.0)
    }
    
    public func play() {
        state = .buffering
    }
    
    public func pause() {
        state = .paused
    }
    
}

