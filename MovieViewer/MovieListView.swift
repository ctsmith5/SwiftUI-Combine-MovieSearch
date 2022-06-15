//
//  ContentView.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import SwiftUI

struct MovieListView: View {
    @State var searchText = ""
    @State var page = 1
    @ObservedObject var viewModel = MovieListViewModel()
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                    TextField("Search For Movies...", text: $searchText)
                        .font(Font.system(size: 24))
                }
                .background(.white)
                .padding(12)
            }
            .frame(height: 24)
            .padding(24)
            ScrollView {
                ForEach(viewModel.movieList) { movie in
                    MovieListCell(viewModel: MovieDetailViewModel(movie: movie))
                }
                if !viewModel.movieList.isEmpty {
                    Button {
                        page += 1
                        viewModel.fetchMovies(searchTerm: searchText, page: page)
                    } label: {
                        Text("Load More")
                    }
                }

            }
            .padding([.leading, .trailing], 24)
           
            Spacer()
            Button {
                viewModel.fetchMovies(searchTerm: searchText, page: page)
            } label: {
                Text("Search")
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .font(Font.system(size: 24))
            .padding(.bottom, 24)

        }
        
    }
}

struct MovieListCell: View {
   @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        HStack {
            Image(uiImage: ((UIImage(data: viewModel.image ?? Data()) ?? UIImage(systemName: "exclamationmark.icloud.fill"))!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 120)
            Text(viewModel.movie.name)
            Spacer()
        }
        .onAppear {
            viewModel.fetchImage()
        }
        .frame(height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
