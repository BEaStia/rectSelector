/**
 * Created by Igor on 03.03.2015.
 */
package ru.sq {
import caurina.transitions.Tweener;
import flash.events.MouseEvent;

public class Field extends BaseField {
    //rectangles at field
    private var rects:Vector.<Rect> = new Vector.<Rect>();

    public function Field() {
        super();
    }

    public override function onDoubleClick(event:MouseEvent):void {
        //reset connection
        if (connectedRectangle) {
            connectedRectangle = null;
            return;
        }
		//check all rectangles if we're selecting one of them
        var count:int = rects.length;
        selectedRectangle = null;
        for (var i:int = 0; i < count; i++) {
            if (rects[i].hitTestPoint(event.localX, event.localY)) {
                connectedRectangle = rects[i];
                return;
            }
        }

		//create new rectangle. Check whether we can place it
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
		//render all rects
        for each(var rect:Rect in rects) {
            rect.Render();
        }
    }

    private function CheckPair(a:Rect, b:Rect):void {
        // check if pair already exists
        var pairIndex:int = -1;
        var containsPair:Boolean = pairs.some(function (element:Object, index:int, v:Vector.<Object>):Boolean {
            var match:Boolean = (element.start == a && element.end == b) || (element.start == b && element.end == a);
            //and if match found - remember index for further deletion
            if (match)
                pairIndex = index;
            return match;
        });
        //if it's true - then remove pair
        if (containsPair) {
            pairs.splice(pairIndex, 1);
        } else {
            //otherwise -
            pairs.push({start: a, end: b});
        }
    }

    public override function onMouseDown(event:MouseEvent):void {
        selectedRectangle = null;
		//find rectangle we intersect by mouse pointer.
        var rect:Rect = IntersectsPoint(event.localX, event.localY);
        if (rect != null) {
			//if we're connecting rectangles - create a pair of them/delete existing pair
            if (connectedRectangle && connectedRectangle != rect) {
                CheckPair(rect, connectedRectangle);
                connectedRectangle = null;
            } else
			//or select it
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
            if ( rect != _rect && rect.intersects(_rect)) {
                return true;
            }
        }
        return false;
    }

    public override function onMouseUp(event:MouseEvent):void {
		//unselect rectangle on mouse up
        selectedRectangle = null;
    }

    public override function onMouseMove(event:MouseEvent):void {
		//on moving mouse createTweener.
		// on tween update check whether we can go far. Otherwise - select previous position;
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
