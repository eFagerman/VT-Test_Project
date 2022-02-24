//
//  TicketsView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-10.
//

import SwiftUI

protocol ActiveTicket: ObservableObject {
    var backgroundColor: Color { get }
    var priceCategoryColor: Color { get }
    var priceCategory: String { get }
    var operatorImage: Image { get }
    var aztecImage: Image { get }
    var identifier: String { get }
    var type: String { get }
    var timeLeftTitle: String { get }
    var timeLeft: String { get }
}


struct ActiveTicketSwiftUIView<ViewModel>: View where ViewModel: ActiveTicket {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .centerAztecImage)) {
            
            viewModel.backgroundColor
                
            
            VStack {
                
                Spacer()
                    .frame(minHeight: 8, idealHeight: 100, maxHeight: 400, alignment: .center)
                    .fixedSize()
                
                
                VStack(spacing: 0) {
                    
                    viewModel.priceCategoryColor.frame(height: 16.0)
                    
                    HStack {
                        Text(viewModel.priceCategory).padding()
                        Spacer()
                        viewModel.operatorImage.padding()
                    }
                    .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 52, maxHeight: 52, alignment: .center)
                    .fixedSize()
                    
                    Divider()
                    
                    // Here is the image that is centered with a custom alignment guide
                    viewModel.aztecImage
                        .resizable()
                        .frame(width: 224, height: 224, alignment: .leading)
                        .aspectRatio(contentMode: .fit)
                        .padding(32)
    //                        .alignmentGuide(.centerAztecImage, computeValue: { d in
    //                            return d[.centerAztecImage] - 200
    //                        })
                    
                    
                    Text(viewModel.identifier).padding(.bottom)

                    Divider()

                    Text(viewModel.type)
                        .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 56, maxHeight: 56, alignment: .center)
                        .fixedSize()
                        .font(.applicationFont(withWeight: .bold, andSize: 20))

                    Divider()

                    HStack {
                        Text(viewModel.timeLeftTitle).padding()
                        Spacer()
                        Text(viewModel.timeLeft).padding()
                    }
                    
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 12, x: 0, y: 4)
                
                Spacer(minLength: 8)
                
            }
            .frame(width: 320.0, alignment: .center)
            
        }.edgesIgnoringSafeArea(.all)
        
    }
}


struct ActiveTicketView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTicketSwiftUIView(viewModel: ActiveTicketViewModel(ticketModel: TicketModel()))
    }
}

