global gtaVCBonePositions
global gtaVCBoneRotations
global gtaVCBoneHierarchy
global gtaVCBoneNames
global gtaVCTagData

fn initVCBoneData = (
    -- Clear arrays
    gtaVCBonePositions = #()
    gtaVCBoneRotations = #()
    gtaVCBoneHierarchy = #()
    gtaVCTagData = #()

    gtaVCBonePositions = #(
        #("Root", [0.0,0.0,0.0]),
        #("Pelvis", [-0.00366379,0.0207143,0.0]),
        #("Spine", [0.000410208,0.0711472,-0.00632784]),
        #("R Thigh", [-0.106074,0.0207143,0.0]),
        #("R Calf", [-0.145917,0.0193681,-0.455433]),
        #("R Foot", [-0.181559,0.0651566,-0.862978]),
        #("R Toe0", [-0.181559,-0.127419,-0.977637]),
        #("L Thigh", [0.0987462,0.0207143,0.0]),
        #("L Calf", [0.13859,0.0193681,-0.455433]),
        #("L Foot", [0.174234,0.0650542,-0.863]),
        #("L Toe0", [0.174234,-0.133228,-0.981056]),
        #("Spine1", [0.000410199,0.0711147,0.306235]),
        #("Neck", [0.000410191,0.0710096,0.578052]),
        #("Bip01 R Clavicle", [-0.0314209,0.0709162,0.578029]),
        #("R UpperArm", [-0.205254,0.070916,0.578029]),
        #("R Forearm", [-0.496668,0.117072,0.578029]),
        #("R Hand", [-0.779369,0.0722977,0.578029]),
        #("R Finger", [-0.866528,0.0584935,0.57803]),
        #("Bip01 L Clavicle", [0.0322413,0.0709162,0.578029]),
        #("L UpperArm", [0.206074,0.070916,0.578029]),
        #("L Forearm", [0.497488,0.117072,0.578029]),
        #("L Hand", [0.780189,0.0722979,0.578029]),
        #("L Finger", [0.867476,0.058473,0.578029]),
        #("Head", [0.000410189,0.0424379,0.717916])
    )

    gtaVCBoneRotations = #(
        #("Root", quat -1.68587e-07 -1.68587e-07 0.707107 0.707107),
        #("Pelvis", quat 0.707107 7.54522e-07 0.707106 4.57902e-07),
        #("Spine", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("R Thigh", quat -0.675591 0.00108822 0.737275 0.00100004),
        #("R Calf", quat -0.674548 -0.0375384 0.736126 -0.041153),
        #("R Foot", quat -0.707107 -1.57035e-07 0.707107 0.0),
        #("R Toe0", quat -0.5 0.5 0.5 0.5),
        #("L Thigh", quat 0.737275 -0.000999982 -0.675591 -0.00108826),
        #("L Calf", quat 0.736132 0.04106 -0.674553 0.0374528),
        #("L Foot", quat -0.707107 0.0 0.707107 0.0),
        #("L Toe0", quat 0.5 -0.5 -0.5 -0.5),
        #("Spine1", quat 0.707107 -0.000282542 0.707107 0.00028072),
        #("Neck", quat 0.703521 -0.0711247 0.703521 0.0711229),
        #("Bip01 R Clavicle", quat 1.22499e-07 0.99997 -0.00768084 -1.15209e-06),
        #("R UpperArm", quat 0.0784604 0.996917 2.98478e-07 0.0),
        #("R Forearm", quat -0.0784575 0.996918 3.02682e-07 0.0),
        #("R Hand", quat -0.0554995 0.705208 -0.704647 -0.0554538),
        #("R Finger", quat 0.408104 0.577452 -0.506504 -0.49341),
        #("Bip01 L Clavicle", quat -0.0106448 4.82251e-07 6.91658e-07 0.999943),
        #("L UpperArm", quat 0.0 1.22672e-07 -0.0784606 0.996917),
        #("L Forearm", quat -1.31255e-07 0.0 0.0784574 0.996917),
        #("L Hand", quat 0.704646 -0.0554573 0.0555003 0.705208),
        #("L Finger", quat 0.506502 -0.493413 -0.408104 0.577452),
        #("Head", quat 0.707107 -4.614e-07 0.707107 -1.2938e-06)
    )

    gtaVCBoneHierarchy = #(
        #("Root", #()),
        #("Pelvis", #("Root")),
        #("Spine", #("Pelvis")),
        #("R Thigh", #("Spine")),
        #("R Calf", #("R Thigh")),
        #("R Foot", #("R Calf")),
        #("R Toe0", #("R Foot")),
        #("L Thigh", #("Spine")),
        #("L Calf", #("L Thigh")),
        #("L Foot", #("L Calf")),
        #("L Toe0", #("L Foot")),
        #("Spine1", #("Spine")),
        #("Neck", #("Spine1")),
        #("Bip01 R Clavicle", #("Neck")),
        #("R UpperArm", #("Bip01 R Clavicle")),
        #("R Forearm", #("R UpperArm")),
        #("R Hand", #("R Forearm")),
        #("R Finger", #("R Hand")),
        #("Bip01 L Clavicle", #("Neck")),
        #("L UpperArm", #("Bip01 L Clavicle")),
        #("L Forearm", #("L UpperArm")),
        #("L Hand", #("L Forearm")),
        #("L Finger", #("L Hand")),
        #("Head", #("Neck"))
    )

    gtaVCBoneNames = #(
        "Root",
        "Pelvis",
        "Spine",
        "R Thigh",
        "R Calf",
        "R Foot",
        "R Toe0",
        "L Thigh",
        "L Calf",
        "L Foot",
        "L Toe0",
        "Spine1",
        "Neck",
        "Bip01 R Clavicle",
        "R UpperArm",
        "R Forearm",
        "R Hand",
        "R Finger",
        "Bip01 L Clavicle",
        "L UpperArm",
        "L Forearm",
        "L Hand",
        "L Finger",
        "Head"
    )

    gtaVCTagData = #(
        #("Root", 0, undefined, true),
        #("Pelvis", 1, undefined, undefined),
        #("Spine", 2, 0, undefined),
        #("R Thigh", 51, 2, undefined),
        #("R Calf", 52, undefined, undefined),
        #("R Foot", 53, undefined, undefined),
        #("R Toe0", 54, undefined, undefined),
        #("L Thigh", 41, 1, undefined),
        #("L Calf", 42, undefined, undefined),
        #("L Foot", 43, undefined, undefined),
        #("L Toe0", 44, undefined, undefined),
        #("Spine1", 3, 0, undefined),
        #("Neck", 4, 0, undefined),
        #("Bip01 R Clavicle", 21, 2, undefined),
        #("R UpperArm", 22, undefined, undefined),
        #("R Forearm", 23, undefined, undefined),
        #("R Hand", 24, undefined, undefined),
        #("R Finger", 25, undefined, undefined),
        #("Bip01 L Clavicle", 31, 1, undefined),
        #("L UpperArm", 32, undefined, undefined),
        #("L Forearm", 33, undefined, undefined),
        #("L Hand", 34, undefined, undefined),
        #("L Finger", 35, undefined, undefined),
        #("Head", 5, 0, undefined)
    )
)

initVCBoneData() 