@group(1) @binding(0) var<uniform> u_time: f32;
@group(1) @binding(1) var<uniform> u_resolution: vec2<f32>;

@fragment
fn fragment(
#import bevy_pbr::mesh_vertex_output
@builtin(position) fragCoord : vec4<f32>
) -> @location(0) vec4<f32> {
  let uv = fragCoord.xy / u_resolution;
  let left_half = 1.0 - step(0.5, length(uv.xy));
  let left_right = step(uv.x, 0.6) * step(0.4, uv.x);
  let top_down = step(uv.y, 0.6) * step(0.4, uv.y);
  let rectangle = left_right * top_down;

  let color = vec3<f32>(1.0, 1.0, 0.0) * rectangle; 

	return vec4(color, 1.0);
}
