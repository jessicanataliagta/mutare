-- === GTA PED Bone Hierarchy Data Helper (Multi-Game Support) ===
fn getGTATagData boneName =
(
    if gtaSATagData != undefined then
        for entry in gtaSATagData where entry[1] == boneName do return entry
    if gtaVCTagData != undefined then
        for entry in gtaVCTagData where entry[1] == boneName do return entry
    undefined
)

-- === Global Variables for PED Data (Multi-Game Support) ===
global gtaSABoneHierarchy = #()
global gtaSABonePositionsDict = #()
global gtaSABoneRotationsDict = #()
global gtaSABoneNames = #()
global gtaSABonePositions = #()
global gtaSABoneRotations = #()
global gtaSATagData = #()

-- Additional globals for Vice City (or other games)
global gtaVCBoneHierarchy = #()
global gtaVCBonePositionsDict = #()
global gtaVCBoneRotationsDict = #()
global gtaVCBoneNames = #()
global gtaVCBonePositions = #()
global gtaVCBoneRotations = #()
global gtaVCTagData = #()

-- Active data set globals (points to currently loaded data)
global activeBoneHierarchy = #()
global activeBonePositionsDict = #()
global activeBoneRotationsDict = #()
global activeBoneNames = #()
global activeBonePositions = #()
global activeBoneRotations = #()
global activeTagData = #()
global activeGameTitle = ""

-- === Manual External Data Loading Function ===
fn loadExternalPEDdata =
(
    local dataFilePath = getOpenFileName caption:"Load External PED Data Script" types:"MAXScript Files (*.ms)|*.ms|All Files (*.*)|*.*"
    if dataFilePath != undefined then (
        try (
            -- CLEAR ALL PREVIOUS DATA BEFORE LOADING NEW FILE
            format "Clearing previous data...\n"
            
            -- Clear GTA:SA globals
            gtaSABoneHierarchy = #()
            gtaSABonePositionsDict = #()
            gtaSABoneRotationsDict = #()
            gtaSABoneNames = #()
            gtaSABonePositions = #()
            gtaSABoneRotations = #()
            gtaSATagData = #()
            
            -- Clear GTA:VC globals
            gtaVCBoneHierarchy = #()
            gtaVCBonePositionsDict = #()
            gtaVCBoneRotationsDict = #()
            gtaVCBoneNames = #()
            gtaVCBonePositions = #()
            gtaVCBoneRotations = #()
            gtaVCTagData = #()
            
            -- Clear active data globals
            activeBoneHierarchy = #()
            activeBonePositionsDict = #()
            activeBoneRotationsDict = #()
            activeBoneNames = #()
            activeBonePositions = #()
            activeBoneRotations = #()
            activeTagData = #()
            activeGameTitle = ""
            
            -- Force garbage collection to free memory
            gc()
            
            -- Load the new file
            format "Loading new data from: %\n" (filenameFromPath dataFilePath)
            fileIn dataFilePath
            
            local dataLoaded = false
            local gameTitle = ""
            
            -- Check if GTA:SA data was loaded
            if (gtaSABoneNames != undefined and gtaSABonePositions != undefined and
                gtaSABoneHierarchy != undefined and gtaSABoneRotations != undefined and
                gtaSABoneNames.count > 0 and gtaSABoneHierarchy.count > 0) then (
                
                -- Set active data to GTA:SA
                activeBoneHierarchy = gtaSABoneHierarchy
                activeBoneNames = gtaSABoneNames
                activeBonePositions = gtaSABonePositions
                activeBoneRotations = gtaSABoneRotations
                activeTagData = gtaSATagData
                activeGameTitle = "GTA:SA"
                
                -- Populate dictionaries for fast lookup
                activeBonePositionsDict = Dictionary name:#activeBonePositionsDict
                for bonePos in activeBonePositions do (
                    activeBonePositionsDict[(bonePos[1] as name)] = bonePos[2]
                )
                activeBoneRotationsDict = Dictionary name:#activeBoneRotationsDict
                for boneRot in activeBoneRotations do (
                    activeBoneRotationsDict[(boneRot[1] as name)] = boneRot[2]
                )
                
                dataLoaded = true
                gameTitle = "GTA:SA"
                format "GTA:SA data detected: % bones\n" gtaSABoneNames.count
            )
            
            -- Check if GTA:VC data was loaded
            else if (gtaVCBoneNames != undefined and gtaVCBonePositions != undefined and
                     gtaVCBoneHierarchy != undefined and gtaVCBoneRotations != undefined and
                     gtaVCBoneNames.count > 0 and gtaVCBoneHierarchy.count > 0) then (
                
                -- Set active data to GTA:VC
                activeBoneHierarchy = gtaVCBoneHierarchy
                activeBoneNames = gtaVCBoneNames
                activeBonePositions = gtaVCBonePositions
                activeBoneRotations = gtaVCBoneRotations
                activeTagData = gtaVCTagData
                activeGameTitle = "GTA:VC"
                
                -- Populate dictionaries for fast lookup
                activeBonePositionsDict = Dictionary name:#activeBonePositionsDict
                for bonePos in activeBonePositions do (
                    activeBonePositionsDict[(bonePos[1] as name)] = bonePos[2]
                )
                activeBoneRotationsDict = Dictionary name:#activeBoneRotationsDict
                for boneRot in activeBoneRotations do (
                    activeBoneRotationsDict[(boneRot[1] as name)] = boneRot[2]
                )
                
                dataLoaded = true
                gameTitle = "GTA:VC"
                format "GTA:VC data detected: % bones\n" gtaVCBoneNames.count
            )
            
            if dataLoaded then (
                format "% PED data loaded successfully from: %\n" gameTitle (filenameFromPath dataFilePath)
                messageBox ("Successfully loaded " + gameTitle + " PED data!\n\nBones: " + activeBoneNames.count as string + "\nFile: " + filenameFromPath dataFilePath) title:"Data Loaded"
                return true
            ) else (
                messageBox "Failed to load PED data. The file doesn't contain expected bone data structure." title:"Load Error"
                format "Data loading failed - no recognized bone data structure found.\n"
                return false
            )
        ) catch (
            local theError = getCurrentException()
            messageBox ("Error loading external data file:\n" + theError as string) title:"Load Error"
            format "Error loading file: %\n" theError
            return false
        )
    ) else (
        return false
    )
)

