//
//  ColorPickerView.swift
//  SwiftToDo
//
//  Created by Samarth MS on 17/12/22.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var choosenColor: String
    
    func hapticSuccess() {
        let gen = UINotificationFeedbackGenerator()
        gen.notificationOccurred(.success)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color: ").padding([.top,.leading])
            Collection(data: colors, columns: 4, spacing: 0) { c in
                ZStack {
                    withAnimation(.easeIn) {
                        Circle().foregroundColor(Color(self.choosenColor == c ? .systemBackground : .systemGray4))
                            .frame(width: 60, height: 60)
                    }
                    Image(systemName: "smallcircle.fill.circle.fill")
                        .foregroundColor(Color(c)).font(.system(size: 35, weight: .black))
                        .onTapGesture {
                            self.choosenColor=c
                            self.hapticSuccess()
                        }
                }
            }.frame(height: CGFloat(colors.count/4*80)).padding()
        }.padding().background(Color(.systemGray4)).cornerRadius(20)
    }
}

private struct Collection<Content: View, Data: Hashable>: View {
    var data: [Data]
    let viewBuilder: (Data) -> Content
    let columns: Int
    let spacing: CGFloat
    init(data: [Data], columns: Int = 3, spacing: CGFloat = 5, _ viewBuilder: @escaping (Data) -> Content) {
        self.data = data
        self.viewBuilder = viewBuilder
        self.columns = columns
        self.spacing = spacing
    }
    
    private func cell(colIndex: Int, rowIndex: Int) -> some View {
        let cellIndex = (rowIndex*columns) + colIndex
        return ZStack {
            if cellIndex < data.count {
                self.viewBuilder(data[cellIndex])
            }
        }
    }
    
    var body: some View {
        GeometryReader { g in
            VStack {
                self.constructView(geometry: g).frame(minHeight: g.frame(in: .global).height)
            }
        }
    }
    
    private func constructView(geometry: GeometryProxy) -> some View {
        let rowRem = Double(data.count).remainder(dividingBy: Double(columns))
        let rowCount = data.count/columns + (rowRem == 0 ? 0 : 1)
        let frame = geometry.frame(in: .global)
        let totSpacing = Int(spacing) * (columns-1)
        let cellWidth = (frame.width-CGFloat(totSpacing))/CGFloat(columns)
        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(0...rowCount-1, id: \.self) {r in
                HStack(spacing: self.spacing) {
                    ForEach(0...self.columns-1,id: \.self) { c in
                        self.cell(colIndex: c, rowIndex: r).frame(maxWidth: cellWidth)
                    }
                }
            }
        }
    }
    
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(choosenColor: .constant("blue"))
    }
}
