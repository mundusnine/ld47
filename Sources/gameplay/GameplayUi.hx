package gameplay;

import zui.Canvas.TElement;
import found.trait.internal.CanvasScript;

class GameplayUi extends CanvasScript {
    var roundElement:TElement;
    public function new() {
        super("gameplayUI","font_default.ttf",kha.Assets.blobs.get("gameplayUI_json"));
        notifyOnReady(function(){
           roundElement = getElement("Round"); 
        });
    }
    public function setRound(round:String){
        roundElement.text = round;
    }
}