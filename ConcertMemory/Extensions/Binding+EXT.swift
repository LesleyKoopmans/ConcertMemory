//
//  Binding+EXT.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//
import SwiftUI
import Foundation

extension Binding where Value == Bool {
    
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
