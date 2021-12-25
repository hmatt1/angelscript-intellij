interface IGuiElement {
  void addChild(IGuiElement @e);
}
class BaseGuiElement : IGuiElement {
  BaseGuiElement(IGuiElement @e) {
    _BaseGuiElement(e);
  }
  void _BaseGuiElement(IGuiElement @e) {
    @parent = e;
  }
  void set_parent(IGuiElement @e) property {
    if( e !is null )
      e.addChild(this);
  }
  void addChild(IGuiElement @e) {
    Children.insertLast(e);
  }
  IGuiElement@[] Children;
}
class GuiButton : BaseGuiElement {
  GuiButton(IGuiElement @e) {
    super(e);
  }
}
class GuiScrollBar : BaseGuiElement {
  GuiButton @button;
  GuiScrollBar(IGuiElement @e) {
    @button = GuiButton(this);
    super(e);
  }
}
