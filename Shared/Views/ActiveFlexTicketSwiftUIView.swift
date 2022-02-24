//
//  ActiveFlexTicketSwiftUIView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-15.
//

import SwiftUI

protocol ActiveFlexTicket: ActiveTicket {
    
    var travelPeriodsRemainingTitle: String { get }
    var travelPeriodsRemaining: String { get }
    var validityDateTitle: String { get }
    var validityDate: String { get }
}

struct ActiveFlexTicketSwiftUIView<ViewModel>: View where ViewModel: ActiveFlexTicket {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .centerAztecImage)) {
            
            viewModel.backgroundColor
                .ignoresSafeArea()
                
            
            VStack {
                
                Spacer()
                    .frame(minHeight: 32, idealHeight: 100, maxHeight: 200, alignment: .center)
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
                    
                    
                    Text(viewModel.identifier).padding(.bottom)

                    Divider()

                    Text(viewModel.type)
                        .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 56, maxHeight: 56, alignment: .center)
                        .fixedSize()

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
                
                Spacer()
                    .frame(minHeight: 8, idealHeight: 24, maxHeight: 24, alignment: .center)
                    .fixedSize()
                
                VStack {
                    
                    HStack {
                        Image(systemName: "ticket").padding()
                        Text(viewModel.travelPeriodsRemainingTitle)
                        Spacer()
                        Text(viewModel.travelPeriodsRemaining).padding()
                    }
                    .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 44, maxHeight: 44, alignment: .center)
                    
                    HStack {
                        Image(systemName: "calendar").padding()
                        Text(viewModel.validityDateTitle)
                        Spacer()
                        Text(viewModel.validityDate).padding()
                    }
                    .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 44, maxHeight: 44, alignment: .center)
                    
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

struct ActiveFlexTicketSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveFlexTicketSwiftUIView(viewModel: ActiveFlexTicketViewModel(ticketModel: TicketModel()))
    }
}
