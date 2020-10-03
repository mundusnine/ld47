package gameplay;

import found.State;

class WaypointScript extends found.Trait {

    public function new(){
        super();
        notifyOnInit(start);
    }
    function start(){
        var object = State.active.getObject("Player");
        var script = object.getTrait(FollowPathScript);
        if(script != null){
            script.addPoint(this.object);
        }
        else {
            error("Trait didnt exist for some reason");
        }
    }

}