@group(1) @binding(0) var<uniform> u_time: f32;
@group(1) @binding(0) var<uniform> u_resolution: vec2<f32>;

@fragment
fn fragment(
#import bevy_pbr::mesh_vertex_output
@builtin(position) fragCoord: vec4<f32>
) -> @location(0) vec4<f32> {
  var st = fragCoord.xy/u_resolution;
	return vec4<f32>(st.x, st.y, 0.0, 1.0);
}
