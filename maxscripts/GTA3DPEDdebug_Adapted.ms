-- GTA3DPEDdebug_Adapted.ms - Integrated Debug Tools for GTA:SA PED Skeleton
-- Compatible with 3ds Max 2017+
-- Integrates functionality from GTA3DPEDbones.ms and GTASAPEDdata.ms

-- Core debug structures
struct GTA3DBoneDebugInfo (transform, invBindMatrix, children)

-- Debug globals
global gta3dDebugBones = #()
global gta3dDebugLog = #()

-- GTA:SA Data globals (integrated from GTASAPEDdata.ms)
global gtaSABonePositions
global gtaSABoneRotations
global gtaSABoneHierarchy
global gtaSABoneNames
global gtaSATagData

-- Additional globals for bone management
global gtaSABonePositionsDict = #()
global gtaSABoneRotationsDict = #()

-- === LOGGING FUNCTIONS ===
fn gta3dDebugLogMsg msg =
(
    local logEntry = (timestamp() as string) + ": " + msg
    append gta3dDebugLog logEntry
    format "%\n" logEntry
)

fn showGTA3DDebugLog =
(
    rollout GTA3D_DebugLogRollout "GTA3D Debug Log" width:500 height:300
    (
        edittext edtLog "" readonly:true width:480 height:260 align:#center
        button btnClose "Close" width:80 align:#center
        
        on GTA3D_DebugLogRollout open do
        (
            local logText = ""
            for l in gta3dDebugLog do logText += l + "\n"
            edtLog.text = logText
        )
        
        on btnClose pressed do (destroyDialog GTA3D_DebugLogRollout)
    )
    createDialog GTA3D_DebugLogRollout modal:true
)

-- === GTA:SA DATA INITIALIZATION ===
fn initBoneData = 
(
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
    
    gta3dDebugLogMsg "GTA:SA bone data initialized"
)

-- Initialize bone data on load
initBoneData()

-- === UTILITY FUNCTIONS ===
fn getGTASATagData boneName =
(
    if gtaSATagData != undefined then
        for entry in gtaSATagData where entry[1] == boneName do return entry
    undefined
)

fn getGTASABonePos boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABonePositionsDict[boneNameAsName] != undefined then
        return gtaSABonePositionsDict[boneNameAsName]
    [0,0,0]
)

fn getGTASABoneRot boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABoneRotationsDict[boneNameAsName] != undefined then
        return gtaSABoneRotationsDict[boneNameAsName]
    quat 0 0 0 1
)

fn isValidBoneNode node =
(
    node != undefined and (
        (superClassOf node == GeometryClass and classOf node == BoneObj) or
        (isKindOf node Dummy and node.boneEnable)
    )
)

fn cleanObjectName objName =
(
    local cleanName = objName
    while cleanName.count > 0 and cleanName[1] == " " do
        cleanName = substring cleanName 2 -1
    while cleanName.count > 0 and cleanName[cleanName.count] == " " do
        cleanName = substring cleanName 1 (cleanName.count - 1)
    cleanName
)

-- === COMPARISON FUNCTIONS ===
fn matricesEqual m1 m2 tolerance:0.001 =
(
    for r = 1 to 4 do 
    (
        if distance m1[r] m2[r] > tolerance do return false
    )
    true
)

fn quatAngleDifference q1 q2 =
(
    local nq1 = normalize q1
    local nq2 = normalize q2
    local dotProd = nq1.x * nq2.x + nq1.y * nq2.y + nq1.z * nq2.z + nq1.w * nq2.w
    dotProd = abs(dotProd)
    if dotProd > 1.0 then dotProd = 1.0
    if dotProd < 0.0 then dotProd = 0.0
    local angleDeg = 2.0 * acos(dotProd) * 57.2958
    if angleDeg > 180.0 then angleDeg = 360.0 - angleDeg
    angleDeg
)

