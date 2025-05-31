global gtaSABonePositions
global gtaSABoneRotations
global gtaSABoneHierarchy
global gtaSABoneNames
global gtaSATagData

-- Additional globals for GTA:SA specific functionality
global gtaSABonePositionsDict = #()
global gtaSABoneRotationsDict = #()

fn initBoneData = (
    -- Clear arrays
    gtaSABonePositions = #()
    gtaSABoneRotations = #()
    gtaSABoneHierarchy = #()
    gtaSATagData = #()

    gtaSABonePositions = #(
        #("Root", [0.0, 0.0, 0.0]),
        #(" Pelvis", [-0.003663, 0.020705, 0.0]),
        #(" R Thigh", [-0.124164, 0.0207048, 0.0]),
        #(" R Calf", [-0.15706, 0.0678042, -0.46169]),
        #(" R Foot", [-0.186147, 0.114274, -0.869678]),
        #(" R Toe0", [-0.186147, -0.0350336, -0.999365]),
        #(" L Thigh", [0.116838, 0.0207051, 1.33142e-07]),
        #(" L Calf", [0.149721, 0.0694108, -0.461523]),
        #(" L Foot", [0.178797, 0.1173, -0.869348]),
        #(" L Toe0", [0.178797, -0.0320077, -0.999035]),
        #(" Spine", [0.001131, 0.0711136, -0.00577686]),
        #("Belly", [0.000714986, 0.140938, 0.100812]),
        #(" Spine1", [0.00113099, 0.0711054, 0.276242]),
        #("R breast", [-0.0984546, 0.139457, 0.415739]),
        #("L breast", [0.102181, 0.139457, 0.413274]),
        #(" Neck", [0.00113098, 0.0710003, 0.548069]),
        #("Bip01 R Clavicle", [-0.0307, 0.0709069, 0.548036]),
        #(" R UpperArm", [-0.195887, 0.07379, 0.525049]),
        #(" R ForeArm", [-0.302444, 0.0758799, 0.249923]),
        #(" R Hand", [-0.403972, 0.0738097, -0.0122105]),
        #(" R Finger", [-0.442086, 0.0804671, -0.0916656]),
        #("R Finger01", [-0.447134, 0.0849133, -0.153457]),
        #("Bip01 L Clavicle", [0.032962, 0.0709069, 0.548036]),
        #(" L UpperArm", [0.198149, 0.07379, 0.525049]),
        #(" L ForeArm", [0.300369, 0.0758676, 0.248283]),
        #(" L Hand", [0.397764, 0.0737856, -0.0154139]),
        #(" L Finger", [0.434625, 0.0804393, -0.0954584]),
        #("L Finger01", [0.438702, 0.0848829, -0.157321]),
        #(" Head", [0.00113087, 0.0294664, 0.687987]),
        #("R Brow", [-0.0191032, 0.0280554, 0.776743]),
        #("L Brow", [0.0250642, 0.0277662, 0.777308]),
        #("Jaw", [0.000714869, 0.00683095, 0.681905])
    )

    gtaSABoneRotations = #(
        #("Root", quat 0 0 1 1),
        #(" Pelvis", quat 0.707107 7.54522e-07 0.707106 4.57902e-07),
        #(" R Thigh", quat -0.680707 -0.0358724 0.730798 -0.0358496),
        #(" R Calf", quat -0.680485 -0.0398602 0.730576 -0.040131),
        #(" R Foot", quat -0.707107 0.0 0.707107 0.0),
        #(" R Toe0", quat 0.5 -0.5 -0.5 -0.5),
        #(" L Thigh", quat 0.73073 0.0371183 -0.680649 0.037053),
        #(" L Calf", quat 0.7305 0.0413992 -0.68042 0.0410406),
        #(" L Foot", quat 0.707107 0.0 -0.707107 0.0),
        #(" L Toe0", quat 0.5 -0.5 -0.5 -0.5),
        #(" Spine", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("Belly", quat -0.5 -0.5 -0.5 0.5),
        #(" Spine1", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("R breast", quat 0.538775 -0.510408 0.507165 0.438165),
        #("L breast", quat 0.479924 -0.378347 0.583498 0.534842),
        #(" Neck", quat 0.69976 -0.101668 0.69976 0.101666),
        #("Bip01 R Clavicle", quat 0.00870505 0.997574 -0.000602715 -0.0690672),
        #(" R UpperArm", quat -0.0031226 -0.824968 -0.00170867 0.565168),
        #(" R ForeArm", quat 0.00283658 -0.824969 0.00237413 0.565166),
        #(" R Hand", quat 0.398232 0.61339 -0.582575 -0.354642),
        #(" R Finger", quat 0.502981 0.530729 -0.508855 -0.454317),
        #("R Finger01", quat -0.651543 -0.331896 0.32756 0.598365),
        #("Bip01 L Clavicle", quat 0.000602537 -0.0690666 -0.00870508 0.997574),
        #(" L UpperArm", quat -0.00172047 -0.571633 -0.00309243 0.820502),
        #(" L ForeArm", quat 0.0024091 -0.571631 0.00283498 0.820503),
        #(" L Hand", quat 0.579437 -0.359463 -0.402786 0.610575),
        #(" L Finger", quat 0.504894 -0.458486 -0.506951 0.527136),
        #("L Finger01", quat -0.322432 0.60097 0.654083 -0.327181),
        #(" Head", quat 0.706907 -0.0168155 0.706907 0.0168136),
        #("R Brow", quat 0.461751 -0.518947 0.539025 0.476374),
        #("L Brow", quat 0.549406 -0.469667 0.450093 0.524387),
        #("Jaw", quat 0.387698 -0.591346 0.387699 0.591346)
    )

    gtaSABoneHierarchy = #(
        #("Root", #()),
        #(" Pelvis", #("Root")),
        #(" R Thigh", #(" Pelvis")),
        #(" R Calf", #(" R Thigh")),
        #(" R Foot", #(" R Calf")),
        #(" R Toe0", #(" R Foot")),
        #(" L Thigh", #(" Pelvis")),
        #(" L Calf", #(" L Thigh")),
        #(" L Foot", #(" L Calf")),
        #(" L Toe0", #(" L Foot")),
        #(" Spine", #(" Pelvis")),
        #("Belly", #(" Spine")),
        #(" Spine1", #(" Spine")),
        #("R breast", #(" Spine1")),
        #("L breast", #(" Spine1")),
        #(" Neck", #(" Spine1")),
        #("Bip01 R Clavicle", #(" Neck")),
        #(" R UpperArm", #("Bip01 R Clavicle")),
        #(" R ForeArm", #(" R UpperArm")),
        #(" R Hand", #(" R ForeArm")),
        #(" R Finger", #(" R Hand")),
        #("R Finger01", #(" R Finger")),
        #("Bip01 L Clavicle", #(" Neck")),
        #(" L UpperArm", #("Bip01 L Clavicle")),
        #(" L ForeArm", #(" L UpperArm")),
        #(" L Hand", #(" L ForeArm")),
        #(" L Finger", #(" L Hand")),
        #("L Finger01", #(" L Finger")),
        #(" Head", #(" Neck")),
        #("R Brow", #(" Head")),
        #("L Brow", #(" Head")),
        #("Jaw", #(" Head"))
    )

    gtaSABoneNames = #(
        "Root",
        " Pelvis",
        " R Thigh",
        " R Calf",
        " R Foot",
        " R Toe0",
        " L Thigh",
        " L Calf",
        " L Foot",
        " L Toe0",
        " Spine",
        "Belly",
        " Spine1",
        "R breast",
        "L breast",
        " Neck",
        "Bip01 R Clavicle",
        " R UpperArm",
        " R ForeArm",
        " R Hand",
        " R Finger",
        "R Finger01",
        "Bip01 L Clavicle",
        " L UpperArm",
        " L ForeArm",
        " L Hand",
        " L Finger",
        "L Finger01",
        " Head",
        "R Brow",
        "L Brow",
        "Jaw"
    )

    gtaSATagData = #(
        #("Root", 0, undefined, true),
        #(" Pelvis", 1, undefined, undefined),
        #(" R Thigh", 51, 2, undefined),
        #(" R Calf", 52, undefined, undefined),
        #(" R Foot", 53, undefined, undefined),
        #(" R Toe0", 54, undefined, undefined),
        #(" L Thigh", 41, 1, undefined),
        #(" L Calf", 42, undefined, undefined),
        #(" L Foot", 43, undefined, undefined),
        #(" L Toe0", 44, undefined, undefined),
        #(" Spine", 2, 0, undefined),
        #("Belly", 201, 1, undefined),
        #(" Spine1", 3, 0, undefined),
        #("R breast", 301, 2, undefined),
        #("L breast", 302, 1, undefined),
        #(" Neck", 4, 0, undefined),
        #("Bip01 R Clavicle", 21, 2, undefined),
        #(" R UpperArm", 22, undefined, undefined),
        #(" R ForeArm", 23, undefined, undefined),
        #(" R Hand", 24, undefined, undefined),
        #(" R Finger", 25, undefined, undefined),
        #("R Finger01", 26, undefined, undefined),
        #("Bip01 L Clavicle", 31, 1, undefined),
        #(" L UpperArm", 32, undefined, undefined),
        #(" L ForeArm", 33, undefined, undefined),
        #(" L Hand", 34, undefined, undefined),
        #(" L Finger", 35, undefined, undefined),
        #("L Finger01", 36, undefined, undefined),
        #(" Head", 5, 0, undefined),
        #("R Brow", 7, 2, undefined),
        #("L Brow", 6, 1, undefined),
        #("Jaw", 8, 0, undefined)
    )

    -- Create dictionaries for fast lookup
    gtaSABonePositionsDict = Dictionary name:#gtaSABonePositionsDict
    for bonePos in gtaSABonePositions do (
        gtaSABonePositionsDict[(bonePos[1] as name)] = bonePos[2]
    )
    gtaSABoneRotationsDict = Dictionary name:#gtaSABoneRotationsDict
    for boneRot in gtaSABoneRotations do (
        gtaSABoneRotationsDict[(boneRot[1] as name)] = boneRot[2]
    )
)

