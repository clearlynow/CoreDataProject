//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alison Gorman on 11/2/22.
//


import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var lastNameFilter = "A"
    @State var predicateType : PredicateType = .contains
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortValues: [
                NSSortDescriptor(keyPath: \Singer.firstName, ascending: true),
                NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)
            ], predicate: predicateType) { (singer: Singer) in
                HStack {
                    Text("\(singer.wrappedFirstName)")
                    Text("\(singer.wrappedLastName)")
                }
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Last Name Begins with: A") {
                self.lastNameFilter = "A"
            }
            
            Button("Last Name Begins with: S") {
                self.lastNameFilter = "S"
            }
            
            Button("Contains: Sh") {
                self.lastNameFilter = "Sh"
            }
            
            Button("Contains: Sw") {
                self.lastNameFilter = "Sw"
            }

        }
    }
}
