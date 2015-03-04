/**
 * Created by Igor on 03.03.2015.
 */
package ru.sq {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;

public class Rect {
    private var bgColor:uint = 0xffb8ff;
    private var borderColor:uint = 0x666666;
    private var defaultSize:uint = 32;
    private var parent:Field;
    public var x:int;
    public var y:int;
    public var width:int;
    public var height:int;
    public var id:int;
    public static var MAX_VALUE:int = 255;
    public var connectedRects:Vector.<Rect>;

    public function Rect(_x:int, _y:int, _parent:Field) {
        super();
        var red:int = int(Math.random()*MAX_VALUE);
        var green:int = int(Math.random()*MAX_VALUE);
        var blue:int = int(Math.random()*MAX_VALUE);
        bgColor = (red << 16 | green << 8 | blue);
        width = defaultSize/2;
        height = defaultSize;
        x = _x - width/2;
        y = _y - height/2;
        parent = _parent;
        id = Field.seed++;
        connectedRects = new Vector.<Rect>();
    }

    public function get right():int {
        return x;
    }

    public function get left():int {
        return x+width;
    }

    public function get top():int {
        return y;
    }

    public function get bottom():int {
        return y+height;
    }

    public function Render():void {
        (parent).graphics.beginFill(bgColor);
        (parent).graphics.lineStyle(1, borderColor);
        (parent).graphics.drawRect(x, y, width, height);
        (parent).graphics.endFill();
    }

    public function intersects(rect:Rect):Boolean {
        if (rect.x < this.x + this.width && this.x < rect.x + rect.width && rect.y < this.y + this.height)
            return this.y < rect.y + rect.height;
        else
            return false;
    }

    public function hitTestPoint(_x:int, _y:int):Boolean {
        return (_x > right && _x < left && _y > top && _y < bottom);
    }
}
}
