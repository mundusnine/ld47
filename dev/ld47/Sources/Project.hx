package;

import kha.Canvas;
import found.App;
import found.State;

class Project extends App {
	 public function new(){
		super(function(){
			State.addState("play","./ld47/Assets/PlayState.json");
			State.set("play");
		});
	}
	 override function render(canvas:Canvas){
		super.render(canvas);
	}
}