@Entry
@Component
@Preview({ deviceType: "phone" })
struct Index {
  @State private message: string = 'Hello World'
  private text = 'HOS'
  private n1 = 2
  private n2 = 3.141592
  private n3 = .5
  private n4 = 1e2

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = this.text
          let z = f()
          z()
          this.text = z().toString()

        })
    }
    .height('100%')
    .width('100%')
  }
}


function f(): () => number {
  let count = 0
  let g = (): number => {
    count++
    return count
  }
  return g
}