fn compareSelectedObjectsToGTASAData positionTolerance:0.001 rotationTolerance:0.01 =
(
    if selection.count == 0 then
    (
        messageBox "Please select one or more objects to compare." title:"No Selection"
        return()
    )
    
    local totalObjects = selection.count
    local positionMatches = 0
    local rotationMatches = 0
    local positionMismatches = 0
    local rotationMismatches = 0
    local notFoundInData = 0
    
    format "\n=== Comparing % selected objects to GTA:SA data ===\n" totalObjects
    gta3dDebugLogMsg ("Starting comparison of " + totalObjects as string + " selected objects to GTA:SA data")
    
    for obj in selection do
    (
        local objName = cleanObjectName obj.name
        local foundPosition = false
        local foundRotation = false
        local externalPos = undefined
        local externalQuat = undefined
        
        -- Find position data
        for posEntry in gtaSABonePositions do
        (
            local cleanExternalName = cleanObjectName posEntry[1]
            if cleanExternalName == objName then
            (
                externalPos = posEntry[2]
                foundPosition = true
                exit
            )
        )
        
        -- Find rotation data
        for quatEntry in gtaSABoneRotations do
        (
            local cleanExternalName = cleanObjectName quatEntry[1]
            if cleanExternalName == objName then
            (
                externalQuat = quatEntry[2]
                foundRotation = true
                exit
            )
        )
        
        if not foundPosition and not foundRotation then
        (
            format "Object '%' not found in GTA:SA data\n" objName
            gta3dDebugLogMsg ("Object not found in GTA:SA data: " + objName)
            notFoundInData += 1
            continue
        )
        
        -- Compare positions
        if foundPosition then
        (
            local scenePos = obj.transform.row4
            local posDistance = distance scenePos externalPos
            
            if posDistance <= positionTolerance then
            (
                format "Position MATCH for '%': distance = %\n" objName posDistance
                positionMatches += 1
            )
            else
            (
                format "Position MISMATCH for '%': distance = %\n" objName posDistance
                format "  Scene: % | GTA:SA: %\n" scenePos externalPos
                gta3dDebugLogMsg ("Position mismatch: " + objName + " distance: " + posDistance as string)
                positionMismatches += 1
            )
        )
        
        -- Compare rotations
        if foundRotation then
        (
            try
            (
                local sceneQuat = obj.transform as quat
                local angleDiff = quatAngleDifference sceneQuat externalQuat
                
                if angleDiff <= rotationTolerance then
                (
                    format "Rotation MATCH for '%': angle diff = % degrees\n" objName angleDiff
                    rotationMatches += 1
                )
                else
                (
                    format "Rotation MISMATCH for '%': angle diff = % degrees\n" objName angleDiff
                    format "  Scene: % | GTA:SA: %\n" sceneQuat externalQuat
                    gta3dDebugLogMsg ("Rotation mismatch: " + objName + " angle diff: " + angleDiff as string)
                    rotationMismatches += 1
                )
            )
            catch
            (
                format "Error comparing rotation for '%' - skipping rotation check\n" objName
                gta3dDebugLogMsg ("Rotation comparison error for: " + objName)
            )
        )
    )
    
    -- Summary
    format "\n=== COMPARISON SUMMARY ===\n"
    format "Total objects compared: %\n" totalObjects
    format "Position matches: %\n" positionMatches
    format "Position mismatches: %\n" positionMismatches
    format "Rotation matches: %\n" rotationMatches
    format "Rotation mismatches: %\n" rotationMismatches
    format "Objects not found in GTA:SA data: %\n" notFoundInData
    format "Position tolerance: %\n" positionTolerance
    format "Rotation tolerance: % degrees\n" rotationTolerance
    
    local summaryMsg = "GTA:SA comparison complete - Pos: " + positionMatches as string + "/" + (positionMatches + positionMismatches) as string + 
                      " Rot: " + rotationMatches as string + "/" + (rotationMatches + rotationMismatches) as string
    gta3dDebugLogMsg summaryMsg
)

fn extractCurrentSceneData =
(
    if selection.count == 0 then
    (
        messageBox "Please select objects to extract data from." title:"No Selection"
        return()
    )
    
    format "\n=== EXTRACTED SCENE DATA ===\n"
    format "-- Positions:\n"
    format "gta3dBonePositions = #(\n"
    
    for i = 1 to selection.count do
    (
        local obj = selection[i]
        local objName = cleanObjectName obj.name
        local pos = obj.transform.row4
        local commaStr = if i < selection.count then "," else ""
        format "    #(\"%\", [%,%,%])%\n" objName pos.x pos.y pos.z commaStr
    )
    format ")\n\n"
    
    format "-- Rotations:\n"
    format "gta3dBoneQuats = #(\n"
    for i = 1 to selection.count do
    (
        local obj = selection[i]
        local objName = cleanObjectName obj.name
        local objQuat = obj.transform as quat
        local commaStr = if i < selection.count then "," else ""
        format "    #(\"%\", (quat % % % %))%\n" objName objQuat.x objQuat.y objQuat.z objQuat.w commaStr
    )
    format ")\n"
    
    gta3dDebugLogMsg "Extracted current scene data for selected objects"
)

