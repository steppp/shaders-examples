import * as THREE from 'three'
import sinWavePlaneVertexShader from './shaders/sin-wave/vertex.glsl'
import sinWavePlaneFragmentShader from './shaders/sin-wave/fragment.glsl'
import geometryPlaygroundVertexShader from './shaders/geometry-playground/vertex.glsl'
import geometryPlaygroundFragmentShader from './shaders/geometry-playground/fragment.glsl'
import volcanoVertexShader from './shaders/volcano/vertex.glsl'
import volcanoFragmentShader from './shaders/volcano/fragment.glsl'

export const Examples = {
    sinWavePlane: (() => {
        // Geometry
        const geometry = new THREE.PlaneGeometry(1, 1, 32, 32)

        // Material
        const material = new THREE.ShaderMaterial({
            vertexShader: sinWavePlaneVertexShader,
            fragmentShader: sinWavePlaneFragmentShader,
            side: THREE.DoubleSide,
            transparent: true,
        })

        // Mesh
        return new THREE.Mesh(geometry, material)
    })(),
    geometryPlayground: (() => {
        // const geometry = new THREE.BoxGeometry(
        //     0.5, 0.5, 0.5,
        //     64, 64, 64)
        const geometry = new THREE.SphereGeometry(
            0.5, 64, 64, 64
        )

        const material = new THREE.ShaderMaterial({
            vertexShader: geometryPlaygroundVertexShader,
            fragmentShader: geometryPlaygroundFragmentShader,
            side: THREE.DoubleSide,
            transparent: true,
        })

        return new THREE.Mesh(geometry, material)
    })(),
    volcano: (() => {
        // Geometry
        const geometry = new THREE.PlaneGeometry(1, 1, 128, 128)

        // Material
        const material = new THREE.ShaderMaterial({
            vertexShader: volcanoVertexShader,
            fragmentShader: volcanoFragmentShader,
            uniforms: {
                uVolcanoCenter: {
                    value: new THREE.Vector2(0.5, 0.5)
                },
                uVolcanoMouthRadius: {
                    value: 0.15
                }
            },
            side: THREE.DoubleSide,
            // wireframe: true
        })

        // Mesh
        const mesh = new THREE.Mesh(geometry, material)
        mesh.rotation.x -= Math.PI / 2
        mesh.position.y -= 0.5

        return mesh;
    })(),
}