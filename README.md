# Paging Prevent to SSD
Windows batch script that sounds a BEEP when free RAM is lower then 16% of total (avoiding paging, that decrease SSD lifespan).

Runs hidden with a VBS script: just adjust path and run vbs file that hide the console window.

Why avoiding paging prevents SSD lifespan to decrease? A: Because every writing process in SSD spend his lifespan proportionally to the size of the data, and a lot of data is written when Windows starts writing to pagefile c:\pagefile.sys, and Windows starts paging when RAM is running low.