-- === GTA:SA SPECIFIC HELPER FUNCTIONS ===
fn getGTASATagData boneName =
(
    if gtaSATagData != undefined then
        for entry in gtaSATagData where entry[1] == boneName do return entry
    undefined
)

fn getGTASABonePos boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABonePositionsDict != undefined and gtaSABonePositionsDict[boneNameAsName] != undefined then
        return gtaSABonePositionsDict[boneNameAsName]
    [0,0,0] -- Default position if not found
)

fn getGTASABoneRot boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABoneRotationsDict != undefined and gtaSABoneRotationsDict[boneNameAsName] != undefined then
        return gtaSABoneRotationsDict[boneNameAsName]
    quat 0 0 0 1 -- Default rotation if not found
)

fn isValidBoneNode node =
(
    node != undefined and (
        (superClassOf node == GeometryClass and classOf node == BoneObj) or
        (isKindOf node Dummy and node.boneEnable)
    )
)

-- === GTA:SA SKELETON CREATION FUNCTIONS ===
fn createGTASADummySkeleton_Accurate =
(
    if gtaSABoneHierarchy == undefined or gtaSABoneHierarchy.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
        return false
    )
    
    -- Delete old GTA:SA dummies
    for boneData in gtaSABoneHierarchy do (
        local name = boneData[1]
        for obj in objects where (classof obj == Dummy and obj.name == name) do delete obj
    )

    local dummyArray = #()
    local rootDummy = undefined
    for boneData in gtaSABoneHierarchy do (
        local boneName = boneData[1]
        local d = Dummy name:boneName
        d.boxsize = [0.05,0.05,0.05]
        d.boneEnable = true

        local tagInfo = getGTASATagData boneName
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

        local posArray = getGTASABonePos boneName
        local rot = getGTASABoneRot boneName
        if rot == undefined do rot = quat 0 0 0 1
        local pos = point3 posArray[1] posArray[2] posArray[3]
        local tm = (rot as matrix3)
        tm.row4 = pos
        d.transform = tm

        append dummyArray #(boneName, d)
        if boneName == "Root" then rootDummy = d
    )

    -- Set parent relationships
    for boneData in gtaSABoneHierarchy do (
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
    format "GTA:SA dummy skeleton created with corrected rotations!\n"
    return true
)

