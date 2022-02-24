//
//  TestSwiftUIView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-14.
//

import SwiftUI


//extension VerticalAlignment {
//
//    private enum CenterAztecImage: AlignmentID {
//        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            return context[VerticalAlignment.center]
//        }
//    }
//
//    static let centerAztecImage = VerticalAlignment(CenterAztecImage.self)
//}

extension VerticalAlignment {
    /// A custom alignment for image titles.
    private struct ImageTitleAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            // Default to bottom alignment if no guides are set.
            context[VerticalAlignment.center]
        }
    }

    /// A guide for aligning titles.
    static let imageTitleAlignmentGuide = VerticalAlignment(
        ImageTitleAlignment.self
    )
}


struct TestSwiftUIView: View {
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .imageTitleAlignmentGuide)) {
            
//            VStack {
//                Image(systemName: "heart.fill")
//                    .resizable()
//                    .scaledToFit()
//
//                Text("Bell Peppers")
//                    .font(.title)
//                    .padding()
//                    .background(.gray)
//                    .alignmentGuide(.imageTitleAlignmentGuide) { context in
//                        context[VerticalAlignment.center]
//                    }
//            }
            
            Color.green.alignmentGuide(VerticalAlignment.imageTitleAlignmentGuide) { d in
                d[VerticalAlignment.center]
            }
            
            
            VStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .background(Color.blue)
                    .alignmentGuide(.imageTitleAlignmentGuide) { context in
                        context[VerticalAlignment.center]
                    }
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()

                Text("Chili Peppers")
                    .font(.title)
                    

                Text("Higher levels of capsicum")
                    .font(.caption)
                    .padding()
                
                //Spacer(minLength: 8).layoutPriority(1)
            }
        }
        .background(Color.orange)
    }
}



struct TestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestSwiftUIView()
    }
}
