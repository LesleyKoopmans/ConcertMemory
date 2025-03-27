//
//  ConcertAttributes.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

enum ConcertGenre: String, CaseIterable, Hashable {
    case soul, hiphop, blues, rock, jazz, country, pop, metal
}

enum Instrument: String, CaseIterable, Hashable {
    case microphone, guitar, drum, keys
    
    var emoji: String {
        switch self {
        case .microphone:
            return "music.microphone"
        case .guitar:
            return "guitars"
        case .drum:
            return "drum"
        case .keys:
            return "pianokeys"
        }
    }
}
