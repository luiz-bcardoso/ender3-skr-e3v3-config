; Ender 3 Custom Start G-code - Anti-Ooze & CR Touch optimized

G90 ; Use absolute coordinates
G92 E0 ; Reset Extruder

; --- PRE-HEAT PHASE ---
; Start heating bed and nozzle simultaneously to save time
M140 S{material_bed_temperature_layer_0} ; Set Bed Target (Do not wait)
M104 S150 ; Set Nozzle to 150C (Do not wait) - Ooze prevention temp

; Wait for Bed to stabilize (Crucial for CR Touch accuracy due to expansion)
M190 S{material_bed_temperature_layer_0} 
; Wait for Nozzle to reach 150C
M109 S150 

; --- HOMING & LEVELING ---
G28 ; Home all axes
G29 ; Auto Bed Leveling (25 points)
M420 S1 Z10 ; Force-enable leveling and fade out correction over 10mm

; --- FINAL HEATING ---
; Move to the front left corner to heat up safely (avoids dripping on the print area)
G1 X0.1 Y20 Z10.0 F5000.0 

; Heat Nozzle to final print temperature
M109 S{material_print_temperature_layer_0}

; --- PURGE SEQUENCE ---
G92 E0 ; Reset Extruder
G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G1 X0.1 Y20 Z0.3 F5000.0 ; Move to start position
G1 X0.1 Y200.0 Z0.3 F1500.0 E15 ; Draw the first line
G1 X0.4 Y200.0 Z0.3 F5000.0 ; Move to side a little
G1 X0.4 Y20 Z0.3 F1500.0 E30 ; Draw the second line

G92 E0 ; Reset Extruder
G1 Z2.0 F3000 ; Move Z Axis up little to prevent scratching of Heat Bed
G1 X5 Y20 Z0.3 F5000.0 ; Move over to prevent blob squish
