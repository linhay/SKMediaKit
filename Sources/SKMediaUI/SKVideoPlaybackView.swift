//
//  VideoOptions.swift
//  FlowUp
//
//  Created by linhey on 3/13/25.
//

import SwiftUI
import Combine

public struct SKVideoPlaybackView: View {
    
    @State var store: SKMediaClient
    @State var isShowControls = true
    @State var longPressSpeed: Float?
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    public init(store: SKMediaClient) {
        self.store = store
    }
    
    public var timeView: some View {
        Group {
            if store.time.duration > 0 {
                Text(store.time.string(of: store.time.value) + " / " + store.time.string(of: store.time.duration))
                    .fontWeight(.medium)
                    .monospaced()
            } else {
                EmptyView()
            }
        }
    }
    
    public var rateView: some View {
        Group {
            if store.time.duration > 0 {
                Text(store.formatedSpeed)
                    .onTapGesture {
                        store.switchToNextSpeed()
                    }
            } else {
                EmptyView()
            }
        }
    }
    
    func CircleImage(_ name: String, width: CGFloat) -> some View {
        Circle()
            .fill(.black.opacity(0.5))
            .frame(width: width, height: width)
            .contentShape(Circle())
            .overlay {
                Image(systemName: name)
                    .font(.system(size: width * 0.4))
                    .fontWeight(.semibold)
            }
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture {
                    if verticalSizeClass == .compact {
                        isShowControls.toggle()
                    } else {
                        store.togglePlayOrPause()
                    }
                }
                .onLongPressGesture {
                    
                } onPressingChanged: { flag in
                    if flag {
                        if longPressSpeed == nil {
                            longPressSpeed = store.speed
                            let peed = store.speed * 2
                            store.speed = peed
                        }
                    } else {
                        store.speed = longPressSpeed ?? 1
                        longPressSpeed = nil
                    }
                }

            
            if let verticalSizeClass {
                switch verticalSizeClass {
                case .compact:
                    if isShowControls {
                        HStack(spacing: 20) {
                            CircleImage("15.arrow.trianglehead.counterclockwise", width: 88)
                                .onTapGesture {
                                    store.seek(forward: -15)
                                }
                            CircleImage("play.fill", width: 120)
                            CircleImage("15.arrow.trianglehead.clockwise", width: 88)
                                .onTapGesture {
                                    store.seek(forward: 15)
                                }
                        }
                    }
                default:
                    if !store.state.isPlaying {
                        CircleImage("play.fill", width: 88)
                    }
                }
            }
            
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 12) {
                    SKVideoSliderView(store: store.time)
                    if let longPressSpeed {
                        Text(store.formated(speed: store.speed))
                    } else {
                        HStack {
                            timeView
                            Spacer()
                            rateView
                        }
                    }
                }
                .font(.system(size: 14, weight: .medium))
                .safeAreaPadding(.bottom)
                .padding(.top, 12)
                .padding(.horizontal, 12)
                .background(.black.opacity(0.5))
                .opacity(isShowControls ? 1 : 0)
            }
        }
        .foregroundStyle(.white)
        .animation(.easeInOut, value: isShowControls)
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        .onAppear {
            store.setup()
        }
    }
}




#Preview {
    @Previewable @State var store = SKTestClient()
    return ZStack {
        Color.yellow.ignoresSafeArea()
        SKVideoPlaybackView(store: store)
    }
    .onAppear {
        store.resource = SKMediaResource()
        store.time.receive(current: 20, duration: 200)
    }
}
