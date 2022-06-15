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
    @StateObject var viewModel = MovieListViewModel()
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(6)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                    TextField("Search For Movies...", text: $searchText)
                        .font(Font.system(size: 24))
                        .cornerRadius(6)
                }
                .background(.white)
                .padding([.bottom, .top], 8)
                .padding([.leading, .trailing], 8)
            }
            .frame(height: 24)
            .padding([.bottom, .top],  24)
            .padding([.leading, .trailing], 4)
            ScrollView {
                ForEach(viewModel.movieList) { movie in
                    MovieListCell(viewModel: MovieDetailViewModel(movie: movie))
                }
                if !viewModel.movieList.isEmpty {
                    Button {
                        page += 1
                        Task {
                           await viewModel.fetchMovies(searchTerm: searchText, page: page)
                        }
                    } label: {
                        Text("Load More")
                    }
                }

            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .padding([.leading, .trailing], 24)
           
            Spacer()
            Button {
                Task {
                    await viewModel.fetchMovies(searchTerm: searchText, page: page)
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Search")
                        .font(Font.system(size: 24))
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(6)
            .padding([.bottom, .leading, .trailing], 24)

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
            Task {
               await viewModel.fetchImage()
            }
        }
        .frame(height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
