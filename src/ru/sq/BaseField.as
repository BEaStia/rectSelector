/**
 * Created by Igor on 04.03.2015.
 */
package ru.sq {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class BaseField extends Sprite implements IField{

    /**
     * Field size in px
     */
    protected var size:uint = 600;

    /**
     * Field background color
     */
    protected var bgColor:uint = 0x00b8ff;

    /**
     * Field border color
     */
    private var borderColor:uint = 0x666666;

    /**
     * Field border size
     */
    private var borderSize:uint = 0;

    /**
     * Connection line color
     */
    private var connectionColor:uint = 0x000000;

    /**
     * Pairs of connected rectangles
     */
    public var pairs:Vector.<Object> = new Vector.<Object>();

    /**
     * Selected rectangle for creating connection
     */
    public var connectedRectangle:*;

    /**
     * Selected rectangle for moving
     */

    public var selectedRectangle:*;

    public function BaseField() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
    }
    public function onDoubleClick(event:MouseEvent):void {
    }

    public function onEnterFrame(event:Event):void {
    }

    public function Redraw(event:MouseEvent):void {
		//clearing and drawing background
        graphics.clear();
        RedrawBackGround(event);
		
		//for each pair of connected rectangles i draw line between its' centers.
        graphics.beginFill(connectionColor);
        for each(var pair:Object in pairs) {
            graphics.moveTo(pair.start.x + pair.start.width / 2, pair.start.y + pair.start.height / 2);
            graphics.lineTo(pair.end.x + pair.end.width / 2, pair.end.y + pair.end.height / 2);
        }
        graphics.endFill();

		//draw line from rectangle we are connecting now to a mouse point
        if (connectedRectangle != null) {
            graphics.beginFill(0x000000);
            graphics.moveTo(connectedRectangle.x + connectedRectangle.width / 2, connectedRectangle.y + connectedRectangle.height / 2);
            graphics.lineTo(mouseX, mouseY);
            graphics.endFill();
        }
    }

    public function RedrawBackGround(event:MouseEvent):void {
        graphics.beginFill(bgColor);
        graphics.lineStyle(borderSize, borderColor);
        graphics.drawRect(0, 0, size, size);
        graphics.endFill();
    }

    public function onAddedToStage(event:Event):void {
        stage.frameRate = 60;
        Redraw(null);
    }

    public function onMouseDown(event:MouseEvent):void {
    }

    public function InterSectsAnyRectangle(rect:*):Boolean {
        return false;
    }

    public function onMouseUp(event:MouseEvent):void {
    }

    public function onMouseMove(event:MouseEvent):void {
    }

    public function IntersectsPoint(_x:int ,_:int):* {
        return null;
    }
}
}