fn createGTASASkeleton_Adaptive =
(
    if gtaSABoneHierarchy == undefined or gtaSABoneHierarchy.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
        return false
    )
    
    local selectedDummies = for o in selection where (isKindOf o Dummy and o.boneEnable) collect o
    if selectedDummies.count == 0 then (
        messageBox "Select the GTA:SA dummies to convert to bones." title:"Error"
        return false
    )

    local selectedNames = for d in selectedDummies collect d.name
    local boneArray = #()
    local rootBone = undefined

    for boneData in gtaSABoneHierarchy do (
        local boneName = boneData[1]
        if findItem selectedNames boneName > 0 then (
            local bone = BoneSys.createBone [0,0,0] [0,0,0.1] [0,0,1]
            bone.name = boneName
            bone.width = 0.05
            bone.height = 0.05
            bone.wirecolor = color 255 200 100
            if boneName == "Root" then rootBone = bone
            append boneArray #(boneName, bone)

            local tagInfo = getGTASATagData boneName
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
    for boneData in gtaSABoneHierarchy do (
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
    format "GTA:SA bones created with corrected rotations (dummies auto-deleted)!\n"
    return true
)

-- === GTA:SA SKINNING FUNCTIONS ===
fn collectGTASAChildBones parentBoneName &boneList =
(
    if gtaSABoneHierarchy == undefined then return()
    appendIfUnique boneList parentBoneName
    for boneData in gtaSABoneHierarchy where boneData[2].count > 0 and boneData[2][1] == parentBoneName do
        collectGTASAChildBones boneData[1] &boneList
)

fn skinHasBoneByNode skinMod boneNode =
(
    local numBones = skinOps.GetNumberBones skinMod
    for i = 1 to numBones do (
        if skinOps.GetBoneNode skinMod i == boneNode then return true
    )
    false
)

fn skinSelectedMeshWithGTASABones =
(
    if gtaSABoneNames == undefined or gtaSABoneNames.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
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
        format "Removed existing Skin modifier.\n"
    )

    -- Ensure object is Editable_Poly
    if not (isKindOf obj Editable_Poly) do (
        convertToPoly obj
        obj = selection[1]
    )

    -- Find all GTA:SA bone nodes in the scene by name
    local boneNodesOrdered = #()
    for n in gtaSABoneNames do (
        local node = getNodeByName n
        if node != undefined and isValidBoneNode node then (
            append boneNodesOrdered node
        )
    )
    
    if boneNodesOrdered.count == 0 then (
        messageBox "No GTA:SA bones found in the scene. Create bones first!" title:"Error"
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
    format "Attempting to add % GTA:SA bones to the skin modifier (excluding Root)...\n" boneNodesOrdered.count
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
            format "GTA:SA skin modifier added, vertices welded, bones attached, and voxel weights applied!\n"
            return true
        ) catch (
            local theError = getCurrentException()
            format "Voxel Weighting Error: %\n" theError
            messageBox ("Error applying voxel weighting:\n" + theError as string + "\n\nTry:\n- Reset XForm on mesh\n- Collapse to Editable Poly\n- Remove and re-add Skin modifier\n- Ensure all bones are true Bone objects\n- Remove any non-bone helpers from Skin\n- Try with a simple test mesh to isolate the issue") title:"Voxel Weighting Error"
            return false
        )
    ) else (
        format "Voxel weighting is not available in this 3ds Max installation. Skin modifier added, but no auto weighting.\n"
        return true
    )
)

