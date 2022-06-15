//
//  MovieViewerApp.swift
//  MovieViewer
//
//  Created by Colin Smith on 6/14/22.
//

import SwiftUI

@main
struct MovieViewerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListView()
            }
        }
    }
}
