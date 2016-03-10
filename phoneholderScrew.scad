TOTAL_HEIGHT = 127;

module screwHolder(){
    translate([0,0,2]){
        difference(){
            roundedBox([50,60,4],2);
            screw([20,23,0]);
            screw([-20,23,0]);
            screw([20,-23,0]);
            screw([-20,-23,0]);
        }
    }
}

module screw(translateDimensions) {
    translate(translateDimensions)
        cylinder(h = 5, r1 = 2, r2 = 2, center = true);
}

module phoneHolderWithScrewHolder() {
    phoneHolder(TOTAL_HEIGHT);
    screwHolder();
}

module phoneHolder(phoneHeight) {
	difference() { 
		union() {	
            translate([0,0,6]){
                roundedBox([25,phoneHeight+10,12],3);
            }
            translate([0,(phoneHeight/2),30]){//65
                roundedBox([20,10,60],3);
            }
            translate([0,-(phoneHeight/2),30]){
                roundedBox([25,10,60],3);
            }
            translate([0,-(phoneHeight/2)+5,10]){
                roundedBox([30,20,20],3);
            }
            translate([0,(phoneHeight/2)-5,10]){
                roundedBox([30,20,20],3);
            }    
        }
        
        translate([0,0,8]){
            phone(phoneHeight);
        }
	}
}

module phone(phoneHeight){
    rotate([180,0,0]) {
        translate([0,0,-67]) {
            translate([0,0,34]) 
                rotate([90,0,0])
                    cube([10,67,phoneHeight], center=true);
            translate([-2,45,30]){
                roundedBox([10,15,20],3);
            }
            translate([0,55,44]){
                cube([8,54,38], center=true);
            }
        }
    }
}

module roundedBox(size, radius)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];

    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
        for (x = [radius-size[axis]/2, -radius+size[axis]/2],
                y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
            rotate(rot[axis]) 
                translate([x,y,0]) 
                cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
        }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
            y = [radius-size[1]/2, -radius+size[1]/2],
            z = [radius-size[2]/2, -radius+size[2]/2]) {
        translate([x,y,z]) sphere(radius);
    }
}

phoneHolderWithScrewHolder();
