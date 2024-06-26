
// MakeItSo
//
// Created by Peter Friese on 01.03.23.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

