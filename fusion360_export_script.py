"""
Fusion 360 Python Script
Run this inside Fusion 360 to export models automatically
Install: Tools -> Add-Ins -> Scripts -> Run Script
"""

import adsk.core, adsk.fusion, adsk.cam, traceback

def run(context):
    ui = None
    try:
        app = adsk.core.Application.get()
        ui = app.userInterface
        
        # Get the active design
        product = app.activeProduct
        design = adsk.fusion.Design.cast(product)
        if not design:
            ui.messageBox('No active design', 'Export Error')
            return
        
        # Get the root component
        rootComp = design.rootComponent
        
        # Export settings
        exportMgr = design.exportManager
        
        # Export as FBX
        # Note: Fusion 360 doesn't have native FBX export
        # You'll need to export as STEP or STL, then convert
        
        # Option 1: Export as STEP (recommended for parametric models)
        stepOptions = exportMgr.createSTEPExportOptions(
            r"C:\Users\Tyler\okAPI\assets\workspace_models\fusion360_model.step"
        )
        exportMgr.execute(stepOptions)
        
        # Option 2: Export as STL (for mesh-based models)
        # stlOptions = exportMgr.createSTLExportOptions(
        #     rootComp,
        #     r"C:\Users\Tyler\okAPI\assets\workspace_models\fusion360_model.stl"
        # )
        # stlOptions.meshRefinement = adsk.fusion.MeshRefinementSettings.MeshRefinementMedium
        # exportMgr.execute(stlOptions)
        
        ui.messageBox('Model exported successfully!', 'Export Complete')
        
    except:
        if ui:
            ui.messageBox('Failed:\n{}'.format(traceback.format_exc()))

