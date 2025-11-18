"""
Helper script to export models from Blender using MCP
This can be called from the main workflow script
"""

import bpy
import os
from pathlib import Path

def export_objects_by_prefix(prefix, output_path, file_format='FBX'):
    """
    Export all objects starting with a given prefix from Blender
    
    Args:
        prefix: Object name prefix (e.g., 'BJ_')
        output_path: Full path to output file
        file_format: Export format ('FBX', 'OBJ', 'GLTF', etc.)
    """
    # Deselect all
    bpy.ops.object.select_all(action='DESELECT')
    
    # Find all objects with the prefix
    objects_to_export = [obj for obj in bpy.context.scene.objects 
                        if obj.name.startswith(prefix)]
    
    if not objects_to_export:
        print(f"No objects found with prefix '{prefix}'")
        return False
    
    # Select all matching objects
    for obj in objects_to_export:
        obj.select_set(True)
    
    # Set one as active
    bpy.context.view_layer.objects.active = objects_to_export[0]
    
    print(f"Selected {len(objects_to_export)} objects:")
    for obj in objects_to_export:
        print(f"  - {obj.name}")
    
    # Ensure output directory exists
    output_dir = os.path.dirname(output_path)
    os.makedirs(output_dir, exist_ok=True)
    
    # Export based on format
    if file_format.upper() == 'FBX':
        bpy.ops.export_scene.fbx(
            filepath=output_path,
            use_selection=True,
            apply_scale_options='FBX_SCALE_ALL',
            bake_space_transform=True,
            mesh_smooth_type='FACE'
        )
    elif file_format.upper() == 'OBJ':
        bpy.ops.export_scene.obj(
            filepath=output_path,
            use_selection=True
        )
    elif file_format.upper() == 'GLTF':
        bpy.ops.export_scene.gltf(
            filepath=output_path,
            use_selection=True
        )
    else:
        print(f"Unsupported format: {file_format}")
        return False
    
    print(f"✓ Exported to: {output_path}")
    return True

# Example usage (can be called from command line)
if __name__ == "__main__":
    import sys
    
    prefix = sys.argv[1] if len(sys.argv) > 1 else "BJ_"
    output_path = sys.argv[2] if len(sys.argv) > 2 else r"C:\Users\Tyler\okAPI\assets\models\exported_model.fbx"
    file_format = sys.argv[3] if len(sys.argv) > 3 else "FBX"
    
    export_objects_by_prefix(prefix, output_path, file_format)

