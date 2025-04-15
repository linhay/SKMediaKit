//
//  SKVideoReducer.swift
//  SKMediaPlayer
//
//  Created by linhey on 4/14/25.
//

import SwiftUI

@MainActor
@Observable
public class SKVideoReducer {
    
    var time = SKVideoSliderReducer()
    public var state: SKMediaPlayerState = .initialized
    public var resource: SKMediaResource? {
        didSet {
            recreateksClient()
        }
    }
    
    var client: SKMediaClient?
    
    public init() {
        self.resource = resource
        time.seekAction = { [weak self] time in
            guard let self else { return }
            self.client?.seek(time: time, autoPlay: true, completion: { flag in
                
            })
        }
    }
    
}


public extension SKVideoReducer {
    
    func play() {
        ksPlayer?.play()
    }
    
    func pause() {
        ksPlayer?.pause()
    }
    
    func togglePlayOrPause() {
        if state.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
}
