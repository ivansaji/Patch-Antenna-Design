'# MWS Version: Version 2019.0 - Sep 20 2018 - ACIS 28.0.2 -

'# length = mm
'# frequency = GHz
'# time = ms
'# frequency range: fmin = 2.3 fmax = 2.6
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


'@ define material: Copper (pure)

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Material
     .Reset
     .Name "Copper (pure)"
     .Folder ""
.FrqType "all"
.Type "Lossy metal"
.MaterialUnit "Frequency", "GHz"
.MaterialUnit "Geometry", "mm"
.MaterialUnit "Time", "s"
.MaterialUnit "Temperature", "Kelvin"
.Mu "1.0"
.Sigma "5.96e+007"
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
.ReferenceCoordSystem "Global"
.CoordSystemType "Cartesian"
.NLAnisotropy "False"
.NLAStackingFactor "1"
.NLADirectionX "1"
.NLADirectionY "0"
.NLADirectionZ "0"
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1"
.Mu "1.0"
.Kappa "5.96e+007"
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
.Colour "1", "1", "0"
.Wireframe "False"
.Reflection "False"
.Allowoutline "True"
.Transparentoutline "False"
.Transparency "0"
.Create
End With 


'@ new component: component1

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Component.New "component1" 


'@ define cylinder: component1:CYlinder

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Cylinder 
     .Reset 
     .Name "CYlinder" 
     .Component "component1" 
     .Material "Copper (pure)" 
     .OuterRadius "30" 
     .InnerRadius "0.0" 
     .Axis "z" 
     .Zrange "1", "0" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With 


'@ execute macro: Construct\Coils\3D Linear Helical Spiral

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
Dim scst_torrus_ri As Double, scst_torrus_ra As Double,cst_xxx As Double, scst_torrus_phi As Double, scst_torrus_h As Double
 Dim scst_torrus_N As Integer, cst_result As Integer,  sCurveName As String, scst_clock As Integer, cst_clock As Integer
 Dim cst_torrus_N As Double, cst_torrus_phi As Double, cst_torrus_h As Double, cst_torrus_ra As Double, cst_torrus_ri As Double
 Dim first As String,  seconditem As String,cName As String, clock_yes_no As Integer, cClock As Integer

cst_result = -1%
cName = "Linear_Spiral"

If (cst_result =0) Then Exit All   ' if cancel/help is clicked, exit all

MakeSureParameterExists(cName+"_cst_torrus_h",10)
MakeSureParameterExists(cName+"_cst_torrus_ra",5)
MakeSureParameterExists(cName+"_cst_torrus_ri",5)
MakeSureParameterExists(cName+"_cst_torrus_phi",30)
MakeSureParameterExists(cName+"_cst_torrus_N",10)
MakeSureParameterExists(cName+"_cst_torrus_orientation",0)

If (RestoreDoubleParameter(cName+"_cst_torrus_phi") <= 0) Then
	ReportWarningToWindow "Angle phi is not positive. Coil not constructed."
	Exit All
End If

 With Brick
		.Reset
		.Name "dummy_solid_trapez"
		.Component "Dummy_spiral_coil"
		.Material "PEC"
		.Xrange "0", cName+"_cst_torrus_h"
		.Yrange "0", cName+"_cst_torrus_ra"
		.Zrange "0", cName+"_cst_torrus_phi"
		.Create
	End With
	Component.Delete "Dummy_spiral_coil"



	cst_torrus_N= restoredoubleparameter (cName+"_cst_torrus_N")
	cst_torrus_h= restoredoubleparameter (cName+"_cst_torrus_h")
	cst_torrus_ra= restoredoubleparameter (cName+"_cst_torrus_ra")
	cst_torrus_ri= restoredoubleparameter (cName+"_cst_torrus_ri")
	cst_torrus_phi= restoredoubleparameter (cName+"_cst_torrus_phi")
	cst_clock = restoredoubleparameter (cName+"_cst_torrus_orientation")


 ' Begin construction

 clock_yes_no = CInt(cst_clock)

	On Error GoTo Curve_Exists
 	Curve.NewCurve "3D-Linear-Spiral"
 	Curve_Exists:
	On Error GoTo 0
 	sCurveName = cName '"3dpolygon_1"
 	With    Polygon3D
  		.Reset
  		.Name sCurveName
  		.Curve "3D-Linear-Spiral"
        ' the upper limit takes the numerical inaccuracies into account. The logic of the following loop is as follows:
        ' We go complete the number of turns the user has specified. If 360 modulo cst_torrus_phi is not equal to zero
        ' (which shouldn't be the case usually) we insert the last segment only if the overlap is less than half the length
        ' of the segment.
        	.setinterpolation "Spline"
  		For cst_xxx = 0  To    cst_torrus_N *2*Pi+(cst_torrus_phi*pi/180)/2 STEP  cst_torrus_phi*pi/180
  			If clock_yes_no = 1 Then
	 			.Point cst_torrus_ra*Sin(cst_xxx), cst_torrus_ri*Cos(cst_xxx) , cst_torrus_h*cst_xxx/(2*pi* cst_torrus_N)
	 		Else
	 			.Point -cst_torrus_ra*Sin(cst_xxx), cst_torrus_ri*Cos(cst_xxx) , cst_torrus_h*cst_xxx/(2*pi* cst_torrus_N)
	 		End If
  		Next cst_xxx
  		.Create
 	End With


'@ transform curve: mirror 3D-Linear-Spiral

'[VERSION]2019.0|28.0.2|20180920[/VERSION]
With Transform 
     .Reset 
     .Name "3D-Linear-Spiral" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .PlaneNormal "30", "50", "50" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Transform "Curve", "Mirror" 
End With 


