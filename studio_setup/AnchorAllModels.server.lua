-- Auto-Anchor All Models
-- Place this script in ServerScriptService
-- Automatically anchors all parts in all models when they're added to Workspace
-- Also sets other important properties for models

local function setModelProperties(part)
    -- Anchor all parts (prevents falling)
    if part:IsA("BasePart") then
        part.Anchored = true
        
        -- Set other useful properties
        part.CanCollide = true  -- Models should collide with players
        
        -- Set material based on name (optional)
        if part.Name:find("Ground") or part.Name:find("Platform") then
            part.Material = Enum.Material.Grass
        elseif part.Name:find("Roof") then
            part.Material = Enum.Material.Metal
        elseif part.Name:find("Base") or part.Name:find("Wall") then
            part.Material = Enum.Material.Concrete
        end
    end
end

local function anchorModel(model)
    local anchoredCount = 0
    
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            setModelProperties(descendant)
            anchoredCount = anchoredCount + 1
        end
    end
    
    return anchoredCount
end

-- Anchor existing models on startup
wait(1)  -- Wait for models to load

local function anchorEverything(parent)
    local totalAnchored = 0
    
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("Model") then
            local count = anchorModel(child)
            totalAnchored = totalAnchored + count
            print("✓ Anchored model: " .. child.Name .. " (" .. count .. " parts)")
        elseif child:IsA("BasePart") then
            setModelProperties(child)
            totalAnchored = totalAnchored + 1
        end
    end
    
    return totalAnchored
end

print("=" .. string.rep("=", 50))
print("Auto-Anchoring Models...")
print("=" .. string.rep("=", 50))

local totalAnchored = anchorEverything(workspace)

print("=" .. string.rep("=", 50))
print("✓ Anchored " .. totalAnchored .. " parts!")
print("=" .. string.rep("=", 50))

-- Also anchor new models when they're added
workspace.ChildAdded:Connect(function(child)
    wait(0.1)  -- Small delay for model to fully load
    if child:IsA("Model") then
        local count = anchorModel(child)
        if count > 0 then
            print("✓ Auto-anchored new model: " .. child.Name .. " (" .. count .. " parts)")
        end
    elseif child:IsA("BasePart") then
        setModelProperties(child)
        print("✓ Auto-anchored part: " .. child.Name)
    end
end)

print("")
print("✓ Auto-anchor active! New models will be anchored automatically.")

