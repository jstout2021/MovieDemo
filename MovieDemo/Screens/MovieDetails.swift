//
//  MovieDetail.swift
//  MovieDemo
//
//  Created by Jason Stout on 6/21/21.
//

import SwiftUI

struct MovieDetails: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var actor: Actor
    var movie: Movie
    var actors: [Actor]
    var movies: [Movie]
    var actorsList: [Actor]
    
    var body: some View {
        VStack {
            Text(movie.title)
            Text("Actors in \(movie.title)")
            List(actors) { actor in
                /*NavigationLink(
                    destination: ActorDetails(actor: actor, movies: movies, actors: actorsList),
                    label: {
                        Text(actor.name)
                    })*/
                Button(action: {
                    self.actor = actor
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text(actor.name)
                })
            }
        }
    }
}
