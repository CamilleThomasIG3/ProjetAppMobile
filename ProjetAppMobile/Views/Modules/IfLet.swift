//
//  IfLet.swift
//  ProjetAppMobile
//
//  Created by user165000 on 3/18/20.
//  Copyright © 2020 BourratSanchezThomas. All rights reserved.
//

import SwiftUI

struct IfLet<T, Out: View>: View {
  let value: T?
  let produce: (T) -> Out

  init(_ value: T?, produce: @escaping (T) -> Out) {
    self.value = value
    self.produce = produce
  }

  var body: some View {
    Group {
      if value != nil {
        produce(value!)
      }
    }
  }
}
