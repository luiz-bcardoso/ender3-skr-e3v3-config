; Ender 3 Custom Start G-code - SKR Mini E3 V3 (Silicone + Saved Mesh)
; Optimized for speed: Loads mesh instantly instead of probing

G90 ; Use absolute coordinates
G92 E0 ; Reset Extruder

; --- PHASE 1: PARALLEL PRE-HEAT ---
; Heat Bed to print temp and Nozzle to Standby temp simultaneously
M140 S{material_bed_temperature_layer_0} ; Set Bed Target (Do not wait)
M104 S{material_standby_temperature} ; Set Nozzle to Standby (e.g., 150C)

; Wait for Bed to fully stabilize (Critical for PEI expansion)
M190 S{material_bed_temperature_layer_0} 

; Ensure Nozzle is at Standby before moving
M109 S{material_standby_temperature} 

; --- PHASE 2: HOMING & LOADING MESH ---
G28 ; Home all axes

; LOAD THE SAVED MESH (This replaces G29)
; M420 S1: Enable Bed Leveling using the mesh saved in memory
; Z10: Fade out leveling correction over 10mm height (better for dimensional accuracy)
M420 S1 Z10 

; --- PHASE 3: FINAL HEATING ---
; Move to "Safe Park" position (front left)
G1 X0.1 Y10 Z10.0 F5000.0 

; Heat Nozzle to printing temperature
M109 S{material_print_temperature_layer_0}

; --- PHASE 4: PURGE SEQUENCE ---
G92 E0 ; Reset Extruder
G1 Z2.0 F3000 ; Move Z Axis up slightly
G1 X0.1 Y20 Z0.3 F5000.0 ; Move to start position
G1 X0.1 Y200.0 Z0.3 F1500.0 E15 ; Draw first line
G1 X0.4 Y200.0 Z0.3 F5000.0 ; Shift side
G1 X0.4 Y20 Z0.3 F1500.0 E30 ; Draw second line
G92 E0 ; Reset Extruder
G1 Z2.0 F3000 ; Lift Z
G1 X5 Y20 Z0.3 F5000.0 ; Move away quickly
