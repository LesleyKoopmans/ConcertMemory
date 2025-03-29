//
//  ConcertModel.swift
//  ConcertMemory
//
//  Created by Lesley Koopmans on 05/03/2025.
//
import Foundation

struct ConcertModel: Identifiable, Hashable, Codable {
    let id: String
    let artist: String?
    let description: String?
    let instruments: [Instrument: String]?
    let rating: Double?
    let concertGenre: ConcertGenre?
    let venue: String?
    let room: String?
    private(set) var concertHeaderImageUrl: String?
    let concertMedia: [String]?
    let authorId: String?
    let withUid: [UserModel]?
    let concertDate: Date?
    let dateCreated: Date?
    
    init(
        id: String,
        artist: String? = nil,
        description: String? = nil,
        instruments: [Instrument: String]? = nil,
        rating: Double? = nil,
        concertGenre: ConcertGenre? = nil,
        venue: String? = nil,
        room: String? = nil,
        concertHeaderImageUrl: String? = nil,
        concertMedia: [String]? = nil,
        authorId: String? = nil,
        withUid: [UserModel]? = nil,
        concertDate: Date? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.artist = artist
        self.description = description
        self.instruments = instruments
        self.rating = rating
        self.concertGenre = concertGenre
        self.venue = venue
        self.room = room
        self.concertHeaderImageUrl = concertHeaderImageUrl
        self.concertMedia = concertMedia
        self.authorId = authorId
        self.withUid = withUid
        self.concertDate = concertDate
        self.dateCreated = dateCreated
    }
    
    mutating func updateConcertHeaderImageUrl(imageUrl: String) {
        concertHeaderImageUrl = imageUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case artist
        case description
        case instruments
        case rating
        case concertGenre = "concert_genre"
        case venue
        case room
        case concertHeaderImageUrl = "concert_header_image_url"
        case concertMedia = "concert_media"
        case authorId = "author_id"
        case withUid = "with_uid"
        case concertDate = "concert_date"
        case dateCreated = "date_created"
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            ConcertModel(id: UUID().uuidString, artist: "Atmosphere", description: "Na ze in totaal 6x te hebben gezien vallen ze nog steeds niet tegen. Elke keer weten ze weer te verassen met nieuwe versies van de bekende nummers. Alle oude klasiekers kwamen zoals gebruikelijk langs.", instruments: [Instrument.microphone: "Henk", Instrument.keys: "Joop", Instrument.guitar: "Pieter"], rating: 4, concertGenre: .hiphop, venue: "Melkweg", room: "Kleine zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "mock_user_1", withUid: UserModel.mocks, concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Robert Jon & The Wreck", rating: 4, concertGenre: .rock, venue: "Burgerweeshuis", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", withUid: [UserModel.mock], concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "The Roots", description: "Een van de weinige acts die nog op de verlanglijst stond. Twee uur lang speelden ze aaneengesloten, ze hadden amper geduld om applaus te incaseren. De band bestond uit 7 leden waarbij iedereen aan goed tot z'n recht kwam.", rating: 4.5, concertGenre: .hiphop, venue: "Paradiso", room: "Grote zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_1", withUid: [UserModel.mock, UserModel.mocks[1]], concertDate: .now, dateCreated: .now),
            ConcertModel(id: UUID().uuidString, artist: "Dawn Brothers", concertGenre: .soul, venue: "Metropool", room: "Bud zaal", concertHeaderImageUrl: Constants.randomImage, concertMedia: [Constants.randomImage, "https://picsum.photos/600/500", "https://picsum.photos/500/600", "https://picsum.photos/500/500", "https://picsum.photos/600/650"], authorId: "user_2", withUid: nil, concertDate: .now, dateCreated: .now)
        ]
    }
}
