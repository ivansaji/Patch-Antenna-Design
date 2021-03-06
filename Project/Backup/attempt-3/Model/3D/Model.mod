'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ms
'# frequency range: fmin = 2.3 fmax = 2.6
'# created = '[VERSION]2019.0|28.0.2|20180920[/VERSION]


'@ use template: Final Project.cfg

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Celsius"
    .Time "ms"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With
ThermalSolver.AmbientTemperature "0"
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "2.3", "2.6"
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' optimize mesh settings for planar structures
With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With
' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)
MeshAdaption3D.SetAdaptionStrategy "Energy"
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With
'----------------------------------------------------------------------------
Dim sDefineAt As String
sDefineAt = "2.3;2.45;2.6"
Dim sDefineAtName As String
sDefineAtName = "2.3;2.45;2.6"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")
Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)
Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)
' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .MonitorValue  zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .MonitorValue  zz_val
    .Create
End With
' Define Power flow Monitors
With Monitor
    .Reset
    .Name "power ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerflow"
    .MonitorValue  zz_val
    .Create
End With
' Define Power loss Monitors
With Monitor
    .Reset
    .Name "loss ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerloss"
    .MonitorValue  zz_val
    .Create
End With
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .MonitorValue  zz_val
    .ExportFarfieldSource "False"
    .Create
End With
Next
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")
'----------------------------------------------------------------------------

'@ activate local coordinates

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.ActivateWCS "local"

'@ define material: FR-4 (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "FR-4 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "4.3"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.025"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.3"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ new component: component1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Component.New "component1"

'@ define cylinder: component1:solid1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "FR-4 (lossy)" 
     .OuterRadius "Rs" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "Hs" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:solid1", "1"

'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define material: Copper (annealed)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1"
.Mu "1.0"
.Kappa "5.8e+007"
.TanD "0.0"
.TanDFreq "0.0"
.TanDGiven "False"
.TanDModel "ConstTanD"
.KappaM "0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstTanD"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "Nth Order"
.DispersiveFittingSchemeMu "Nth Order"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.FrqType "all"
.Type "Lossy metal"
.SetMaterialUnit "GHz", "mm"
.Mu "1.0"
.Kappa "5.8e+007"
.Rho "8930.0"
.ThermalType "Normal"
.ThermalConductivity "401.0"
.HeatCapacity "0.39"
.MetabolicRate "0"
.BloodFlow "0"
.VoxelConvection "0"
.MechanicsType "Isotropic"
.YoungsModulus "120"
.PoissonsRatio "0.33"
.ThermalExpansionRate "17"
.Colour "1", "1", "0"
.Wireframe "False"
.Reflection "False"
.Allowoutline "True"
.Transparentoutline "False"
.Transparency "0"
.Create
End With

'@ define cylinder: component1:solid2

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "Tc" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:solid1", "3"

'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define cylinder: component1:solid3

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "r" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "Tc" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ rename block: component1:solid1 to: component1:fr4_substrate

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Rename "component1:solid1", "fr4_substrate"

'@ rename block: component1:solid2 to: component1:ground_plane

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Rename "component1:solid2", "ground_plane"

'@ rename block: component1:solid3 to: component1:circular_patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Rename "component1:solid3", "circular_patch"

