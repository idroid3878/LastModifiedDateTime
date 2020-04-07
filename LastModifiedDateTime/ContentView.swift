//
//  ContentView.swift
//
//  Created by Son Nguyen on 04/06/2020

import SwiftUI
//import Foundation

struct ContentView : View {
    @State private var showAlert = false
    var last_time_stamp:String
    
    init(_ tstamp:String) {
        last_time_stamp="TimeStamp="+tstamp
    }
    
    var alert: Alert {
        Alert(title: Text("BellMedia"), message: Text( last_time_stamp ), dismissButton: .default(Text("Dismiss")))
    }
    
    var body: some View {
        Button(action: {
            self.showAlert.toggle()
        }) {
            Text("GetTimeStamp!")
        }
        .alert(isPresented: $showAlert, content: { self.alert })
    }
}

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView("Test")
//    }
//}
//#endif
