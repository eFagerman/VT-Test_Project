//
//  InactiveTicketView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-11.
//

import SwiftUI

protocol InactiveFlexticket: InactiveTicket {
    
    var travelPeriodsRemainingTitle: String { get }
    var travelPeriodsRemaining: String { get }
}


extension VerticalAlignment {
    
    private enum CenterAztecImage: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.top]
        }
    }
    
    static let centerAztecImage = VerticalAlignment(CenterAztecImage.self)
}

extension HorizontalAlignment {
    
    private enum AlignItems: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[HorizontalAlignment.center]
        }
    }
    
    static let alignItems = HorizontalAlignment(AlignItems.self)
}


struct InactiveFlexTicketView<ViewModel>: View where ViewModel: InactiveFlexticket {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .centerAztecImage)) {
            
            viewModel.backgroundColor
                .ignoresSafeArea()
//                .alignmentGuide(.centerAztecImage) { d in
//                    d[VerticalAlignment.top]
//                }
            
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
                    viewModel.fakeAztecImage
                        .resizable()
                        .frame(width: 224, height: 224, alignment: .leading)
                        .aspectRatio(contentMode: .fit)
                        .padding(32)
    //                        .alignmentGuide(.centerAztecImage, computeValue: { d in
    //                            return d[.centerAztecImage] - 200
    //                        })
                    
                    Divider()
                    
                    Text(viewModel.type)
                        .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 56, maxHeight: 56, alignment: .center)
                        .fixedSize()
                    
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 12, x: 0, y: 4)

                
                Spacer()
                    .frame(minHeight: 8, idealHeight: 24, maxHeight: 24, alignment: .center)
                    .fixedSize()
               
                VStack(spacing: 0) {
                    
                    HStack {
                        Image(systemName: "ticket").padding()
                        Text(viewModel.travelPeriodsRemainingTitle)
                        Spacer()
                        Text(viewModel.travelPeriodsRemaining).padding()
                    }
                    .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 44, maxHeight: 44, alignment: .center)
                    
                    Divider()
                    
                    Text(viewModel.lastActivationDay)
                        .padding()
                        .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 44, maxHeight: 44, alignment: .center)
                    
                    Text(viewModel.activateButtonTitle)
                        .frame(minWidth: 0, idealWidth: 320, maxWidth: 320, minHeight: 32, idealHeight: 48, maxHeight: 48, alignment: .center)
                        .background(Color.green)
                        .onTapGesture {
                            viewModel.activateTicketHandler?()
                        }
                    
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 12, x: 0, y: 4)
                
                Spacer(minLength: 20)
                
            }
            .frame(width: 320.0, alignment: .center)
            
        }
    }
}

struct InactiveFlexTicketView_Previews: PreviewProvider {
    static var previews: some View {
        InactiveFlexTicketView(viewModel: InactiveFlexTicketViewModel(ticketModel: TicketModel()))
    }
}

