//
//  ExecuteAfter.swift
//  Core
//
//  Created by prog_zidane on 1/4/21.
//

import Foundation


public func execute(After: Double, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + After) {
        block()
    }
}