-- === SKELETON CREATION FUNCTIONS ===
fn createGTASADummySkeleton_Accurate =
(
    -- Delete old GTASA dummies
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
    gta3dDebugLogMsg "Created GTA:SA dummy skeleton"
)

-- === HIERARCHY ANALYSIS FUNCTIONS ===
fn printGTASABoneHierarchy =
(
    if gtaSABoneHierarchy == undefined or gtaSABoneHierarchy.count == 0 then
    (
        format "No GTA:SA bone hierarchy data available.\n"
        return()
    )
    
    format "\n=== GTA:SA BONE HIERARCHY ===\n"
    for boneData in gtaSABoneHierarchy do 
    (
        local boneName = boneData[1]
        local parentNames = boneData[2]
        local parentName = if parentNames.count > 0 then parentNames[1] else "None"
        format "%: parent: %\n" boneName parentName
    )
    gta3dDebugLogMsg "Printed GTA:SA bone hierarchy"
)

fn printSceneHierarchy node indent:"" =
(
    if node == undefined then return ()
    format "%\n" (indent + node.name)
    local childCount = node.children.count
    for c = 1 to childCount do
    (
        printSceneHierarchy node.children[c] indent:(indent + "  ")
    )
)

fn showGTASADataInfo =
(
    format "\n=== GTA:SA DATA INFO ===\n"
    format "Positions: % entries\n" gtaSABonePositions.count
    format "Rotations: % entries\n" gtaSABoneRotations.count
    format "Hierarchy: % entries\n" gtaSABoneHierarchy.count
    format "Tag Data: % entries\n" gtaSATagData.count
    
    format "\nAvailable bone names in GTA:SA data:\n"
    local maxShow = amin #(10, gtaSABoneNames.count)
    for i = 1 to maxShow do
        format "  %\n" gtaSABoneNames[i]
    
    if gtaSABoneNames.count > 10 then
        format "  ... and % more\n" (gtaSABoneNames.count - 10)
    
    gta3dDebugLogMsg "Displayed GTA:SA data info"
)

fn getSkinModifier node =
(
    for m in node.modifiers do
    (
        if classof m == Skin then return m
    )
    undefined
)

fn extractSkinBoneNamesAsIs meshNode =
(
    local skinMod = getSkinModifier meshNode
    if skinMod == undefined then
    (
        messageBox "No Skin modifier found on the selected object." title:"Extract Bones"
        return undefined
    )
    
    local boneNames = #()
    local numBones = skinOps.getNumberBones skinMod
    for i = 1 to numBones do
    (
        local boneName = skinOps.getBoneName skinMod i 0
        append boneNames boneName
    )
    boneNames
)

fn showGTA3DDebugHelp =
(
    local helpText = "GTA3D PED Debug Tools (Adapted) Help\n\n"
    helpText += "INTEGRATED FEATURES:\n"
    helpText += "- Built-in GTA:SA bone data (positions, rotations, hierarchy)\n"
    helpText += "- Compare Selected Objects: Compare any objects to GTA:SA reference data\n"
    helpText += "- Create GTA:SA Dummy Skeleton: Generate complete dummy skeleton\n"
    helpText += "- Show GTA:SA Data Info: Display built-in bone data summary\n\n"
    helpText += "CLASSIC FEATURES:\n"
    helpText += "- Extract Current Scene Data: Export positions/rotations from selection\n"
    helpText += "- Print GTA:SA Hierarchy: Display bone parent-child relationships\n"
    helpText += "- Extract Skin Bone List: List bones in selected mesh's Skin modifier\n"
    helpText += "- Extract Scene Hierarchy: Display hierarchy tree from selected node\n"
    helpText += "- Debug Log: Track all operations and comparisons\n\n"
    helpText += "USAGE:\n"
    helpText += "1. Select objects in scene (bones, dummies, meshes, etc.)\n"
    helpText += "2. Use 'Compare Selected Objects' to validate against GTA:SA data\n"
    helpText += "3. Use 'Create GTA:SA Dummy Skeleton' to generate reference skeleton\n"
    helpText += "4. Adjust tolerance values for comparison precision\n\n"
    helpText += "Works with bones, dummies, meshes, and any other object types."
    
    messageBox helpText title:"GTA3D Debug Help (Adapted)"
)

