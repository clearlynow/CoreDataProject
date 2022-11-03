//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Alison Gorman on 11/3/22.
//

import SwiftUI
import CoreData


enum PredicateType {
    case beginsWith
    case contains
}

struct FilteredList<T: NSManagedObject, Content: View>: View {

    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content

    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, sortValues: [NSSortDescriptor], predicate: PredicateType, @ViewBuilder content: @escaping (T) -> Content) {
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortValues, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        
        self.content = content
    }
}