'@ define material: FR-4 (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material 
     .Reset 
     .Name "FR-4 (lossy)"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.3"
     .HeatCapacity "0"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "4.4"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.025"
     .TanDFreq "10.0"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMu "False"
     .ConstTanDModelOrderMu "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMu "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define material colour: FR-4 (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material 
     .Name "FR-4 (lossy)"
     .Folder ""
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ set wcs properties

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With WCS
     .SetNormal "0", "0", "1"
     .SetOrigin "-6.6079840328093e-16", "0", "1.6"
     .SetUVector "1", "0", "0"
End With

'@ clear picks

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.ClearAllPicks

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:circular_patch", "3"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "Xf", "0.0", "0.0"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "-Xf", "0.0", "0.0"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "Xf", "0.0", "0.0"

'@ unpick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.UnpickFaceFromId "component1:circular_patch", "3"

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:ground_plane", "3"

'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "Xf", "0.0", "0.0"

'@ define cylinder: component1:solid1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "1.25" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "-Tc" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ rename block: component1:solid1 to: component1:groundcut

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Rename "component1:solid1", "groundcut"

'@ boolean subtract shapes: component1:ground_plane, component1:groundcut

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:ground_plane", "component1:groundcut"

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:circular_patch", "3"

'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "Xf", "0.0", "0.0"

'@ rotate wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.RotateWCS "w", "180"

'@ rotate wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.RotateWCS "w", "0"

'@ rotate wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.RotateWCS "w", "0"

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:circular_patch", "3"

'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ move wcs

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.MoveWCS "local", "-Xf", "0.0", "0.0"

'@ define cylinder: component1:pin

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "pin" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "pin_radius" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0.0001", "-pin_length" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:Via

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "Via" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "0.265" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "0", "-pin_length" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component1:coax

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "coax" 
     .Component "component1" 
     .Material "PEC" 
     .OuterRadius "total_cut_radius" 
     .InnerRadius "pin_radius" 
     .Axis "z" 
     .Zrange "-Tc-Tc-Hs", "-pin_length" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ define material: PTFE (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "PTFE (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.1"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0002"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "2200.0"
.ThermalType "Normal"
.ThermalConductivity "0.2"
.HeatCapacity "1.0"
.SetActiveMaterial "all"
.MechanicsType "Isotropic"
.YoungsModulus "0.5"
.PoissonsRatio "0.4"
.ThermalExpansionRate "140"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ change material and color: component1:coax to: PTFE (lossy)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.SetUseIndividualColor "component1:coax", 1
Solid.ChangeIndividualColor "component1:coax", "128", "128", "128"

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:coax", "2"

'@ define extrude: component1:outer_coating

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Extrude 
     .Reset 
     .Name "outer_coating" 
     .Component "component1" 
     .Material "PEC" 
     .Mode "Picks" 
     .Height "0.0" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With 

'@ delete shape: component1:outer_coating

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Delete "component1:outer_coating" 


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:coax", "2" 


'@ define extrude: component1:outer_coating

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Extrude 
     .Reset 
     .Name "outer_coating" 
     .Component "component1" 
     .Material "PEC" 
     .Mode "Picks" 
     .Height "0.0" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With 


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:fr4_substrate", "2" 


'@ define extrude: component1:solid1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Extrude 
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Mode "Picks" 
     .Height "Tc" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With 


'@ rename block: component1:solid1 to: component1:side_cover

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Rename "component1:solid1", "side_cover"


'@ define autointersection settings

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Solid
     .SetAutoIntersectionCheckElMag "True" 
     .SetAutoIntersectionCheckThermal "False" 
     .SetAutoIntersectionCheckMechanics "False" 
End With


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:Via", "1" 


'@ define port: 1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .Folder "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .TextMaxLimit "1" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "7.8163", "8.3463" 
     .Yrange "-0.265", "0.265" 
     .Zrange "-1.6", "-1.6" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With 


'@ define fieldsource monitor: field-source (f=2.45)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "field-source (f=2.45)" 
     .Domain "Frequency" 
     .FieldType "Fieldsource" 
     .Samples "1" 
     .MonitorValueRange "2.45", "2.45" 
     .InvertOrientation "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-16.986495", "16.986495", "-16.986495", "16.986495", "-1.6", "1.6351" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


'@ define monitor: surface-current (f=2.45)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "surface-current (f=2.45)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Surfacecurrent" 
     .MonitorValue "2.45" 
     .Create 
End With 


'@ define monitor: current (f=2.45)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "current (f=2.45)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Current" 
     .MonitorValue "2.45" 
     .Create 
End With 


'@ define monitor: e-energy (f=2.45)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-energy (f=2.45)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Eenergy" 
     .MonitorValue "2.45" 
     .Create 
End With 


'@ define monitor: h-energy (f=2.45)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-energy (f=2.45)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Henergy" 
     .MonitorValue "2.45" 
     .Create 
End With 


'@ define time domain solver parameters

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-30"
     .MeshAdaption "True"
     .AutoNormImpedance "True"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With


