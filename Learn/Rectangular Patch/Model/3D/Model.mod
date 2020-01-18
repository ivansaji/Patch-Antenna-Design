'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ms
'# frequency range: fmin = 1.7 fmax = 1.9
'# created = '[VERSION]2019.0|28.0.2|20180920[/VERSION]


'@ use template: Sunimon.cfg

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


'@ define brick: component1:substrate

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "substrate" 
     .Component "component1" 
     .Material "FR-4 (lossy)" 
     .Xrange "-W", "W" 
     .Yrange "-L", "L" 
     .Zrange "0", "h" 
     .Create
End With


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:substrate", "2" 


'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:substrate", "2" 


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


'@ define extrude: component1:ground_plane

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Extrude 
     .Reset 
     .Name "ground_plane" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Mode "Picks" 
     .Height "Mt" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .ClearPickedFace "True" 
     .Create 
End With 


'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:substrate", "1" 


'@ align wcs with face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
WCS.AlignWCSWithSelected "Face"


'@ define brick: component1:patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-W/2", "W/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "0", "Mt" 
     .Create
End With


'@ define material: Nickel

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "Nickel"
     .Folder ""
.FrqType "all"
.Type "Lossy metal"
.SetMaterialUnit "GHz", "mm"
.Mu "600"
.Kappa "1.44e7"
.Rho "8900"
.ThermalType "Normal"
.ThermalConductivity "91"
.HeatCapacity "0.45"
.MetabolicRate "0"
.BloodFlow "0"
.VoxelConvection "0"
.MechanicsType "Isotropic"
.YoungsModulus "207"
.PoissonsRatio "0.31"
.ThermalExpansionRate "13.1"
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "1"
.Mu "600"
.Kappa "1.44e7"
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
.Colour "0", "0.501961", "0.25098"
.Wireframe "False"
.Reflection "False"
.Allowoutline "True"
.Transparentoutline "False"
.Transparency "0"
.Create
End With 


'@ define brick: component1:EMPTY SPACE

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "EMPTY SPACE" 
     .Component "component1" 
     .Material "Nickel" 
     .Xrange "-(Wf/2+Gpf)", "(Wf/2+Gpf)" 
     .Yrange "L/2-Fi", "L/2" 
     .Zrange "0", "Mt" 
     .Create
End With


'@ boolean subtract shapes: component1:patch, component1:EMPTY SPACE

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Subtract "component1:patch", "component1:EMPTY SPACE" 

'@ define brick: component1:transmission patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Brick
     .Reset 
     .Name "transmission patch" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-Wf/2", "Wf/2" 
     .Yrange "L/2-Fi", "Lf+L/2-Fi" 
     .Zrange "0", "Mt" 
     .Create
End With


'@ boolean add shapes: component1:patch, component1:transmission patch

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solid.Add "component1:patch", "component1:transmission patch" 

'@ pick face

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Pick.PickFaceFromId "component1:patch", "5" 


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
     .TextMaxLimit "0" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-4.35", "4.35" 
     .Yrange "38", "38" 
     .Zrange "4.5", "4.6" 
     .XrangeAdd "3*Wf", "3*Wf" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "h+Mt", "4*h" 
     .SingleEnded "False" 
     .WaveguideMonitor "False" 
     .Create 
End With 


'@ define frequency range

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Solver.FrequencyRange "1.7", "1.9" 


'@ define monitor: h-field (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=1.8)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "1.8" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-51", "51", "-38", "38", "-0.1", "22.6" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With 


'@ define farfield monitor: farfield (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=1.8)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "1.8" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-51", "51", "-38", "38", "-0.1", "22.6" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .Create 
End With 


'@ delete monitor: e-field (f=2.3)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.3)" 


'@ delete monitors

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Monitor.Delete "e-field (f=2.45)" 
Monitor.Delete "e-field (f=2.6)" 
Monitor.Delete "farfield (f=2.3)" 
Monitor.Delete "farfield (f=2.45)" 
Monitor.Delete "farfield (f=2.6)" 
Monitor.Delete "h-field (f=2.3)" 
Monitor.Delete "h-field (f=2.45)" 
Monitor.Delete "h-field (f=2.6)" 
Monitor.Delete "loss (f=2.3)" 
Monitor.Delete "loss (f=2.45)" 
Monitor.Delete "loss (f=2.6)" 
Monitor.Delete "power (f=2.3)" 
Monitor.Delete "power (f=2.45)" 
Monitor.Delete "power (f=2.6)" 


'@ define monitor: e-field (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=1.8)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "1.8" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-51", "51", "-38", "38", "-0.1", "22.6" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With 


'@ define monitor: power (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "power (f=1.8)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerflow" 
     .MonitorValue "1.8" 
     .Create 
End With 


'@ define monitor: h-energy (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "h-energy (f=1.8)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Henergy" 
     .MonitorValue "1.8" 
     .Create 
End With 


'@ define monitor: loss (f=1.8)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Monitor 
     .Reset 
     .Name "loss (f=1.8)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Powerloss" 
     .MonitorValue "1.8" 
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


'@ set PBA version

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Discretizer.PBAVersion "2018092019"

'@ define time domain solver parameters

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral TLM"
     .SteadyStateLimit "-30"
     .StimulationPort "All"
     .StimulationMode "All"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .StoreTDResultsInCache  "False"
     .SuperimposePLWExcitation "False"
     .SParaSymmetry "False"
End With


