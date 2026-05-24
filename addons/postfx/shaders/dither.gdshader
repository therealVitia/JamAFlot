shader_type canvas_item;

uniform sampler2D texture_screen : hint_screen_texture, filter_nearest;

// Le nombre de couleurs disponibles par canal. 
// Une valeur basse (ex: 4.0) donne un aspect très rétro.
uniform float color_depth : hint_range(1.0, 32.0, 0.01) = 4.0;

// L'intensité de la dispersion des pixels. 
// Définit le contraste à partir duquel le motif de damier se forme.
uniform float dither_spread : hint_range(0.0, 1.0, 0.001) = 0.25;

// La taille du motif de tramage. 
// Utile pour rendre le tramage visible sur des écrans haute résolution.
uniform float dither_scale : hint_range(1.0, 10.0, 0.01) = 1.0;

// Transition entre un tramage en couleurs originales (0.0) et en niveaux de gris (1.0).
uniform float grayscale_mix : hint_range(0.0, 1.0, 0.01) = 1.0;

void fragment() {
    vec4 base_color = texture(texture_screen, SCREEN_UV);
    
    // Calcul de la luminance physique pour le niveau de gris
    float luminance = dot(base_color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 bw_color = vec3(luminance);
    
    // Application de la bascule Couleur / Noir et blanc
    vec3 target_color = mix(base_color.rgb, bw_color, grayscale_mix);

    // Adaptation des coordonnées d'écran à l'échelle choisie
    float scaled_x = floor(FRAGCOORD.x / dither_scale);
    float scaled_y = floor(FRAGCOORD.y / dither_scale);

    // Calcul de la matrice de damier (Bayer 2x2)
    float a = floor(mod(scaled_x, 2.0));
    float b = floor(mod(scaled_y, 2.0));    
    float c = mod(a + b, 2.0);
    
    vec3 dithered_color;
    
    // Application du tramage (passe positive)
    dithered_color.r = (round(target_color.r * color_depth + dither_spread) / color_depth) * c;
    dithered_color.g = (round(target_color.g * color_depth + dither_spread) / color_depth) * c;
    dithered_color.b = (round(target_color.b * color_depth + dither_spread) / color_depth) * c;
    
    // Inversion de la matrice
    c = 1.0 - c;
    
    // Application du tramage (passe négative)
    dithered_color.r += (round(target_color.r * color_depth - dither_spread) / color_depth) * c;
    dithered_color.g += (round(target_color.g * color_depth - dither_spread) / color_depth) * c;
    dithered_color.b += (round(target_color.b * color_depth - dither_spread) / color_depth) * c;
    
    COLOR.rgb = dithered_color;
}