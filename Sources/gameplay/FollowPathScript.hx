package gameplay;


import found.State;
import found.Scene;
import found.math.Util;
import kha.graphics2.GraphicsExtension;
import found.Timer;
import kha.math.Vector2;
import found.object.Object;

class FollowPathScript extends found.Trait {
    public var points:Array<Object>;
    var currentPoint:Int;
    var lastPoint:Int =-1;
    var finished:Bool;
    var direction:Int = 1;
    var lastTime:Float;
    var round = 0;
    var speed = 200.0;
    // var rate = 1.0/time;
    var initialPos:Vector2;
    var uiScript:GameplayUi;
    public function new(){
        super();
        points = [];
        #if editor
        HealthManager.addToEditor();
        #end
        notifyOnAwake(awake);
        notifyOnUpdate(update);
        notifyOnRender2D(drawInbetweenWaypoints);
    }
    public function addPoint(obj:Object){
        points.push(obj);
    }
    
    public function drawInbetweenWaypoints(g:kha.graphics2.Graphics){
        g.color = kha.Color.fromFloats(1.0,0.0,0.0,0.5);
        for(i in 0...points.length-1){
            if(i != points.length){
                var origin:Vector2 = points[i].position;
                var target:Vector2 = points[i+1].position; 
                for(f in 0...11){
                    var value = f *0.1;
                    var size = 1.0 * Util.randomFloat(1000.0)*Timer.delta;
                    var pos = new Vector2();
                    pos.x = Util.lerp(origin.x,target.x,value);
                    pos.y = Util.lerp(origin.y,target.y,value);
                    g.pushTranslation(pos.x,pos.y);
                    GraphicsExtension.fillCircle(g,0,0,size);
                    g.popTransformation();
                }
            }
        }
        g.color = kha.Color.White;
    }
    function awake() {
        points.splice(0,points.length);
        currentPoint = 0;
        lastTime = 0.0;
        initialPos = this.object.position;
        finished = false;
        uiScript = State.active.cam.getTrait(GameplayUi);
        round = 0;
        uiScript.setRound('Round: $round');
    }
    var offset = 0.01;
    function update(dt:Float){
        if(finished || points.length == 0)return;
        
        if(lastPoint == -1)
            lastPoint = points.length-1;

        var curPos = this.object.position;
        var pos = new Vector2(points[currentPoint].position.x - (this.object.center.x-curPos.x),points[currentPoint].position.y - (this.object.center.y-curPos.y));
        if(offset > Math.abs(pos.x - curPos.x) && offset > Math.abs(pos.y - curPos.y)){
            if(currentPoint == lastPoint)
                finished = true;
            else{
                currentPoint+=direction;
            }
            lastTime = 0.0;
            initialPos = curPos;
        }
        
        this.object.moveTowards(pos,speed*dt);

        if(finished){
            if(direction > 0){
                direction =-1;
                lastPoint = 0;
                speed*= 0.5;
            }
            else {
                direction = 1;
                round++;
                uiScript.setRound('Round: $round');
                lastPoint = points.length-1;
                speed*= 2.0;
            }
            finished = false;
        }
        
    }

    public function followPath(from:Int,to:Int){

    }

}