//
//  MedHistoryViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/16/25.
//saves, deletes, and adds the users entries for med report

import Foundation
import Firebase
import FirebaseFirestore


class MedReportViewModel: ObservableObject {
    //array storing entries of type EntriesViewModel
    @Published var entries: [EntriesViewModel] = []
    //access to firebase database
    private let db = Firestore.firestore()

    //loading all med info for a user
    func loadEntries(for userId: String){
        //sorting med info by date
        db.collection("users").document(userId).collection("medications").order(by: "date", descending: true)
        //getting data from firebase database
        .getDocuments{ snapshot, error in
            //if data grabbing was successful, go through each document the database
            if let documents = snapshot?.documents {
                self.entries = documents.compactMap { doc in
                    //turn data into swift object
                    return EntriesViewModel.fromDictionary(dict: doc.data(), documentID: doc.documentID)
                }
            }
            //otherwise, data was not grabbed successfully so display error message
            else{
            print("Issue loading entries: \(error?.localizedDescription ?? "Issue unknown")")
            }
        }
    }
    
    func addEntry(_ entry: EntriesViewModel, for userId: String) {
        //adds a new med report to list
        entries.append(entry)
        //converting to something Firebase understands
        let entryData = entry.toDictionary()

        //accessing users info and adding data as a new document
        db.collection("users")
            .document(userId)
            .collection("medications")
            .addDocument(data: entryData) { error in
                //error if something goes wrong
                if let error = error {
                    print("Issue saving entry: \(error.localizedDescription)")
                }
                else{
                    print("Entry saved successfully")
                }
            }
    }

    func deleteEntry(at offsets: IndexSet, for userId: String){
        let dispatchGroup = DispatchGroup()
        var indicesToRemove: IndexSet = []
        //accessing each entry with a loop
        for index in offsets {
            let entry = entries[index]
            dispatchGroup.enter()
            //accessing the entry through firebase database
            db.collection("users")
                .document(userId)
                .collection("medications")
                //finding the correct med entry based on ID
                .whereField("id", isEqualTo: entry.id.uuidString)
                .getDocuments { snapshot, error in
                    //if document is found, access it
                    if let documents = snapshot?.documents, let doc = documents.first {
                        //delete the document
                        doc.reference.delete{ error in
                            //if there was an error deleting
                            if let error = error{
                                print("Issue deleting document: \(error.localizedDescription)")
                            }
                            else{
                                //if document was deleted
                                print("Document deleted successfully")
                                indicesToRemove.insert(index)
                            }
                            dispatchGroup.leave()
                        }
                    }
                    //if no documents are found or if something goes wrong
                    else{
                        print("Error retrieving document: \(error?.localizedDescription ?? "Unknown error")")
                        dispatchGroup.leave()
                    }

                }
        }

        //deleting entry locally from array AFTER it was deleted in firebase database
        dispatchGroup.notify(queue: .main){
            self.entries.remove(atOffsets: indicesToRemove)
        }
    }
}
