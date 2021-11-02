import Foundation
import ipworks3ds_sdk

internal final class ThreeDUICustomizationFactory {
    private func customizeButton(uiCustom: UiCustomization, type: ButtonType, backgroundColor: UIColor, textColor: UIColor) throws {
        let button = uiCustom.getButtonCustomization(buttonType: type)
        button.setBackgroundColor(color: backgroundColor)
        try button.setHeight(height: Style.Layout.Button.height)
        try button.setCornerRadius(cornerRadius: Int(Style.Layout.cornerRadius))
        button.setTextColor(color: textColor)
        try button.setTextFontName(fontName: Style.Font.button.familyName)
    }
    
    private func customizeButtons(uiCustom: UiCustomization) throws {
        try customizeButton(
            uiCustom: uiCustom,
            type: .SUBMIT,
            backgroundColor: Style.Color.primary,
            textColor: .white
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .RESEND,
            backgroundColor: .white,
            textColor: .black
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .NEXT,
            backgroundColor: Style.Color.success,
            textColor: .white
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .CANCEL,
            backgroundColor: .white,
            textColor: .black
        )
        
        try customizeButton(
            uiCustom: uiCustom,
            type: .CONTINUE,
            backgroundColor: Style.Color.success,
            textColor: .white
        )
    }
    
    func uiCustomization() throws -> UiCustomization {
        let uiCustom = UiCustomization()
        uiCustom.setBackground(color: .white)
        
        try customizeButtons(uiCustom: uiCustom)
        
        let labelCustomization = uiCustom.getLabelCustomization()
        labelCustomization.setHeadingTextColor(color: .black)
        try labelCustomization.setHeadingTextAlignment(textAlignment: .left)
        try labelCustomization.setHeadingTextFontName(fontName: Style.Font.title.fontName)
        try labelCustomization.setHeadingTextFontSize(fontSize: Int(Style.Font.title.pointSize))
        
        try labelCustomization.setTextFontName(
            forLabelType: .INFO_LABEL,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .INFO_LABEL,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .INFO_LABEL,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .WHY_INFO,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .WHY_INFO,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .WHY_INFO,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .WHY_INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .WHY_INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .WHY_INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .EXPANDABLE_INFO,
            fontName: Style.Font.tileLabel.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .EXPANDABLE_INFO,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .EXPANDABLE_INFO,
            fontSize: Style.Font.tileLabel.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .EXPANDABLE_INFO_TEXT,
            fontSize: Style.Font.body.pointSize)
        
        try labelCustomization.setTextFontName(
            forLabelType: .SELECTION_LIST,
            fontName: Style.Font.body.fontName)
        try labelCustomization.setTextColor(
            forLabelType: .SELECTION_LIST,
            color: .black)
        try labelCustomization.setTextFontSize(
            forLabelType: .SELECTION_LIST,
            fontSize: Style.Font.body.pointSize)
        
        let toolbarCustomization = uiCustom.getToolbarCustomization()
        try toolbarCustomization.setButtonText(buttonText: .localized("Cancel"))
        toolbarCustomization.setTextColor(color: .white)
        try toolbarCustomization.setTextFontName(fontName: Style.Font.body.fontName)
        try toolbarCustomization.setTextFontSize(fontSize: Int(Style.Font.body.pointSize))
        
        try labelCustomization.setBackgroundColor(forLabelType: .EXPANDABLE_INFO, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .EXPANDABLE_INFO_TEXT, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .WHY_INFO, color: .clear)
        try labelCustomization.setBackgroundColor(forLabelType: .WHY_INFO_TEXT, color: .clear)
        
        return uiCustom
    }
}
