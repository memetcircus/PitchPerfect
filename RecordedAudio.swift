//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mehmet Akif Acar on 19/06/15.
//  Copyright (c) 2015 Memetcircus. All rights reserved.
//

import Foundation

///model class

class RecordedAudio {
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}