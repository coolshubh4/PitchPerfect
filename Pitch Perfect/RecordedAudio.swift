//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Shubham Tripathi on 05/07/15.
//  Copyright (c) 2015 Shubham Tripathi. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    // Initializing the filePathUrl and title, of the recorded audio
    init(filePathUrl: NSURL!, title: String!) {
        
        self.filePathUrl = filePathUrl
        self.title = title
    }
}