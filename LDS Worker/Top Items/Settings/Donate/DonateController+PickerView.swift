//
//  DonateController+1.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/17/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension DonateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return donateView.donationAmount.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return donateView.donationAmount[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
