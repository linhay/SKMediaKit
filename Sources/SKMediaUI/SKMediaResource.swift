//
//  File.swift
//  MediaPlayer
//
//  Created by linhey on 4/11/25.
//

import Foundation
import Photos

public class SKMediaResource {
 
    public var url: URL?

    public init() {}
    
}

public extension SKMediaResource {
    
    func url(_ string: String) -> SKMediaResource {
        self.url = URL(string: string)
         return self
     }
     
     func urlAsset(_ item: AVURLAsset) -> SKMediaResource {
         self.url = item.url
         return self
     }
    
}
