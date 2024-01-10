//
//  AssemblerAware.swift
//  Movies
//
//  Created by Adam Cseke on 09/01/2024.
//

import Foundation
import SwiftUI
import Swinject

protocol AssemblerAware {
    var assembler: MainAssembler { get }
}

extension AssemblerAware {
    var assembler: MainAssembler {
        return MainAssembler.instance
    }
}
