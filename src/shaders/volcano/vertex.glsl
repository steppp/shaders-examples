// TODO: provide a value for these from the js code
uniform vec2 uVolcanoCenter;
uniform float uVolcanoMouthRadius;

// pass the uv coordinates to the fragment shader
// 0, 0 on the bottom left corner, 1, 1 on the top-right one
varying vec2 vUv;

varying vec2 vVolcanoCenter;
varying float vVolcanoMouthRadius;

void main()
{
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

    // using a ShaderMaterial we already have access to the uv property
    vUv = uv;

    vVolcanoCenter = uVolcanoCenter;
    vVolcanoMouthRadius = uVolcanoMouthRadius;
}