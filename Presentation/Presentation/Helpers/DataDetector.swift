//
//  DataDetector.swift
//  Rakeb user
//
//  Created by prog_zidane on 12/30/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

public class DataDetector {
    
    class public func find(in string: String) -> [String] {
        var results = [String]()
        
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return results }

        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: string) else { continue }
            let url = string[range]
            results.append(String(url))
        }
        return results
    }
    
}

// MARK: String extension

public extension String {
    var detectedLinks: [String] { DataDetector.find(in: self) }
    var detectedURLs: [URL] { detectedLinks.compactMap { URL(string: $0) } }
}