-- === Helper Functions (using active data) ===
fn getActiveBonePos boneName =
(
    local boneNameAsName = boneName as name
    if activeBonePositionsDict != undefined and activeBonePositionsDict[boneNameAsName] != undefined then
        return activeBonePositionsDict[boneNameAsName]
    [0,0,0] -- Default position if not found
)

fn getActiveBoneRot boneName =
(
    local boneNameAsName = boneName as name
    if activeBoneRotationsDict != undefined and activeBoneRotationsDict[boneNameAsName] != undefined then
        return activeBoneRotationsDict[boneNameAsName]
    quat 0 0 0 1 -- Default rotation if not found
)

fn isValidBoneNode node =
(
    node != undefined and (
        (superClassOf node == GeometryClass and classOf node == BoneObj) or
        (isKindOf node Dummy and node.boneEnable)
    )
)

-- === Create Dummies in Hierarchy Order (Multi-Game Support) ===
fn createActiveDummySkeleton =
(
    if activeBoneHierarchy == undefined or activeBoneHierarchy.count == 0 then (
        messageBox "No PED data loaded. Please load external data first." title:"No Data"
        return false
    )
    
    -- Delete old dummies from active data set
    for boneData in activeBoneHierarchy do (
        local name = boneData[1]
        for obj in objects where (classof obj == Dummy and obj.name == name) do delete obj
    )

    local dummyArray = #()
    local rootDummy = undefined
    for boneData in activeBoneHierarchy do (
        local boneName = boneData[1]
        local d = Dummy name:boneName
        d.boxsize = [0.05,0.05,0.05]
        d.boneEnable = true

        local tagInfo = getGTATagData boneName
        if tagInfo != undefined then (
            local tagVal = tagInfo[2]
            local childNumVal = tagInfo[3]
            local fakeBipedVal = tagInfo[4]
            local buffer = ""
            if tagVal != undefined do buffer += "tag = " + tagVal as string
            if childNumVal != undefined do (
                if buffer != "" then buffer += "\r\n"
                buffer += "childNum = " + childNumVal as string
            )
            if fakeBipedVal != undefined do (
                if buffer != "" then buffer += "\r\n"
                buffer += "fakeBiped = " + fakeBipedVal as string
            )
            if buffer != "" do setUserPropBuffer d buffer
        )

        local posArray = getActiveBonePos boneName
        local rot = getActiveBoneRot boneName
        if rot == undefined do rot = quat 0 0 0 1
        local pos = point3 posArray[1] posArray[2] posArray[3]
        local tm = (rot as matrix3)
        tm.row4 = pos
        d.transform = tm

        append dummyArray #(boneName, d)
        if boneName == "Root" then rootDummy = d
    )

    -- Set parent relationships
    for boneData in activeBoneHierarchy do (
        local boneName = boneData[1]
        local parentNames = boneData[2]
        local childDummy = undefined
        local parentDummy = undefined
        for item in dummyArray do (
            if item[1] == boneName then childDummy = item[2]
            if parentNames.count > 0 and item[1] == parentNames[1] then parentDummy = item[2]
        )
        if childDummy != undefined and parentDummy != undefined do (
            childDummy.parent = parentDummy
        )
    )
    deselect objects
    return true
)

