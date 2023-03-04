@group(1) @binding(0) var<uniform> u_time: f32;
@group(1) @binding(1) var<uniform> u_resolution: vec2<f32>;

fn plot(st: vec2<f32>) -> f32 {    
    return smoothstep(0.02, 0.0, abs(st.y - st.x));
}

@fragment
fn fragment(
#import bevy_pbr::mesh_vertex_output
@builtin(position) fragCoord: vec4<f32>
) -> @location(0) vec4<f32> {
	var st = fragCoord.xy/u_resolution;
    var y = st.x;
    var color = vec3(y);
    // Plot a line
    var pct = plot(st);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

	return vec4(color,1.0);
}
