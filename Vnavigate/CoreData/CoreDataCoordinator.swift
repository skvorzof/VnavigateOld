//
//  CoreDataCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 23.01.2023.
//

import CoreData
import Foundation

final class CoreDataCoordinator {
    static let shared = CoreDataCoordinator()

    private var persistentContainer: NSPersistentContainer

    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private var fetchedResultsController: NSFetchedResultsController<Favorite> {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "article", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "Favorite")

        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            print(error.localizedDescription)
        }

        return fetchedResultsController
    }

    private init() {
        let container = NSPersistentContainer(name: "FavoriteModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("\(error)")
            }
        }

        persistentContainer = container
    }

    private func saveContext() {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            fatalError("\(error)")
        }
    }

    func fetchFavoritePosts(completion: @escaping (FetchResult<Favorite>) -> Void) {
        guard let favoritePosts = fetchedResultsController.fetchedObjects else {
            completion(.failure(CustomError.coreDataFetchError))
            return
        }

        completion(.success(favoritePosts))
    }

    func savePostToFavorite(post: Post) {
        guard let favoritePosts = fetchedResultsController.fetchedObjects else { return }

        if favoritePosts.contains(where: { $0.article == post.article }) {
            return
        } else {
            let newFavoritePost = Favorite(context: context)
            newFavoritePost.thumbnail = post.thumbnail
            newFavoritePost.article = post.article
            newFavoritePost.isLike = post.isLike
            newFavoritePost.isFavorites = post.isFavorites
            newFavoritePost.like = Int16(post.like)

            saveContext()
        }
    }

    func deleteFavoritePost(post: Favorite) {
        guard let favoritePosts = fetchedResultsController.fetchedObjects else { return }

        favoritePosts.forEach { favorite in
            context.delete(post)
        }

        saveContext()
    }
}
