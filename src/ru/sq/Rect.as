/**
 * Created by Igor on 03.03.2015.
 */
package ru.sq {

public class Rect {
    private var bgColor:uint = 0xffb8ff;
    private var borderColor:uint = 0x666666;
    private var defaultSize:uint = 32;
    private var parent:Field;

    public var x:int;
    public var y:int;
    public var width:int;
    public var height:int;
    public const MAX_VALUE:int = 255;

    public function Rect(_x:int, _y:int, _parent:Field) {
        super();

        //generate random color
        var red:int = int(Math.random()*MAX_VALUE);
        var green:int = int(Math.random()*MAX_VALUE);
        var blue:int = int(Math.random()*MAX_VALUE);
        bgColor = (red << 16 | green << 8 | blue);

        width = defaultSize/2;
        height = defaultSize;

        //set its position to the center of pointer(firstly it points at left top corner
        x = _x - width/2;
        y = _y - height / 2;

        //we don't have native parent - so let's create it
        parent = _parent;
    }

    public function get right():int {
        return x;
    }

    public function get left():int {
        return x + width;
    }

    public function get top():int {
        return y;
    }

    public function get bottom():int {
        return y + height;
    }

    public function Render():void {
        (parent).graphics.beginFill(bgColor);
        (parent).graphics.lineStyle(1, borderColor);
        (parent).graphics.drawRect(x, y, width, height);
        (parent).graphics.endFill();
    }

    public function intersects(rect:Rect):Boolean {
        return  rect.x < this.x + this.width &&
                this.x < rect.x + rect.width &&
                rect.y < this.y + this.height &&
                this.y < rect.y + rect.height;
    }

    public function hitTestPoint(_x:int, _y:int):Boolean {
        return (_x > right && _x < left && _y > top && _y < bottom);
    }
}
}
