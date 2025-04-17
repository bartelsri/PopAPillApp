//
//  DatesViewModel.swift
//  PopAPill
//
//  Created by jossyris on 4/13/25.
//


import Foundation

public class DatesViewModel: ObservableObject {

   /// Title for the notification
   var title: String = ""
   /// Id for each element in list
   var iD: String = UUID().uuidString
   /// Time and date for each element in list
   var minute: Int?
   var hour: Int?
   var day: Int?
   var month: Int?
   var year: Int?

   /// Builds a date from the provided elements
   var date: Date {
       let currentYear = Calendar.current.component(.year, from: Date())
       // If no date was specificed, specify with the given elements/default
       return createDate(year: year ?? currentYear,
                         month: month ?? 01,
                         day: day ?? 01,
                         hour: hour ?? 0,
                         minute: minute ?? 0

       )
   }

    
    

   /// Func for creating date objects
   private func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {

       //Passing each date components into their respected element

       var dateComponents = DateComponents()
       dateComponents.year = year
       dateComponents.month = month
       dateComponents.day = day
       dateComponents.hour = hour
       dateComponents.minute = minute
       let calendar = Calendar.current
       return Calendar.current.date(from: dateComponents) ?? Date()
   }

}
