shader_type spatial;
// Désactive les calculs de lumière physique pour économiser des ressources
render_mode unshaded;

// Paramètres exposés aux artistes dans l'inspecteur Godot
uniform vec4 silhouette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform sampler2D alpha_mask : hint_default_white;

void fragment() {
    // Récupère la transparence depuis la texture fournie par l'artiste
    vec4 mask = texture(alpha_mask, UV);
    
    // Applique la couleur unie
    ALBEDO = silhouette_color.rgb;
    // Conserve la découpe du sprite ou du modèle
    ALPHA = mask.a * silhouette_color.a; 
}
