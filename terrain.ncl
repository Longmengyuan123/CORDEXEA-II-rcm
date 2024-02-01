load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
;This file still has to be loaded manually 

begin 

f11   = addfile("/raid64/keyu/model_data/CORDEX-EA-II-1988_2010_COAWST_atm_25km_ocn9km/atmoutput/wrfout_d01_1990-06-30_00:00:00.nc4", "r")
print(f11)

terrain1  = wrf_user_getvar(f11, "ter", -1)
lat = f11->XLAT(0,5:246,5:378)
lon = f11->XLONG(0,5:246,5:378)
printVarSummary(lat)

data1 = terrain1(0,5:246,5:378)
data1@lat2d = lat
data1@lon2d = lon

;--------------------------------------------------
; create plot
;--------------------------------------------------
wks_type = "png"
wks_type@wkWidth = 2500 ;设置分辨率
wks_type@wkHeight = 2500
wks1  = gsn_open_wks (wks_type, "terrain_map")  ; open workstation

res                        = True               ; plot mods desired
;  res@gsnDraw                = False
;  res@gsnFrame               = False
  res@gsnAddCyclic           = False
  res@cnFillOn               = True               ; color fill  
  res@cnFillPalette          = "MPL_terrain"  ;"BlAqGrYeOrRe"         ; subset the color map
  res@cnLinesOn              = False              ; no contour lines
  res@cnLineLabelsOn         = False              ; no contour labels
  res@cnInfoLabelOn          = False              ; no contour info label
  
;  res@lbLabelBarOn           = False
  res@pmLabelBarOrthogonalPosF = 0.20
  res@pmLabelBarWidthF         = 0.8
  res@pmLabelBarHeightF        = 0.10
  res@lbTitleOn             = True
  res@lbTitleString         = "m"
  res@lbTitlePosition       = "Right"
  res@lbLabelFontHeightF    = 0.017
  res@lbTitleFontHeightF    = 0.019
  ; res@lbTitleOffsetF        = 0.006
  res@lbTitleDirection   = "Across"
  res@lbTitleJust        = "CenterLeft"

  res@tmYLLabelFontHeightF   = 0.020
  res@tmXBLabelFontHeightF   = 0.020

 ; res@mpDataBaseVersion      = "MediumRes"        ; better map outlines
  res@pmTickMarkDisplayMode  = "Always"           ; turn on tickmarks
  
  ;res@gsnAddCyclic           = False              ; regional data
  res@mpLimitMode            = "LatLon"           ; choose region of map
  res@mpMinLatF              = -5  ;min(HFX0@laHFXd)-1     ; Add a little bit of
  res@mpMinLonF              = 40  ;min(HFX0@lon2d)-1     ; a margin around
  res@mpMaxLatF              = 70  ;max(HFX0@laHFXd)+1     ; the plot.
  res@mpMaxLonF              = 190 ; max(HFX0@lon2d)+1
   res@mpCenterLonF           = 115
  
  res@mpOutlineOn=True
  res@mpOutlineBoundarySets = "Geophysical"
  res@mpGridAndLimbOn=False
  res@mpGeophysicalLineColor = "black"
  res@mpGeophysicalLineThicknessF=1.0
  res@mpNationalLineColor = "black" 
  res@mpProvincialLineColor = "black"
  res@mpProvincialLineThicknessF = 1.0
  res@mpDataBaseVersion = "MediumRes"  
  res@mpDataSetName = "Earth..4"
  res@mpAreaMaskingOn = False
  res@mpMaskAreaSpecifiers = (/"China"/)
  res@mpOutlineSpecifiers = (/"China","China:Provinces"/)
  res@cnLevelSelectionMode   = "ManualLevels"
  res@cnMinLevelValF         = 20.
  res@cnMaxLevelValF         = 5000.
  res@cnLevelSpacingF        = 200.

  plot1 = gsn_csm_contour_map(wks1,data1,res)     ; Draw contours over a map.
 

end 