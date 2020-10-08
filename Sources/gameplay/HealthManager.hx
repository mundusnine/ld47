package gameplay;

import found.node.Logic.TNode;
import found.node.LogicTree;
import found.node.LogicNode;

#if editor
import found.tool.NodeEditor;
#end

class HealthManager extends LogicNode {

    public function new(tree:LogicTree) {
        super(tree);
        tree.notifyOnInit(init);
    }
    #if editor
    public static function addToEditor(){
        var node:TNode = {
            id: 0,
            name: "Get Hurt",
            type: "HealthManager",
            x: 200,
            y: 200,
            inputs: [
                {
                    id: 0,
                    node_id: 0,
                    name: "In",
                    type: "ACTION",
                    color: 0xffaa4444,
                    default_value: ""
                },
                {
                    id: 0,
                    node_id: 0,
                    name: "Hit amount",
                    type: "VALUE",
                    color: -4934476,
                    max: 10.0,
                    min: 0.0,
                    default_value: 0.0
                },
                {
                    id: 0,
                    node_id: 0,
                    name: "Max Life",
                    type: "VALUE",
                    color: -4934476,
                    max: 100.0,
                    min: 0.0,
                    default_value: 100.0
                }
            ],
            outputs: [
                {
                    id: 0,
                    node_id: 0,
                    name: "On Death",
                    type: "ACTION",
                    color: 0xffaa4444,
                    default_value: ""
                }
            ],
            buttons: [],
            color: -4962746
        };
        NodeEditor.addCustomNode("LifeManagers",node);
    }
    #end
    var health:Float;
    function init(){
        health = inputs[2].get();
    }
    public var isDead(get,never):Bool;
    function get_isDead(){
        return health > 0;
    }
    override function run(from:Int) {
        super.run(from);
        hit(inputs[1].get());
    }
    public function hit(amount:Float) {
        if(health > 0){
            health -= amount;
            if(health <= 0){
                runOutput(0);
            }
        }
        
    }
}