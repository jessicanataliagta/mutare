v0.2.
Added VC skel data support.
some bug fixes (SA skel data now works on SA ragdoll mod).

# **GTA PED Skeleton Tools - Feature Summary**

## **🎮 Multi-Game Support**
- **GTA: San Andreas** and **GTA: Vice City** bone data compatibility
- **Auto-detection** of loaded game data (32 bones for SA, 24 bones for VC)
- **Unified workflow** for both games using the same interface

## **📁 External Data Loading**
- **Manual loading** of `.ms` data scripts via file browser
- **Smart caching prevention** - clears old data before loading new files
- **Real-time status display** showing current game and bone count
- **Error handling** with detailed feedback

## **🦴 Automated Skeleton Creation**
- **One-click bone creation** - "Create Bones" button handles entire workflow:
  1. Creates dummy skeleton with correct positions/rotations
  2. Auto-selects all dummies
  3. Converts to bones with proper hierarchy
  4. Cleans up temporary dummies
- **Tag preservation** - maintains bone IDs, child numbers, and fakeBiped flags
- **Proper bone sizing** and wireframe colors

## **🎨 Advanced Skinning**
- **Automatic mesh skinning** with bone attachment
- **Voxel weighting support** for automatic weight calculation
- **Smart bone filtering** (excludes Root bone from skinning)
- **Mesh conversion** to Editable_Poly if needed
- **Envelope configuration** with optimized settings

## **🔧 Technical Features**
- **Dictionary-based lookups** for fast bone data access
- **Memory management** with garbage collection
- **Validation checks** for bone nodes and data integrity
- **Cross-compatible** with 3ds Max 2017+

## **🎯 Compact UI**
- **240px width** - minimal screen footprint
- **4 main controls**: Load Data, Status, Create Bones, Skin Mesh
- **Context-sensitive buttons** - enabled/disabled based on data state
- **Clean, modern design** without visual clutter

## **⚡ Workflow Benefits**
- **Eliminates manual bone placement** - uses reference data for accuracy
- **Supports modding workflows** - easy switching between game datasets
- **Reduces setup time** from hours to minutes
- **Professional bone hierarchies** with correct naming and relationships

**Perfect for**: GTA modders, 3D artists working with game assets, anyone needing accurate GTA character skeletons in 3ds Max.


Zeneric powered by AI.