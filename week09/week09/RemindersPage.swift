//
//  Reminders.swift
//  week09
//
//  Created by anya zhukova on 4/8/24.
//

import SwiftUI

struct RemindersPage: View {
    @State
    private var reminders = Reminder.samples
    
    @State
    private var isAddReminderDialogPresented = false
    
    
    @EnvironmentObject var pageModel: PageModel
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View {
           VStack {
               Text("Welcome, \(pageModel.username)")
               List($reminders) { $reminder in
                   HStack {
                       Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                           .imageScale(.large)
                           .foregroundColor(.accentColor)
                           .onTapGesture {
                               reminder.isCompleted.toggle()
                           }
                       Text(reminder.title)
                   }
               }
               
               Spacer() // Add Spacer to push the toolbar items to the bottom
               
               HStack {
                   Spacer()
                   Button(action: presentAddReminderView) {
                       HStack {
                           Image(systemName: "plus.circle.fill")
                           Text("New Reminder")
                       }
                   }
               }
               .padding(.bottom, 8) // Adjust the padding if needed
               .padding(.horizontal) // Add padding to the toolbar items
               
           }
           .sheet(isPresented: $isAddReminderDialogPresented) {
               AddReminderView { reminder in
                   reminders.append(reminder)
               }
           }
       }
    }


struct RemindersPage_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
        RemindersPage()
        .navigationTitle("Reminders")
    }
  }
}

