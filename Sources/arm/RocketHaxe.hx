package arm;
import iron.system.Input;
import armory.trait.physics.RigidBody;
import iron.math.Vec4;

class RocketHaxe extends iron.Trait {
	public function wallD(abs) {
		//function to detect walls behind the rocket
		var physics = armory.trait.physics.PhysicsWorld.active;
		var rb = physics.rayCast(object.transform.world.getLoc(), abs.transform.world.getLoc());
		if(rb != null){
			var hit:Vec4 = physics.hitPointWorld;
			var dis:Float = Math.pow(Math.pow((object.transform.worldx() -hit.x),2.0)+Math.pow((object.transform.worldy() -hit.y),2.0),0.5);
			return dis;
		}
		else{
			return 100.0;
		}
	}
	public function new() {
		var Lavel:Vec4 = new Vec4();
		super();
		notifyOnUpdate(function() {
			//set variable
			var key = Input.getKeyboard();
			var mo = Input.getMouse();
			var width = kha.System.windowWidth();
			var height = kha.System.windowHeight();
			var cam = iron.Scene.active.getCamera("Camera");
			var light:iron.object.LightObject = cast object.getChildOfType(iron.object.LightObject);
			var emp:iron.object.Object =  iron.Scene.active.getEmpty("to ray");
			//mouse pos to rotation
			var rot = Math.atan2(-mo.y+height-(height/2),mo.x-(width/2));
			// set rotation
			object.transform.rot.fromEuler(1.5708,0.0,rot);
			object.transform.buildMatrix();
			var rigidBody = object.getTrait(RigidBody);
			if (rigidBody != null) rigidBody.syncTransform();

			//cam follow
			cam.transform.loc.y = object.transform.loc.y;
			cam.transform.loc.x = object.transform.loc.x;

			//stuff that i need to do shit
			var ma = object.transform;
			var time:Float = 0.2;
			var prop = new Vec4();
			var force:Float = 4.0;
			var speed:Float = 1.0;
			//on Ground effect thingny
			if(wallD(emp)<= 2.0){
				speed = ((wallD(emp)-2.0)*-1.2)+1.0;
			}
			else{
				speed = 1.0;
			}
			//multiply view axi by force and speed
			//trace(speed);
			prop.x = ma.up().x * force * speed;
			prop.y = ma.up().y * force * speed;
			prop.z = 0.0;

			//apply force stuff, light and time shit
			light.data.raw.strength = 0.0;
			if(mo.down("left")){
				light.data.raw.strength = 300.0*0.026;
				rigidBody.applyForce(prop);
				time = 1.0;
			}
			if(key.down("r")){
				time = 0.0;
			}
			iron.system.Time.scale = time;
			// get velocity as Lvel
			var Lvel:Vec4 = new Vec4();
			Lvel.x = rigidBody.getLinearVelocity().x ;
			Lvel.y = rigidBody.getLinearVelocity().y ;
			var per:Vec4 = new Vec4();
			if(Lavel != Lvel){
				per.x = (Lvel.x/(Lavel.x)*100.0);
				per.y = (Lvel.y/(Lavel.y)*100.0);
			}
			//check if hits wall hard enough to kill ya
			if(rigidBody.physics.getContactPairs(rigidBody) != null){
				if((Math.abs(per.y) < 45.0) || (Math.abs(per.x) < 45.0)){
					if((Math.abs(Lavel.y) > 2.0) || (Math.abs(Lavel.x) > 2.0)){
						trace("dead");
						light.data.raw.strength = 0;
						object.removeTrait(object.getTrait(RocketHaxe));
					}
				}
			}
			Lavel.x = Lvel.x;
			Lavel.y = Lvel.y;
		});
	}
}