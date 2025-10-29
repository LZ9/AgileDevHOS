/**
 * 按钮选择器样式
 * Created by zhouL on 2025/10/29.
 */
export class SelectorModifier implements AttributeModifier<ButtonAttribute> {
  private normalColor: ResourceColor
  private pressedColor: ResourceColor

  constructor(normalColor: ResourceColor, pressedColor: ResourceColor) {
    this.normalColor = normalColor
    this.pressedColor = pressedColor
  }

  applyNormalAttribute(instance: ButtonAttribute): void {
    instance.backgroundColor(this.normalColor)
  }

  applyPressedAttribute(instance: ButtonAttribute): void {
    instance.backgroundColor(this.pressedColor)
  }
}
