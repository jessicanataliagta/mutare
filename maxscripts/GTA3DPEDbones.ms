global gtaSABoneHierarchy = #()
global gtaSABonePositionsDict = #()
global gtaSABoneRotationsDict = #()
global gtaSABoneNames = #()
global gtaSABonePositions = #()
global gtaSABoneRotations = #()
global gtaSATagData = #()

fn getGTASATagData boneName =
(
    if gtaSATagData != undefined then
        for entry in gtaSATagData where entry[1] == boneName do return entry
    undefined
)

fn loadGTASAPEDdata =
(
    local scriptPath = getFilenamePath (getSourceFileName())
    local dataFilePath = scriptPath + "GTASAPEDdata_Fixed.ms"
    local dataLoaded = false
    if doesFileExist dataFilePath then (
        fileIn dataFilePath
        if (gtaSABoneNames != undefined and gtaSABonePositions != undefined and
            gtaSABoneHierarchy != undefined and gtaSABoneRotations != undefined and
            gtaSABoneNames.count > 0 and gtaSABoneHierarchy.count > 0) then (
            dataLoaded = true
        )
    )
    if not dataLoaded then (
        dataFilePath = scriptPath + "GTASAPEDdata.ms"
        if doesFileExist dataFilePath then (
            fileIn dataFilePath
            if (gtaSABoneNames != undefined and gtaSABonePositions != undefined and
                gtaSABoneHierarchy != undefined and gtaSABoneRotations != undefined and
                gtaSABoneNames.count > 0 and gtaSABoneHierarchy.count > 0) then (
                dataLoaded = true
            )
        )
    )
    if dataLoaded then (
        gtaSABonePositionsDict = Dictionary name:#gtaSABonePositionsDict
        for bonePos in gtaSABonePositions do gtaSABonePositionsDict[(bonePos[1] as name)] = bonePos[2]
        gtaSABoneRotationsDict = Dictionary name:#gtaSABoneRotationsDict
        for boneRot in gtaSABoneRotations do gtaSABoneRotationsDict[(boneRot[1] as name)] = boneRot[2]
        true
    ) else (
        messageBox "Bone data not loaded. Please ensure GTASAPEDdata_Fixed.ms or GTASAPEDdata.ms are in the same folder as this script." title:"Error"
        false
    )
)

if (gtaSABoneNames == undefined or gtaSABonePositions == undefined or
    gtaSABoneHierarchy == undefined or gtaSABoneRotations == undefined or
    gtaSABoneNames.count == 0 or gtaSABoneHierarchy.count == 0) then (
    if not loadGTASAPEDdata() then throw "GTA:SA PED data not loaded"
)

fn getGTASABonePos boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABonePositionsDict[boneNameAsName] != undefined then
        gtaSABonePositionsDict[boneNameAsName]
    else [0,0,0]
)

fn getGTASABoneRot boneName =
(
    local boneNameAsName = boneName as name
    if gtaSABoneRotationsDict[boneNameAsName] != undefined then
        gtaSABoneRotationsDict[boneNameAsName]
    else quat 0 0 0 1
)

fn isValidBoneNode node =
(
    node != undefined and (
        (superClassOf node == GeometryClass and classOf node == BoneObj) or
        (isKindOf node Dummy and node.boneEnable)
    )
)

fn isMeshObject obj =
(
    (isKindOf obj Editable_Mesh) or (isKindOf obj Editable_Poly) or (superClassOf obj == GeometryClass and classOf obj != BoneObj)
)

fn safeConvertSelectionToPoly =
(
    for obj in selection do
        if isMeshObject obj and not (isKindOf obj Editable_Poly) do convertToPoly obj
)

