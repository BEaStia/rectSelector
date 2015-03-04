/**
 * Created by Igor on 04.03.2015.
 */
package ru.sq {
import caurina.transitions.Tweener;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class FieldWithEmbedded extends BaseField {
    public var selectionX:int = 0;
    public var selectionY:int = 0;
    public var connections:Array = [];

    public function FieldWithEmbedded() {
        super();
    }

    public override function onMouseMove(event:MouseEvent):void {
        if (selectedRectangle) {
            var previousX:int = selectedRectangle.x;
            var previousY:int = selectedRectangle.y;
            Tweener.addTween(selectedRectangle, {
                time: 0.1,
                transition: "easeOut",
                x: mouseX - selectedRectangle.width / 2,
                y: mouseY - selectedRectangle.height / 2
                ,
                onUpdate: function ():void {
                    if (selectedRectangle) {
                        if (InterSectsAnyRectangle(selectedRectangle)) {
                            selectedRectangle.x = previousX;
                            selectedRectangle.y = previousY;
                            Tweener.removeTweens(selectedRectangle);
                        }
                        previousX = selectedRectangle.x;
                        previousY = selectedRectangle.y;
                    }
                }
            });
        }
        Redraw(event);

    }

    public override function onMouseUp(event:MouseEvent):void {
        selectedRectangle = null;
    }

    public override function InterSectsAnyRectangle(rect:*):Boolean {
        var count:int = numChildren;
        for (var i:int = 0; i < count; i++) {
            if ((getChildAt(i) as Rectangle).hitTestObject(rect) && getChildAt(i) != rect)
                return true;
        }
        return false;
    }

    public override function IntersectsPoint(_x:int ,_:int):* {
        var count:int = numChildren;
        for (var i:int = 0; i < count; i++) {
            var rect:Rectangle = getChildAt(i) as Rectangle;
            if ((rect as Rectangle).hitTestPoint(mouseX, mouseY))
                return rect;
        }
        return null;
    }

    public override function onDoubleClick(event:MouseEvent):void {
        var count:int = numChildren;
        selectedRectangle = null;
        for (var i:int = 0; i < count; i++) {
            if (getChildAt(i).hitTestPoint(mouseX, mouseY)) {
                connectedRectangle = getChildAt(i) as Rectangle;
                return;
            }
        }

        trace("double clicked!");
        var rect:Rectangle = new Rectangle();
        rect.x = mouseX - rect.width / 2;
        rect.y = mouseY - rect.height / 2;
        if (!InterSectsAnyRectangle(rect))
            this.addChild(rect);
        Redraw(event);
    }

    public override function onMouseDown(event:MouseEvent):void {
        selectedRectangle = null;
        var rect:Rectangle = IntersectsPoint(mouseX, mouseY);
        if (rect != null) {
            if (connectedRectangle && connectedRectangle != rect) {
                pairs.push({start: rect, end: connectedRectangle});
                connectedRectangle = null;
            } else
                selectedRectangle = rect;
        }
    }
}
}
