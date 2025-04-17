//
//  MediaClient 2.swift
//  SKMediaPlayer
//
//  Created by linhey on 4/15/25.
//

import UIKit

public protocol SKMediaClient: AnyObject {
    
    var state: SKMediaPlayerState { get }
    var resource: SKMediaResource? { get }
    var isPipActive: Bool { get }
    var time: SKVideoSliderReducer { get }
    var view: UIView? { get }
    var speeds: [Float] { get }
    var speed: Float { get set }
    func seek(time: TimeInterval, autoPlay: Bool, completion: @escaping ((Bool) -> Void))
    func play()
    func pause()
}


public extension SKMediaClient {
    
    var speeds: [Float] { return [0.5, 1.0, 1.5, 2.0] }
    
    func seek(forward value: TimeInterval) {
        seek(time: time.value + value, autoPlay: state.isPlaying) { flag in
            
        }
    }
    
    func setup() {
        time.seekAction = { [weak self] time in
            guard let self else { return }
            self.seek(time: time, autoPlay: true) { flag in
                
            }
        }
    }
    
    func switchToNextSpeed() {
        let index = speeds.firstIndex(of: speed) ?? 0
        let nextIndex = (index + 1) % speeds.count
        speed = speeds[nextIndex]
    }
    
    func formated(speed: Float) -> String {
        // 保留最多2位小数
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        let text = formatter.string(from: NSNumber(value: speed)) ?? "\(speed)"
        return "\(text)x"
    }
    
    var formatedSpeed: String {
        if speed == 1.0 {
            return "倍速"
        }
        return formated(speed: speed)
    }
    
    func togglePlayOrPause() {
        if state.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
}
