//
//  Handle.swift
//  GoogleTest
//
//  Created by Diego Aragón Duarte on 15/02/20.
//  Copyright © 2020 Diego Aragón Duarte. All rights reserved.
//

import SwiftUI

struct Handle: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.secondary)
            .frame(width: 60, height: 6)
            .padding(5)
    }
}
