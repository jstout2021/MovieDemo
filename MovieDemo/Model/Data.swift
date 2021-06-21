//
//  Data.swift
//  MovieDemo
//
//  Created by Jason Stout on 6/21/21.
//

import Foundation
import SwiftUI

struct Result: Codable {
    var actors: Dictionary<String, String>
    //var movies: Dictionary<String, String>
}

struct Movie: Codable, Identifiable {
    var id: String
    var title: String
    var actors: [Int]
}

struct Actor: Codable, Identifiable {
    var id: String
    var name: String
}

class Api: ObservableObject {
    @Published var movies = [Movie]()
    @Published var actors = [Actor]()
    
    func fetchData() {
        guard let url = URL(string: "https://movie-database-server.appspot.com/database_small") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("URLSESSION DATA TASK ERROR: \(error!.localizedDescription)")
                return
            }
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let actorList = jsonObject["actors"] as? [String:String] {
                    if let movieList = jsonObject["movies"] as? [String:Any] {
                        DispatchQueue.main.async {
                            self.movies.removeAll()
                            for movie in movieList {
                                let id = movie.key
                                let values = movie.value as? Dictionary<String,Any>
                                let actors = values?["actors"] as? Array<Int>
                                let title = values?["title"] as? String
                                self.movies.append(Movie(id: id, title: title ?? "noTitle", actors: actors ?? []))
                            }
                            self.actors.removeAll()
                            for actor in actorList {
                                self.actors.append(Actor(id: actor.key, name: actor.value))
                            }
                        }
                    }
                }
            } catch {
                print("JSONSerialization error: \(error)")
            }
        }
        .resume()
    }
}
