----------zeneric power by ai bots
global gtaSABonePositions
global gtaSABoneRotations
global gtaSABoneHierarchy
global gtaSABoneNames
global gtaSATagData

fn initBoneData = (
    -- Clear arrays
    gtaSABonePositions = #()
    gtaSABoneRotations = #()
    gtaSABoneHierarchy = #()
    gtaSATagData = #()

    gtaSABonePositions = #(
        #("Root", [0.0, 0.0, 0.0]),
        #("Pelvis", [-0.003663, 0.020705, 0.0]),
        #("Belly", [0.000714986, 0.140938, 0.100812]),
        #("Spine", [0.001131, 0.0711136, -0.00577686]),
        #("Spine1", [0.00113099, 0.0711054, 0.276242]),
        #("Neck", [0.00113098, 0.0710003, 0.548069]),
        #("Head", [0.00113087, 0.0294664, 0.687987]),
        #("Jaw", [0.000714869, 0.00683095, 0.681905]),
        #("L Brow", [0.0250642, 0.0277662, 0.777308]),
        #("R Brow", [-0.0191032, 0.0280554, 0.776743]),
        #("Bip01 L Clavicle", [0.032962, 0.0709069, 0.548036]),
        #("L UpperArm", [0.198149, 0.07379, 0.525049]),
        #("L ForeArm", [0.300369, 0.0758676, 0.248283]),
        #("L Hand", [0.397764, 0.0737856, -0.0154139]),
        #("L Finger", [0.434625, 0.0804393, -0.0954584]),
        #("L Finger01", [0.438702, 0.0848829, -0.157321]),
        #("L breast", [0.102181, 0.139457, 0.413274]),
        #("Bip01 R Clavicle", [-0.0307, 0.0709069, 0.548036]),
        #("R UpperArm", [-0.195887, 0.07379, 0.525049]),
        #("R ForeArm", [-0.302444, 0.0758799, 0.249923]),
        #("R Hand", [-0.403972, 0.0738097, -0.0122105]),
        #("R Finger", [-0.442086, 0.0804671, -0.0916656]),
        #("R Finger01", [-0.447134, 0.0849133, -0.153457]),
        #("R breast", [-0.0984546, 0.139457, 0.415739]),
        #("L Thigh", [0.116838, 0.0207051, 1.33142e-07]),
        #("L Calf", [0.149721, 0.0694108, -0.461523]),
        #("L Foot", [0.178797, 0.1173, -0.869348]),
        #("L Toe0", [0.178797, -0.0320077, -0.999035]),
        #("R Thigh", [-0.124164, 0.0207048, 0.0]),
        #("R Calf", [-0.15706, 0.0678042, -0.46169]),
        #("R Foot", [-0.186147, 0.114274, -0.869678]),
        #("R Toe0", [-0.186147, -0.0350336, -0.999365])
    )

    -- Define bone rotations
    gtaSABoneRotations = #(
        #("Root", quat 0 0 1 1),
        #("Pelvis", quat 0.707107 7.54522e-07 0.707106 4.57902e-07),
        #("Belly", quat -0.5 -0.5 -0.5 0.5),
        #("Spine", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("Spine1", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("Neck", quat 0.69976 -0.101668 0.69976 0.101666),
        #("Head", quat 0.706907 -0.0168155 0.706907 0.0168136),
        #("Jaw", quat 0.387698 -0.591346 0.387699 0.591346),
        #("L Brow", quat 0.549406 -0.469667 0.450093 0.524387),
        #("R Brow", quat 0.461751 -0.518947 0.539025 0.476374),
        #("Bip01 L Clavicle", quat 0.000602537 -0.0690666 -0.00870508 0.997574),
        #("L UpperArm", quat -0.00172047 -0.571633 -0.00309243 0.820502),
        #("L ForeArm", quat 0.0024091 -0.571631 0.00283498 0.820503),
        #("L Hand", quat 0.579437 -0.359463 -0.402786 0.610575),
        #("L Finger", quat 0.504894 -0.458486 -0.506951 0.527136),
        #("L Finger01", quat -0.322432 0.60097 0.654083 -0.327181),
        #("L breast", quat 0.479924 -0.378347 0.583498 0.534842),
        #("Bip01 R Clavicle", quat 0.00870505 0.997574 -0.000602715 -0.0690672),
        #("R UpperArm", quat -0.0031226 -0.824968 -0.00170867 0.565168),
        #("R ForeArm", quat 0.00283658 -0.824969 0.00237413 0.565166),
        #("R Hand", quat 0.398232 0.61339 -0.582575 -0.354642),
        #("R Finger", quat 0.502981 0.530729 -0.508855 -0.454317),
        #("R Finger01", quat -0.651543 -0.331896 0.32756 0.598365),
        #("R breast", quat 0.538775 -0.510408 0.507165 0.438165),
        #("L Thigh", quat 0.73073 0.0371183 -0.680649 0.037053),
        #("L Calf", quat 0.7305 0.0413992 -0.68042 0.0410406),
        #("L Foot", quat 0.707107 0.0 -0.707107 0.0),
        #("L Toe0", quat 0.5 -0.5 -0.5 -0.5),
        #("R Thigh", quat -0.680707 -0.0358724 0.730798 -0.0358496),
        #("R Calf", quat -0.680485 -0.0398602 0.730576 -0.040131),
        #("R Foot", quat -0.707107 0.0 0.707107 0.0),
        #("R Toe0", quat 0.5 -0.5 -0.5 -0.5)
    )

    -- Define bone hierarchy (EDITED AS REQUESTED)
    gtaSABoneHierarchy = #(
        #("Root", #()),
        #("Pelvis", #("Root")),
        #("R Thigh", #("Pelvis")),
        #("R Calf", #("R Thigh")),
        #("R Foot", #("R Calf")),
        #("R Toe0", #("R Foot")),
        #("L Thigh", #("Pelvis")),
        #("L Calf", #("L Thigh")),
        #("L Foot", #("L Calf")),
        #("L Toe0", #("L Foot")),
        #("Spine", #("Pelvis")),
        #("Belly", #("Spine")),
        #("Spine1", #("Belly")),
        #("R breast", #("Spine1")),
        #("L breast", #("Spine1")),
        #("Neck", #("Spine1")),
        #("Bip01 R Clavicle", #("Neck")),
        #("R UpperArm", #("Bip01 R Clavicle")),
        #("R ForeArm", #("R UpperArm")),
        #("R Hand", #("R ForeArm")),
        #("R Finger", #("R Hand")),
        #("R Finger01", #("R Finger")),
        #("Bip01 L Clavicle", #("Neck")),
        #("L UpperArm", #("Bip01 L Clavicle")),
        #("L ForeArm", #("L UpperArm")),
        #("L Hand", #("L ForeArm")),
        #("L Finger", #("L Hand")),
        #("L Finger01", #("L Finger")),
        #("Head", #("Neck")),
        #("R Brow", #("Head")),
        #("L Brow", #("Head")),
        #("Jaw", #("Head"))
    )

    -- Define bone names
    gtaSABoneNames = #(
        "Pelvis",
        "R Thigh",
        "R Calf",
        "R Foot",
        "R Toe0",
        "L Thigh",
        "L Calf",
        "L Foot",
        "L Toe0",
        "Spine",
        "Belly",
        "Spine1",
        "R breast",
        "L breast",
        "Neck",
        "Bip01 R Clavicle",
        "R UpperArm",
        "R ForeArm",
        "R Hand",
        "R Finger",
        "R Finger01",
        "Bip01 L Clavicle",
        "L UpperArm",
        "L ForeArm",
        "L Hand",
        "L Finger",
        "L Finger01",
        "Head",
        "R Brow",
        "L Brow",
        "Jaw"
    )

    -- Define tag data (NEW DATA)
    gtaSATagData = #(
        #("Root", 0, undefined, true),
        #("Pelvis", 1, undefined, undefined),
        #("R Thigh", 51, 2, undefined),
        #("R Calf", 52, undefined, undefined),
        #("R Foot", 53, undefined, undefined),
        #("R Toe0", 54, undefined, undefined),
        #("L Thigh", 41, 1, undefined),
        #("L Calf", 42, undefined, undefined),
        #("L Foot", 43, undefined, undefined),
        #("L Toe0", 44, undefined, undefined),
        #("Spine", 2, 0, undefined),
        #("Belly", 201, 1, undefined),
        #("Spine1", 3, 0, undefined),
        #("R breast", 301, 2, undefined),
        #("L breast", 302, 1, undefined),
        #("Neck", 4, 0, undefined),
        #("Bip01 R Clavicle", 21, 2, undefined),
        #("R UpperArm", 22, undefined, undefined),
        #("R ForeArm", 23, undefined, undefined),
        #("R Hand", 24, undefined, undefined),
        #("R Finger", 25, undefined, undefined),
        #("R Finger01", 26, undefined, undefined),
        #("Bip01 L Clavicle", 31, 1, undefined),
        #("L UpperArm", 32, undefined, undefined),
        #("L ForeArm", 33, undefined, undefined),
        #("L Hand", 34, undefined, undefined),
        #("L Finger", 35, undefined, undefined),
        #("L Finger01", 36, undefined, undefined),
        #("Head", 5, 0, undefined),
        #("R Brow", 7, 2, undefined),
        #("L Brow", 6, 1, undefined),
        #("Jaw", 8, 0, undefined)
    )
)

initBoneData()