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

struct RemindersMainView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var reminders = Reminder.samples
    @State private var isAddReminderDialogPresented = false
    
   
    
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View {
        
        ZStack{
            
            
            ZStack {
                Color.clear
            }
            .background(.black)
            VStack {
                List($reminders) { $reminder in
                    if !reminder.isCompleted {
                        HStack {
                            Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    reminder.isCompleted.toggle()
                                }
                            Text(reminder.title)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(Color.black)
                    }
                }
                .background(Color.black)
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: presentAddReminderView) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                            Text("new item")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 8)
                .padding(.horizontal)
            }
            .background(Color.black)
            
            
  
            
            
            .sheet(isPresented: $isAddReminderDialogPresented) {
                AddReminderView { reminder in
                    reminders.append(reminder)
                }
            }
            
            .background(.black)
           
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonB())
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
   
}


