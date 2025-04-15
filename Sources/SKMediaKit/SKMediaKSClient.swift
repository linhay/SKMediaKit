//
//  File.swift
//  MediaPlayer
//
//  Created by linhey on 4/15/25.
//

import Foundation
import KSPlayer
import SKMediaUI
import UIKit

@Observable
public class SKMediaKSClient: @preconcurrency SKMediaClient, KSPlayerLayerDelegate {
    public var speed: Float {
        set { client?.player.playbackRate = newValue }
        get { client?.player.playbackRate ?? 1 }
    }
    public var state: SKMediaPlayerState = .initialized
    public var client: KSPlayerLayer?
    public var view: UIView? { client?.player.view }
    public var time: SKVideoSliderReducer = .init()
    public var isPipActive: Bool {
        set { client?.isPipActive = newValue }
        get { client?.isPipActive ?? false }
    }
    let options: KSOptions = {
        let options = KSOptions()
        return options
    }()
    public var resource: SKMediaResource? {
        didSet {
            recreateksClient()
        }
    }
    
    public init() {

    }

    public func play() {
        client?.play()
    }
    
    public func pause() {
        client?.pause()
    }
    
    public func seek(time: TimeInterval, autoPlay: Bool, completion: @escaping ((Bool) -> Void)) {
        client?.seek(time: time, autoPlay: autoPlay, completion: completion)
    }
    
    public func player(layer: KSPlayerLayer, state: KSPlayerState) {
        switch state {
        case .initialized: self.state = .initialized
        case .preparing: self.state = .preparing
        case .readyToPlay: self.state = .readyToPlay
        case .buffering: self.state = .buffering
        case .bufferFinished: self.state = .bufferFinished
        case .paused: self.state = .paused
        case .playedToTheEnd: self.state = .playedToTheEnd
        case .error: self.state = .error
        }
    }
    
    public func player(layer: KSPlayerLayer, currentTime: TimeInterval, totalTime: TimeInterval) {
        print("time", currentTime, totalTime)
        time.receive(current: currentTime, duration: totalTime)
    }
    
    public func player(layer: KSPlayerLayer, finish error: (any Error)?) {
        print(error.debugDescription)
    }
    
    public func player(layer: KSPlayerLayer, bufferedCount: Int, consumeTime: TimeInterval) {
        print("buffered", bufferedCount, consumeTime)
    }
    
    func recreateksClient() {
        guard let resource, let url = resource.url else {
            self.client = nil
            return
        }
        let client = KSPlayerLayer(url: url, isAutoPlay: true, options: options)
        client.delegate = self
        self.client = client
    }
    
}
