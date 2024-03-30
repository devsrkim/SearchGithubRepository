//
//  CoreDataManager.swift
//  SearchGithubRepository
//
//  Created by srkim on 2024/03/30.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    private let persistentContainer = NSPersistentContainer(name: "Search")
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private let results = NSFetchRequest<RecentSearch>(entityName: "RecentSearch")
    
    init() {
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                print("Core data failed: \(error)")
            }
        }
    }
    
    func create(searchText: String) {
        let recentSearch = RecentSearch(context: context)

        recentSearch.date = Date()
        recentSearch.searchText = searchText
        
        save()
    }
    
    func read() -> [RecentSearch] {
        return try! context.fetch(results)
    }
}

extension CoreDataManager {
    private func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
