//
//  CalendarView.swift
//  AutiCare
//
//  Created by sourav_singh on 05/06/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth: Int = Calendar.current.component(.month, from: Date())
       @State private var currentYear: Int = Calendar.current.component(.year, from: Date())
       @State private var completedDays: Set<Int> = []

       @State private var gamesCompleted: CGFloat = 10
       @State private var videoSessionsCompleted: CGFloat = 5
       @State private var booksRead: CGFloat = 7

       var body: some View {
           VStack {
               HStack {
                   Button(action: previousMonth) {
                       Image(systemName: "chevron.left")
                           .padding()
                   }
                   Spacer()
                   Text("\(monthYearString())")
                       .font(.headline)
                       .padding()
                   Spacer()
                   Button(action: nextMonth) {
                       Image(systemName: "chevron.right")
                           .padding()
                   }
               }

               LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                   ForEach(daysInMonth(), id: \.self) { day in
                       DayView(day: day, isCompleted: completedDays.contains(day))
                           .onTapGesture {
                               if completedDays.contains(day) {
                                   completedDays.remove(day)
                               } else {
                                   completedDays.insert(day)
                               }
                           }
                   }
               }
               .padding()

               VStack(alignment: .leading) {
                   ActivityBarView(activityName: "Games", completed: gamesCompleted, total: 20, color: .blue)
                   ActivityBarView(activityName: "Video Sessions", completed: videoSessionsCompleted, total: 20, color: .green)
                   ActivityBarView(activityName: "Books", completed: booksRead, total: 20, color: .orange)
               }
               .padding()
           }
       }

       // Helper functions to get days in the current month
       func daysInMonth() -> [Int] {
           let dateComponents = DateComponents(year: currentYear, month: currentMonth)
           let calendar = Calendar.current
           let date = calendar.date(from: dateComponents)!
           let range = calendar.range(of: .day, in: .month, for: date)!
           return Array(range)
       }

       // Functions to navigate between months
       func previousMonth() {
           if currentMonth == 1 {
               currentMonth = 12
               currentYear -= 1
           } else {
               currentMonth -= 1
           }
       }

       func nextMonth() {
           let currentDate = Date()
           let currentMonth = Calendar.current.component(.month, from: currentDate)
           let currentYear = Calendar.current.component(.year, from: currentDate)

           if self.currentMonth == 12 {
               self.currentMonth = 1
               self.currentYear += 1
           } else {
               self.currentMonth += 1
           }

           if self.currentYear == currentYear && self.currentMonth > currentMonth {
               self.currentMonth = currentMonth
           }
       }

       // Helper function to get month and year string
       func monthYearString() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMMM yyyy"
           let dateComponents = DateComponents(year: currentYear, month: currentMonth)
           let date = Calendar.current.date(from: dateComponents)!
           return dateFormatter.string(from: date)
       }
   }

   struct DayView: View {
       let day: Int
       let isCompleted: Bool

       var body: some View {
           VStack {
               Text("\(day)")
                   .font(.caption)
                   .foregroundColor(.black)

               Image(systemName: isCompleted ? "checkmark.square.fill" : "square")
                   .foregroundColor(isCompleted ? .green : .gray)
           }
           .frame(width: 40, height: 40)
           .background(Color.white)
           .cornerRadius(5)
           .shadow(radius: 1)
       }
   }

   struct ActivityBarView: View {
       let activityName: String
       let completed: CGFloat
       let total: CGFloat
       let color: Color

       var body: some View {
           VStack(alignment: .leading) {
               Text(activityName)
                   .font(.caption)
                   .padding(.bottom, 2)
               ZStack(alignment: .leading) {
                   Rectangle()
                       .frame(width: 335, height: 30)
                       .opacity(0.3)
                       .foregroundColor(color)
                   Rectangle()
                       .frame(width: min(completed / total * 200, 200), height: 23)
                       .foregroundColor(color)
                       .animation(.linear)
               }
           }
           .padding(.bottom, 10)
       }
   }

   struct CalendarView_Previews: PreviewProvider {
       static var previews: some View {
           CalendarView()
       }
   }