fn createGTASASkeleton_Adaptive =
(
    local selectedDummies = for o in selection where (isKindOf o Dummy and o.boneEnable) collect o
    if selectedDummies.count == 0 then (messageBox "Select the GTA3D PED bones to convert to bones." title:"Error"; return false)
    local selectedNames = for d in selectedDummies collect d.name
    local boneArray = #()
    for boneData in gtaSABoneHierarchy do (
        local boneName = boneData[1]
        if findItem selectedNames boneName > 0 then (
            local bone = BoneSys.createBone [0,0,0] [0,0,0.1] [0,0,1]
            bone.name = boneName
            bone.width = 0.05
            bone.height = 0.05
            bone.wirecolor = color 255 200 100
            append boneArray #(boneName, bone)
            local tagInfo = getGTASATagData boneName
            if tagInfo != undefined then (
                local buffer = ""
                if tagInfo[2] != undefined do buffer += "tag = " + tagInfo[2] as string
                if tagInfo[3] != undefined do (if buffer != "" then buffer += "\r\n"; buffer += "childNum = " + tagInfo[3] as string)
                if tagInfo[4] != undefined do (if buffer != "" then buffer += "\r\n"; buffer += "fakeBiped = " + tagInfo[4] as string)
                if buffer != "" do setUserPropBuffer bone buffer
            )
            for d in selectedDummies where d.name == boneName do bone.transform = d.transform
        )
    )
    for boneData in gtaSABoneHierarchy do (
        local boneName = boneData[1]
        local parentNames = boneData[2]
        if findItem selectedNames boneName > 0 then (
            local bone, parentBone
            for item in boneArray do (
                if item[1] == boneName then bone = item[2]
                if parentNames.count > 0 and item[1] == parentNames[1] then parentBone = item[2]
            )
            if bone != undefined and parentBone != undefined do bone.parent = parentBone
        )
    )
    for boneData in boneArray do (
        local bone = boneData[2]
        if bone.children.count > 0 then (
            for c in bone.children where isValidBoneNode c do (
                if (distance bone.position c.position) > 0.0001 do bone.length = distance bone.position c.position
                exit
            )
        )
    )
    for boneData in boneArray do (
        local bone = boneData[2]
        if bone.children.count == 0 and bone.parent != undefined and isValidBoneNode bone.parent then (
            bone.length = 0.1 * (distance bone.position bone.parent.position)
        )
    )
    for bone in (for item in boneArray collect item[2]) do try(bone.scale = [1,1,1]) catch()
    select (for item in boneArray collect item[2])
    for d in selectedDummies do try(delete d) catch()
    messageBox "GTA3D PED bones created!" title:"Success"
    true
)

fn creategtasaskel = createGTASASkeleton_Adaptive

fn skinHasBoneByNode skinMod boneNode =
(
    local numBones = skinOps.GetNumberBones skinMod
    for i = 1 to numBones do if skinOps.GetBoneNode skinMod i == boneNode then return true
    false
)

fn skinSelectedMeshAddBonesAndVoxelWeights origMesh =
(
    select origMesh
    if selection.count != 1 then (messageBox "Select a single mesh (Editable_Mesh or Editable_Poly) to skin." title:"Error"; return false)
    local obj = selection[1]
    if not isMeshObject obj then (messageBox "Selected object is not a mesh." title:"Error"; return false)
    if not (isKindOf obj Editable_Poly) do (safeConvertSelectionToPoly(); obj = selection[1])
    local voxelMode = 0
    local voxelFalloff = 0.4
    local voxelMaxInfluence = 4
    local voxelMaxRes = 512
    local voxelUseWinding = true
    local voxelEnvelopeOff = false
    local existingSkinMod
    for m in obj.modifiers do if classof m == Skin do (existingSkinMod = m; exit)
    if existingSkinMod != undefined do (deleteModifier obj existingSkinMod)
    local boneNodesOrdered = #()
    for n in gtaSABoneNames do (
        local node = getNodeByName n
        if node != undefined and isValidBoneNode node do append boneNodesOrdered node
    )
    if boneNodesOrdered.count == 0 then (messageBox "No GTA:SA bones found in the scene. Create bones first!" title:"Error"; return false)
    local skinMod
    for m in obj.modifiers where classof m == Skin do skinMod = m
    if skinMod == undefined then (skinMod = Skin(); addModifier obj skinMod)
    for b in boneNodesOrdered where b != undefined do (
        if b.name != "Root" and not (skinHasBoneByNode skinMod b) do skinOps.AddBone skinMod b 1
    )
    if skinOps.GetNumberBones skinMod == 0 then (messageBox "No bones were added to the Skin modifier." title:"Error"; return false)
    skinMod.initialStaticEnvelope = false
    skinMod.initialOuterEnvelopePercent = 3.5
    skinMod.initialInnerEnvelopePercent = 0.75
    if isProperty skinOps #voxelWeighting and (skinOps.voxelWeighting != undefined) then (
        try (
            skinOps.voxelWeighting skinMod voxelMode voxelFalloff voxelMaxInfluence voxelMaxRes voxelUseWinding voxelEnvelopeOff
            messageBox "GTA 3D PED skin rigged!" title:"Success"
            true
        ) catch (
            messageBox "Error applying voxel weighting." title:"Voxel Weighting Error"
            false
        )
    ) else (
        messageBox "Voxel weighting is not available. Skin modifier added, but no auto weighting." title:"Warning"
        true
    )
)

rollout gtaSA_tools "GTA3D PED Auto Rig" width:180
(
    button btn_autoRig "Auto Rig Selected Mesh" pos:[10,10] width:160 height:28
    label lbl_note "Select mesh, then click." pos:[10,44] width:160 height:14

    on btn_autoRig pressed do (
        if selection.count != 1 then (messageBox "Select a single mesh before running Auto Rig." title:"Selection Required"; return false)
        local origMesh = selection[1]
        createGTASADummySkeleton_Accurate()
        local allDummies = for obj in objects where (isKindOf obj Dummy and obj.boneEnable) collect obj
        select allDummies
        createGTASASkeleton_Adaptive()
        select origMesh
        skinSelectedMeshAddBonesAndVoxelWeights origMesh
        true
    )
)

createDialog gtaSA_tools style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)
