/**
 * Created by Igor on 04.03.2015.
 */
package ru.sq {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;

[Embed(source="../../../assets/rect.swf", symbol="MovieRectangle")]
public class Rectangle extends Sprite {

    private var _color:int = 0xffffff;
    const MAX_VALUE:int = 255;
    public function Rectangle() {
        super();
        this.cacheAsBitmap = true;
        this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
        this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }

    private function onMouseMove(event:MouseEvent):void {
        (parent as BaseField).onMouseMove(event);
    }

    private function onMouseUp(event:MouseEvent):void {
        (parent as BaseField).onMouseUp(event);
    }

    private function onDoubleClick(event:MouseEvent):void {
        (parent as FieldWithEmbedded).onDoubleClick(event);
    }

    private function onAddedToStage(event:Event):void {

        var red:int = int(Math.random()*MAX_VALUE);
        var green:int = int(Math.random()*MAX_VALUE);
        var blue:int = int(Math.random()*MAX_VALUE);
        _color = (red << 16 | green << 8 | blue);
        var myColorTransform:ColorTransform = new ColorTransform();

        myColorTransform.color = _color;
        this.transform.colorTransform = myColorTransform;
    }

    public function onMouseDown(event:MouseEvent) {
        (parent as BaseField).onMouseDown(event);
    }
}
}