-- === Adaptive Bone Creation with Tag Preservation (Multi-Game Support) ===
fn createActiveSkeleton_Adaptive =
(
    if activeBoneHierarchy == undefined or activeBoneHierarchy.count == 0 then (
        messageBox "No PED data loaded. Please load external data first." title:"No Data"
        return false
    )
    
    local selectedDummies = for o in selection where (isKindOf o Dummy and o.boneEnable) collect o
    if selectedDummies.count == 0 then (
        messageBox "Select the dummies to convert to bones." title:"Error"
        return false
    )

    local selectedNames = for d in selectedDummies collect d.name
    local boneArray = #()
    local rootBone = undefined

    for boneData in activeBoneHierarchy do (
        local boneName = boneData[1]
        if findItem selectedNames boneName > 0 then (
            local bone = BoneSys.createBone [0,0,0] [0,0,0.1] [0,0,1]
            bone.name = boneName
            bone.width = 0.05
            bone.height = 0.05
            bone.wirecolor = color 255 200 100
            if boneName == "Root" then rootBone = bone
            append boneArray #(boneName, bone)

            local tagInfo = getGTATagData boneName
            if tagInfo != undefined then (
                local tagVal = tagInfo[2]
                local childNumVal = tagInfo[3]
                local fakeBipedVal = tagInfo[4]
                local buffer = ""
                if tagVal != undefined do buffer += "tag = " + tagVal as string
                if childNumVal != undefined do (
                    if buffer != "" then buffer += "\r\n"
                    buffer += "childNum = " + childNumVal as string
                )
                if fakeBipedVal != undefined do (
                    if buffer != "" then buffer += "\r\n"
                    buffer += "fakeBiped = " + fakeBipedVal as string
                )
                if buffer != "" do setUserPropBuffer bone buffer
            )

            local dummy = undefined
            for d in selectedDummies where d.name == boneName do dummy = d
            if dummy != undefined do (
                bone.transform = dummy.transform
            )
        )
    )

    -- Parent bones
    for boneData in activeBoneHierarchy do (
        local boneName = boneData[1]
        local parentNames = boneData[2]
        if findItem selectedNames boneName > 0 then (
            local bone = undefined
            local parentBone = undefined
            for item in boneArray do (
                if item[1] == boneName then bone = item[2]
                if parentNames.count > 0 and item[1] == parentNames[1] then parentBone = item[2]
            )
            if bone != undefined and parentBone != undefined do (
                bone.parent = parentBone
            )
        )
    )

    -- Set bone length and direction
    for boneData in boneArray do (
        local boneName = boneData[1]
        local bone = boneData[2]
        if bone.children.count > 0 then (
            local childBone = undefined
            for c in bone.children where isValidBoneNode c do (
                childBone = c
                exit
            )
            if childBone != undefined then (
                local bonePos = bone.position
                local childPos = childBone.position
                if (distance bonePos childPos) > 0.0001 then (
                    bone.length = distance bonePos childPos
                )
            )
        )
    )

    -- For end bones, set length and direction
    for boneData in boneArray do (
        local boneName = boneData[1]
        local bone = boneData[2]
        -- Check if this is an end bone and has a parent
        if bone.children.count == 0 and bone.parent != undefined and isValidBoneNode bone.parent then (
            local parentBone = bone.parent
            local parentPos = parentBone.position
            local bonePos = bone.position
            bone.length = 0.1 * (distance bonePos parentPos)
        )
    )

    -- Reset scaling
    local allBones = for item in boneArray collect item[2]
    for bone in allBones do (
        try (
            bone.scale = [1,1,1]
        ) catch (
            print ("Warning: Could not reset scaling for bone: " + bone.name)
        )
    )

    select (for item in boneArray collect item[2])
    -- Remove used dummies
    for d in selectedDummies do try(delete d) catch()
    messageBox (activeGameTitle + " bones created with corrected rotations (dummies auto-deleted)!") title:"Success"
    return true
)