-- === USER INTERFACE ===
rollout GTA3D_DebugTools_Adapted "GTA3D PED Debug (Adapted)" width:300
(
    group "GTA:SA Integration"
    (
        button btnShowGTASAInfo "Show GTA:SA Data Info" width:270 align:#center
        button btnCreateGTASADummies "Create GTA:SA Dummy Skeleton" width:270 align:#center
        button btnPrintGTASAHierarchy "Print GTA:SA Hierarchy" width:270 align:#center
    )
    
    group "Comparison Tools"
    (
        spinner spnPosTolerance "Position Tolerance:" range:[0.0001, 1.0, 0.001] type:#float scale:0.0001 width:270 align:#center
        spinner spnRotTolerance "Rotation Tolerance (deg):" range:[0.001, 45.0, 0.01] type:#float scale:0.001 width:270 align:#center
        button btnCompareToGTASA "Compare Selected to GTA:SA Data" width:270 align:#center height:30
        button btnExtractSceneData "Extract Current Scene Data" width:270 align:#center
    )
    
    group "Scene Analysis"
    (
        button btnExtractBones "Extract Skin Bone List (as is)" width:270 align:#center
        button btnExtractSceneHierarchy "Extract Scene Hierarchy" width:270 align:#center
    )
    
    group "Utilities"
    (
        button btnShowLog "Show Debug Log" width:270 align:#center
        button btnHelp "Help" width:270 align:#center
    )
    
    fn updateButtonStates =
    (
        local selCount = selection.count
        local hasSkin = false
        
        if selCount == 1 do 
        (
            local skinMod = getSkinModifier selection[1]
            hasSkin = (skinMod != undefined)
        )
        
        btnExtractBones.enabled = (selCount == 1 and hasSkin)
        btnExtractSceneHierarchy.enabled = (selCount == 1)
        btnCompareToGTASA.enabled = (selCount > 0)
        btnExtractSceneData.enabled = (selCount > 0)
    )
    
    -- Event handlers
    on btnShowGTASAInfo pressed do showGTASADataInfo()
    
    on btnCreateGTASADummies pressed do 
    (
        createGTASADummySkeleton_Accurate()
        messageBox "GTA:SA dummy skeleton created!" title:"Success"
    )
    
    on btnPrintGTASAHierarchy pressed do printGTASABoneHierarchy()
    
    on btnCompareToGTASA pressed do 
    (
        compareSelectedObjectsToGTASAData positionTolerance:spnPosTolerance.value rotationTolerance:spnRotTolerance.value
    )
    
    on btnExtractSceneData pressed do extractCurrentSceneData()
    
    on btnExtractBones pressed do
    (
        if selection.count != 1 then
            messageBox "Please select a single skinned mesh." title:"Extract Bones"
        else
        (
            local bones = extractSkinBoneNamesAsIs selection[1]
            if bones != undefined do
            (
                format "Bones in Skin modifier (as is):\n"
                for b in bones do format "%\n" b
                gta3dDebugLogMsg "Extracted skin bone list"
            )
        )
    )
    
    on btnExtractSceneHierarchy pressed do
    (
        if selection.count != 1 then
            messageBox "Please select a single node (root bone or any bone)." title:"Extract Scene Hierarchy"
        else
        (
            format "Scene Hierarchy (from selected node):\n"
            printSceneHierarchy selection[1] indent:""
            gta3dDebugLogMsg "Extracted scene hierarchy"
        )
    )
    
    on btnShowLog pressed do showGTA3DDebugLog()
    
    on btnHelp pressed do showGTA3DDebugHelp()
    
    on GTA3D_DebugTools_Adapted open do updateButtonStates()
    
    on selection changed do updateButtonStates()
)

-- Create the dialog
try (destroyDialog GTA3D_DebugTools_Adapted) catch()
createDialog GTA3D_DebugTools_Adapted

format "GTA3D PED Debug Tools (Adapted) loaded successfully!\n"
format "Integrated with GTA:SA bone data and skeleton creation tools.\n"
gta3dDebugLogMsg "GTA3D Debug Tools (Adapted) initialized" 