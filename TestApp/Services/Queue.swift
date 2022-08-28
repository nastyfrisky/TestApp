//
//  Queue.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

import Foundation

protocol Queue {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: Queue {
    func async(execute work: @escaping () -> Void) {
        self.async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
