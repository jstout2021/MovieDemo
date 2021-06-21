//
//  HomeScreen.swift
//  MovieDemo
//
//  Created by Jason Stout on 6/21/21.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject private var viewModel = Api()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List(viewModel.actors) { actor in
                        NavigationLink(destination: ActorDetails(actor: actor, movies: viewModel.movies, actors: viewModel.actors), label: {
                            Text(actor.name)
                        })
                    }
                }
            }
            .onAppear() {
                viewModel.fetchData()
            }
            .navigationTitle("Actors")
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
