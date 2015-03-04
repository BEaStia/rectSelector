/**
 * Created by Igor on 04.03.2015.
 */
package ru.sq {
import flash.events.Event;
import flash.events.MouseEvent;

public interface IField {

    /**
     * Callback on double mouse button click
     * @param event
     */
    function onDoubleClick(event:MouseEvent):void;

    /**
     * Callback on each frame
     * @param event
     */
    function onEnterFrame(event:Event):void;

    /**
     * Redraw lines and objects
     * @param event
     */
    function Redraw(event:MouseEvent):void;

    /**
     * Refresh background
     * @param event
     */
    function RedrawBackGround(event:MouseEvent):void;
    /**
     * Callback on added to stage
     * @param event
     */
    function onAddedToStage(event:Event):void;

    /**
     * Callback on mouse down
     * @param event
     */
    function onMouseDown(event:MouseEvent):void;

    /**
     * Check if this object intersects with others
     * @param rect - object
     * @return
     */
    function InterSectsAnyRectangle(rect:*):Boolean;

    /**
     * Callback on mouse button up
     * @param event
     */
    function onMouseUp(event:MouseEvent):void ;

    /**
     * Callback on moving mouse
     * @param event
     */
    function onMouseMove(event:MouseEvent):void ;

    /**
     * Get rectangle containing or intersecting current point
     * @param _x
     * @param _y
     * @return
     */
    function IntersectsPoint(_x:int ,_y:int):*;
}
}
