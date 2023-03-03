@group(1) @binding(0) var<uniform> u_time: f32;

@fragment
fn fragment(
#import bevy_pbr::mesh_vertex_output
) -> @location(0) vec4<f32> {
  return vec4<f32>(abs(sin(u_time)),0.0,0.0,1.0);
}
