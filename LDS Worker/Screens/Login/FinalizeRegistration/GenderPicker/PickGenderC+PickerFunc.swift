//
//  PickGenderC+PickerFunc.swift
//  LDS Worker
//
//  Created by Campus Life Design on 7/24/18.
//  Copyright © 2018 Robinson Paz. All rights reserved.
//

import UIKit

extension PickGenderController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected(row)
        print("rolling")
    }
    
    func rowSelected(_ row: Int) {
        
        switch row {
        case 0:
            navigationItem.rightBarButtonItem?.isEnabled = false
            
        case 1:
            navigationItem.rightBarButtonItem?.isEnabled = true
            potentialUser?.gender = "m"
            ImageService.defaultPhotoString = PictureKeys.brotherDefault.rawValue
        case 2:
            navigationItem.rightBarButtonItem?.isEnabled = true
            potentialUser?.gender = "f"
            ImageService.defaultPhotoString = PictureKeys.sisterDefault.rawValue
        default:
            potentialUser?.gender = "NOT SELECTION"
        }
    }
}

