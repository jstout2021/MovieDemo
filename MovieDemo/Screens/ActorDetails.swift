//
//  ActorDetailsScreen.swift
//  MovieDemo
//
//  Created by Jason Stout on 6/21/21.
//

import SwiftUI

struct ActorDetails: View {
    @State var actor: Actor
    var movies: [Movie]
    var actors: [Actor]
    @State var moviesList = [Movie]()
    @State var actorList = [Actor]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
                .font(.headline)
            
            Text("Movies \(actor.name) has appeared in:")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            List(moviesList) { movie in
                NavigationLink(
                    destination: MovieDetails(actor: $actor, movie: movie, actors: actorList, movies: movies, actorsList: actors),
                    label: {
                        Text(movie.title)
                    })
            }
            Divider()
            Text("Actors \(actor.name) has appeard with:")
                .font(.subheadline)
                .fontWeight(.semibold)
            Spacer()
            List(actorList) { actor in
                Text(actor.name)
            }
            Spacer()
        }
        .padding()
        .onAppear() {
            getMoviesList()
        }
    }
    
    func getMoviesList() {
        moviesList.removeAll()
        actorList.removeAll()
        
        for movie in movies {
            if movie.actors.contains(Int(actor.id)!) {
                moviesList.append(movie)
                
                for id in movie.actors {
                    for actor in actors {
                        if id == Int(actor.id)! {
                            actorList.append(actor)
                        }
                    }
                }
            }
        }
    }
}

struct ActorDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