-- === GTA:SA BONE FIXING FUNCTIONS ===
fn fixGTASABoneRotations =
(
    if gtaSABoneNames == undefined or gtaSABoneNames.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
        return false
    )
    
    local fixedCount = 0
    for boneName in gtaSABoneNames do (
        local boneNode = getNodeByName boneName
        if boneNode != undefined and isValidBoneNode boneNode then (
            local correctRot = getGTASABoneRot boneName
            if correctRot != undefined then (
                local correctPos = boneNode.transform.row4 -- Keep current position
                local correctedMatrix = correctRot as matrix3
                correctedMatrix.row4 = correctPos
                boneNode.transform = correctedMatrix
                fixedCount += 1
                format "Fixed rotation for bone: %\n" boneName
            )
        )
    )
    format "Fixed rotations for % GTA:SA bones.\n" fixedCount
    return true
)

fn fixGTASABonePositions =
(
    if gtaSABoneNames == undefined or gtaSABoneNames.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
        return false
    )
    
    local fixedCount = 0
    for boneName in gtaSABoneNames do (
        local boneNode = getNodeByName boneName
        if boneNode != undefined and isValidBoneNode boneNode then (
            local correctPos = getGTASABonePos boneName
            if correctPos != undefined then (
                local currentMatrix = boneNode.transform
                currentMatrix.row4 = point3 correctPos[1] correctPos[2] correctPos[3]
                boneNode.transform = currentMatrix
                fixedCount += 1
                format "Fixed position for bone: %\n" boneName
            )
        )
    )
    format "Fixed positions for % GTA:SA bones.\n" fixedCount
    return true
)

fn fixGTASABoneTransforms =
(
    if gtaSABoneNames == undefined or gtaSABoneNames.count == 0 then (
        messageBox "GTA:SA bone data not initialized. Run initBoneData() first." title:"No Data"
        return false
    )
    
    local fixedCount = 0
    for boneName in gtaSABoneNames do (
        local boneNode = getNodeByName boneName
        if boneNode != undefined and isValidBoneNode boneNode then (
            local correctPos = getGTASABonePos boneName
            local correctRot = getGTASABoneRot boneName
            if correctPos != undefined and correctRot != undefined then (
                local correctedMatrix = correctRot as matrix3
                correctedMatrix.row4 = point3 correctPos[1] correctPos[2] correctPos[3]
                boneNode.transform = correctedMatrix
                fixedCount += 1
                format "Fixed transform for bone: %\n" boneName
            )
        )
    )
    format "Fixed transforms for % GTA:SA bones.\n" fixedCount
    return true
)

-- === INITIALIZATION ===
initBoneData()
format "GTA:SA PED data loaded with % bones and utility functions.\n" gtaSABoneNames.count