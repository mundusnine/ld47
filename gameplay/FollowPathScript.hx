package gameplay;


import kha.math.Vector2;
import found.object.Object;

class FollowPathScript extends found.Trait {
    public var points:Array<Object>;
    var currentPoint:Int;
    var lastPoint:Int;
    var finished:Bool;
    var direction:Int = 1;
    var lastTime:Float;
    static var speed = 0.2;
    // var rate = 1.0/time;
    var initialPos:Vector2;
    public function new(){
        super();
        notifyOnAwake(awake);
        notifyOnUpdate(update);
    }
    public function addPoint(obj:Object){
        points.push(obj);
    }
    function awake() {
        points = [];
        currentPoint = 0;
        lastTime = 0.0;
        initialPos = this.object.position;
        finished = false;
    }
    var offset = 0.01;
    function update(dt:Float){
        if(finished || points.length == 0)return;

        lastPoint = points.length;

        var pos = points[currentPoint].position;
        var curPos = this.object.position;
        if(offset > Math.abs(pos.x - curPos.x) && offset > Math.abs(pos.y - curPos.y)){
            currentPoint+=direction;
            if(currentPoint == lastPoint)
                finished = true;
            lastTime = 0.0;
            initialPos = curPos;
        }
        this.object.moveTowards(pos,200.0*dt);
        
    }

    public function followPath(from:Int,to:Int){

    }

}