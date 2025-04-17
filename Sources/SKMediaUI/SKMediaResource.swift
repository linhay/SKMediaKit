//
//  File.swift
//  MediaPlayer
//
//  Created by linhey on 4/11/25.
//

import Foundation
import Photos
import HTTPTypes
import HTTPTypesFoundation

public class SKMediaResource: Equatable, Hashable {
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(url?.absoluteString)
        hasher.combine(headers)
    }
    
    public static func == (lhs: SKMediaResource, rhs: SKMediaResource) -> Bool {
        lhs.url == rhs.url
        && lhs.headers == rhs.headers
    }
    
    
    public static func supports(of ext: String) -> Bool {
        ["mp4", "mov", "avi", "mkv"].contains(ext.lowercased())
    }
    
    public var url: URL?
    public var headers: [String: String] = [:]
    
    public init() {}
    
}

public extension SKMediaResource {
    
    func request(_ request: HTTPRequest) -> SKMediaResource {
        self.url = request.url
        var headers: [String: String] = [:]
        for field in request.headerFields {
            headers[field.name.rawName] = field.value
        }
        self.headers = headers
        return self
    }
    
    func url(_ string: String) -> SKMediaResource {
        self.url = URL(string: string)
        return self
    }
    
    func urlAsset(_ item: AVURLAsset) -> SKMediaResource {
        self.url = item.url
        return self
    }
    
}
