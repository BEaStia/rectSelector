/**
 * Created by Igor on 03.03.2015.
 */
package ru.sq {
import caurina.transitions.Tweener;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Field extends BaseField {

    private var rects:Vector.<Rect> = new Vector.<Rect>();
    public static var seed:int = 0;

    public function Field() {
        super();
    }

    public override function onDoubleClick(event:MouseEvent):void {
        var count:int = rects.length;
        selectedRectangle = null;
        for (var i:int = 0; i < count; i++) {
            if (rects[i].hitTestPoint(event.localX, event.localY)) {
                connectedRectangle = rects[i];
                return;
            }
        }

        trace("double clicked!");
        var rect:Rect = new Rect(event.localX, event.localY, this);
        for each (var _rect:Rect in rects) {
            if ( rect.intersects(_rect)) {
                return;
            }
        }
        rects.push(rect);
        Redraw(event);
    }

    public override function Redraw(event:MouseEvent):void {
        super.Redraw(event);
        for each(var rect:Rect in rects) {
            rect.Render();
        }
    }

    public override function onMouseDown(event:MouseEvent):void {
        var count:int = rects.length;
        selectedRectangle = null;
        var rect:Rect = IntersectsPoint(event.localX, event.localY);
        if (rect != null) {
            if (connectedRectangle && connectedRectangle != rect) {
                pairs.push({start: rect, end: connectedRectangle});
                connectedRectangle = null;
            } else
                selectedRectangle = rect;
        }
    }

    public override function IntersectsPoint(_x:int, _y:int):* {
        for (var i:int = 0; i < rects.length; i++) {
            if (rects[i].hitTestPoint(_x, _y)) {
                return rects[i];
            }
        }
        return null;
    }

    public override function InterSectsAnyRectangle(rect:*):Boolean {
        for each(var _rect:Rect in rects) {
            if ( rect.id != _rect.id && rect.intersects(_rect)) {
                return true;
            }
        }
        return false;
    }

    public override function onMouseUp(event:MouseEvent):void {
        selectedRectangle = null;
    }

    public override function onMouseMove(event:MouseEvent):void {
        if (selectedRectangle) {
            var previousX:int = selectedRectangle.x;
            var previousY:int = selectedRectangle.y;
            Tweener.addTween(selectedRectangle, {
                time: 0.1,
                transition: "easeOut",
                x: event.localX - selectedRectangle.width / 2,
                y: event.localY - selectedRectangle.height / 2,
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
}
}
