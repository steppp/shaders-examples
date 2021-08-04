#define FLAT_GOUND_START_DISTANCE 0.3

uniform vec2 uVolcanoCenter;
uniform float uVolcanoMouthRadius;

// pass the uv coordinates to the fragment shader
// 0, 0 on the bottom left corner, 1, 1 on the top-right one
varying vec2 vUv;

varying vec2 vVolcanoCenter;
varying float vVolcanoMouthRadius;

// > 0: outside the circle
// < 0: inside the circle
float circleSdf(float radius, vec2 center, vec2 point)
{
    return distance(center, point) - radius;
}

float computeHeight(float value)
{
    return 2.0 * (1.0 - 1.12 * pow(value, 0.1));
}

void main()
{
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // create the volcano slope by adjusting the height of the vertex
    // based on the distance from the mouth
    float distanceFromMouth = circleSdf(uVolcanoMouthRadius, uVolcanoCenter, uv);
    // multiply the result of pow by a value > 1 to make the resulting value reach 1
    // before the uv coordinate is at the limit of the texture
    float height = 2.0 * (1.0 - 1.12 * pow(distanceFromMouth, 0.1));

    // set the height of the vertex based on the distance from the mouth
    modelPosition.y += clamp(height, 0.0, 1.0);
    modelPosition.y += .3;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    // using a ShaderMaterial we already have access to the uv property
    vUv = uv;

    vVolcanoCenter = uVolcanoCenter;
    vVolcanoMouthRadius = uVolcanoMouthRadius;
}