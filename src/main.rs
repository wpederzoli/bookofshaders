use bevy::{
    prelude::*,
    reflect::TypeUuid,
    render::render_resource::AsBindGroup,
    sprite::{Material2d, Material2dPlugin, MaterialMesh2dBundle},
};

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_plugin(Material2dPlugin::<CustomMaterial>::default())
        .add_startup_system(setup)
        .add_system(update)
        .run();
}

#[derive(Clone, AsBindGroup, TypeUuid, Debug)]
#[uuid = "4dd116c3-9d16-4215-8fbb-b85901f5cab7"]
struct CustomMaterial {
    #[uniform(0)]
    time: f32,
    #[uniform(0)]
    resolution: Vec2,
}

impl Material2d for CustomMaterial {
    fn fragment_shader() -> bevy::render::render_resource::ShaderRef {
        "shaders/shader.wgsl".into()
    }
}

fn setup(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<CustomMaterial>>,
    time: Res<Time>,
    windows: Res<Windows>,
) {
    let window = windows.get_primary().unwrap();
    spawn_camera(&mut commands);
    commands.spawn(MaterialMesh2dBundle {
        mesh: meshes.add(Mesh::from(shape::Quad::default())).into(),
        material: materials.add(CustomMaterial {
            time: time.elapsed_seconds(),
            resolution: Vec2::new(window.width(), window.height()),
        }),
        transform: Transform {
            scale: Vec3::new(window.width(), window.height(), 1.),
            ..default()
        },
        ..default()
    });
}

fn spawn_camera(commands: &mut Commands) {
    commands.spawn(Camera2dBundle::default());
}

fn update(time: Res<Time>, mut materials: ResMut<Assets<CustomMaterial>>) {
    for material in materials.iter_mut() {
        material.1.time = time.elapsed_seconds();
    }
}
