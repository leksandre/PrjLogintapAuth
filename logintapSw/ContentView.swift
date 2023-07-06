//
//  ContentView.swift
//  logintapSw
//
//  Created by  Александр on 03.07.2023.
//  Copyright © 2023  Александр. All rights reserved.
//

import SwiftUI
import UIKit
var scanner1 = ScannerViewController()
//var datascanner: DataScannerViewController?

struct ContentView: View {
    @State var isActive = false
    @State var code = ""
    var body: some View {

      
        
        NavigationView {
            VStack {
                Text("Hello World")
                NavigationLink(destination: DetailView(isActive: $isActive, code: $code), isActive: $isActive, label: { EmptyView() })
                             Button(action: {
                                 self.isActive.toggle()
                             }, label: {
                                 Text("navigate")
                             })
            }
        }
        
        
    }
    
    
      
}

struct DetailView: View {

    @Binding var isActive: Bool
    @Binding var code: String
//    let scanner1 = ScannerViewController();



    var body: some View {
//            override func view


        
        VStack {
            Text("Welcome to second view")
                    .font(.title)
            
            Button(action: {
                self.code = "new code"
                self.isActive.toggle()
            }) {
                Text("Back")
            }
            
    
//  ScannerViewController();
           Text("scann your qr code Logintap");
          
            
                  ScannerView()
                 .frame(width: 300, height: 300)
                 .cornerRadius(10)
                 .shadow(radius: 10)
            
        }
        
        
    };
//    body.view.addSubview(scanner1)
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