-- === Recursive Bone Collector (Multi-Game Support) ===
fn collectChildBones parentBoneName &boneList =
(
    if activeBoneHierarchy == undefined then return()
    appendIfUnique boneList parentBoneName
    for boneData in activeBoneHierarchy where boneData[2].count > 0 and boneData[2][1] == parentBoneName do
        collectChildBones boneData[1] &boneList
)

fn skinHasBoneByNode skinMod boneNode =
(
    local numBones = skinOps.GetNumberBones skinMod
    for i = 1 to numBones do (
        if skinOps.GetBoneNode skinMod i == boneNode then return true
    )
    false
)

fn skinSelectedMeshAddBonesAndVoxelWeights =
(
    if activeBoneNames == undefined or activeBoneNames.count == 0 then (
        messageBox "No PED data loaded. Please load external data first." title:"No Data"
        return false
    )
    
    if selection.count != 1 then (
        messageBox "Select a single mesh (Editable_Mesh or Editable_Poly) to skin." title:"Error"
        return false
    )
    local obj = selection[1]

    -- Define Voxel Weighting Parameters
    local voxelMode = 0
    local voxelFalloff = 0.4
    local voxelMaxInfluence = 4
    local voxelMaxRes = 512
    local voxelUseWinding = true
    local voxelEnvelopeOff = false

    -- Remove existing Skin modifier if found
    local existingSkinMod = undefined
    for m in obj.modifiers do (
        if classof m == Skin do (
            existingSkinMod = m
            exit
        )
    )
    if existingSkinMod != undefined do (
        deleteModifier obj existingSkinMod
        messageBox "Removed existing Skin modifier." title:"Info"
    )

    -- Ensure object is Editable_Poly
    if not (isKindOf obj Editable_Poly) do (
        convertToPoly obj
        obj = selection[1]
    )

    -- Find all bone nodes in the scene by name
    local boneNodesOrdered = #()
    for n in activeBoneNames do (
        local node = getNodeByName n
        if node != undefined and isValidBoneNode node then (
            append boneNodesOrdered node
        )
    )
    
    if boneNodesOrdered.count == 0 then (
        messageBox ("No " + activeGameTitle + " bones found in the scene. Create bones first!") title:"Error"
        return false
    )

    -- Add Skin modifier
    local skinMod = undefined
    for m in obj.modifiers where classof m == Skin do skinMod = m
    if skinMod == undefined then (
        skinMod = Skin()
        addModifier obj skinMod
    )

    -- Add bones to Skin modifier (excluding Root)
    format "Attempting to add % bones to the skin modifier (excluding Root)...\n" boneNodesOrdered.count
    local bonesAddedCount = 0
    for b in boneNodesOrdered where b != undefined do (
        if b.name != "Root" then (
            if not (skinHasBoneByNode skinMod b) do (
                skinOps.AddBone skinMod b 1
                bonesAddedCount += 1
            )
        ) else (
            format "Skipping Root bone: %\n" b.name
        )
    )
    format "% bones were added or already present in the skin modifier (excluding Root).\n" bonesAddedCount

    local numBones = skinOps.GetNumberBones skinMod
    format "skinOps.GetNumberBones reports % bones.\n" numBones

    if numBones == 0 then (
        messageBox "No bones were added to the Skin modifier." title:"Error"
        return false
    )

    -- Configure Initial Envelope Scaling
    skinMod.initialStaticEnvelope = false
    skinMod.initialOuterEnvelopePercent = 3.5
    skinMod.initialInnerEnvelopePercent = 0.75

    -- Apply voxel weighting if available
    if isProperty skinOps #voxelWeighting and (skinOps.voxelWeighting != undefined) then (
        try (
            skinOps.voxelWeighting skinMod voxelMode voxelFalloff voxelMaxInfluence voxelMaxRes voxelUseWinding voxelEnvelopeOff
            messageBox "Skin modifier added, vertices welded, bones attached, and voxel weights applied!" title:"Success"
            return true
        ) catch (
            local theError = getCurrentException()
            format "Voxel Weighting Error: %\n" theError
            messageBox ("Error applying voxel weighting:\n" + theError as string + "\n\nTry:\n- Reset XForm on mesh\n- Collapse to Editable Poly\n- Remove and re-add Skin modifier\n- Ensure all bones are true Bone objects\n- Remove any non-bone helpers from Skin\n- Try with a simple test mesh to isolate the issue") title:"Voxel Weighting Error"
            return false
        )
    ) else (
        messageBox "Voxel weighting is not available in this 3ds Max installation. Skin modifier added, but no auto weighting.\n\nYou can use manual weighting tools in the Skin modifier." title:"Warning"
        return true
    )
)

