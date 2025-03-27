//
//  ConcertAttributes.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 27/03/2025.
//

enum ConcertGenre: String, CaseIterable, Hashable {
    case soul, hiphop, blues, rock, jazz, country, pop, metal
    
    var headerImage: String {
        switch self {
        case .soul:
            return "https://picsum.photos/600/500"
        case .hiphop:
            return "https://picsum.photos/500/500"
        case .blues:
            return "https://picsum.photos/600/400"
        case .rock:
            return "https://picsum.photos/400/500"
        case .jazz:
            return "https://picsum.photos/500/500"
        case .country:
            return "https://picsum.photos/400/400"
        case .pop:
            return "https://picsum.photos/700/500"
        case .metal:
            return "https://picsum.photos/600/700"
        }
    }
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
