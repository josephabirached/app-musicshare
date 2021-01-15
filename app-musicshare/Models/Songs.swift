//
//  Songs.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 14/01/2021.
//

import Foundation


class Song: Codable {
    let id: String
    let name: String
    let artist: String
    let image: String
    let songUrl: String
    
    init(id: String, name:String, artist: String, image:String, songUrl: String){
        self.id = id
        self.name = name
        self.artist = artist
        self.image = image
        self.songUrl = songUrl
    }
    
}