-- === UI Rollout (Optimized and Compact) ===
rollout gtaPED_tools "GTA PED Skeleton Tools" width:240
(
    button btn_loadData "Load External PED Data Script" pos:[10,10] width:220 height:24
    label lbl_dataStatus "No data loaded" pos:[10,40] width:220 align:#center
    
    button btn_createBonesAuto "Create Bones" pos:[10,65] width:220 height:24
    button btn_skinAuto "Skin Selected Mesh" pos:[10,95] width:220 height:24
    label lbl_skinNote "Select a mesh, then click to skin and add bones." pos:[10,125] width:220 align:#center

    fn updateDataStatus =
    (
        if activeGameTitle != "" and activeBoneNames != undefined then (
            lbl_dataStatus.text = activeGameTitle + " (" + activeBoneNames.count as string + " bones)"
            btn_createBonesAuto.enabled = true
            btn_skinAuto.enabled = true
        ) else (
            lbl_dataStatus.text = "No data loaded"
            btn_createBonesAuto.enabled = false
            btn_skinAuto.enabled = false
        )
    )

    on btn_loadData pressed do (
        if loadExternalPEDdata() then (
            updateDataStatus()
        )
    )

    on btn_createBonesAuto pressed do (
        if createActiveDummySkeleton() then (
            local allDummies = for obj in objects where (isKindOf obj Dummy and obj.boneEnable) collect obj
            select allDummies
            createActiveSkeleton_Adaptive()
        )
    )

    on btn_skinAuto pressed do (
        skinSelectedMeshAddBonesAndVoxelWeights()
    )
    
    on gtaPED_tools open do (
        updateDataStatus()
    )
)

try (destroyDialog gtaPED_tools) catch()
createDialog gtaPED_tools style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)