//
//  ConcertModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//
import Foundation

struct ConcertModel: Identifiable, Hashable {
    let id: String
    let artist: String?
    let subtitle: String?
    let description: String?
    let instruments: [String: String]?
    let rating: Double?
    let concertGenre: ConcertGenre?
    let venue: String?
    let room: String?
    let profileImageName: String?
    let concertMedia: [String]?
    let authorId: String?
    let withUid: [String]?
    let concertDate: Date?
    let dateCreated: Date?
    
    init(
        id: String,
        artist: String? = nil,
        subtitle: String? = nil,
        description: String? = nil,
        instruments: [String: String]? = nil,
        rating: Double? = nil,
        concertGenre: ConcertGenre? = nil,
        venue: String? = nil,
        room: String? = nil,
        profileImageName: String? = nil,
        concertMedia: [String]? = nil,
        authorId: String? = nil,
        withUid: [String]? = nil,
        concertDate: Date? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.artist = artist
        self.subtitle = subtitle
        self.description = description
        self.instruments = instruments
        self.rating = rating
        self.concertGenre = concertGenre
        self.venue = venue
        self.room = room
        self.profileImageName = profileImageName
        self.concertMedia = concertMedia
        self.authorId = authorId
        self.withUid = withUid
        self.concertDate = concertDate
        self.dateCreated = dateCreated
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ConcertModel(id: UUID().uuidString, artist: "Atmosphere", subtitle: "Undergroud hiphop in de Melkweg", description: "Na ze in totaal 6x te hebben gezien vallen ze nog steeds niet tegen. Elke keer weten ze weer te verassen met nieuwe versies van de bekende nummers. Alle oude klasiekers kwamen zoals gebruikelijk langs.", instruments: ["Guitar": "Henk", "Keys": "Joop", "Drums": "Pieter"], rating: 4, concertGenre: .hiphop, venue: "Melkweg", room: "Kleine zaal", profileImageName: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", withUid: ["https://picsum.photos/600/500", "https://picsum.photos/600/400", "https://picsum.photos/500/500"], concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Robert Jon & The Wreck", subtitle: "Southern Rock op z'n best", rating: 4, concertGenre: .rock, venue: "Burgerweeshuis", profileImageName: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", withUid: ["user_1"], concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "The Roots", subtitle: "Groot feest met een live band", description: "Een van de weinige acts die nog op de verlanglijst stond. Twee uur lang speelden ze aaneengesloten, ze hadden amper geduld om applaus te incaseren. De band bestond uit 7 leden waarbij iedereen aan goed tot z'n recht kwam.", rating: 4.5, concertGenre: .hiphop, venue: "Paradiso", room: "Grote zaal", profileImageName: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", withUid: ["user_2", "user_3", "user_4"], concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Dawn Brothers", subtitle: "Soul met een oldschool randje", concertGenre: .soul, venue: "Metropool", room: "Bud zaal", profileImageName: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_2", withUid: ["user_1"], concertDate: .now, dateCreated: .now)
        ]
    }
}
