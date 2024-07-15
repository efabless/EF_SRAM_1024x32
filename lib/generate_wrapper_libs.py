# SPDX-FileCopyrightText: 2024 Efabless Corporation and its Licensors, All Rights Reserved
# ========================================================================================
#
#  This software is protected by copyright and other intellectual property
#  rights. Therefore, reproduction, modification, translation, compilation, or
#  representation of this software in any manner other than expressly permitted
#  is strictly prohibited.
#
#  You may access and use this software, solely as provided, solely for the purpose of
#  integrating into semiconductor chip designs that you create as a part of the
#  of Efabless shuttles or Efabless managed production programs (and solely for use and
#  fabrication as a part of Efabless production purposes and for no other purpose.  You
#  may not modify or convey the software for any other purpose.
#
#  Disclaimer: EFABLESS AND ITS LICENSORS MAKE NO WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, WITH REGARD TO THIS MATERIAL, AND EXPRESSLY DISCLAIM
#  ANY AND ALL WARRANTIES OF ANY KIND INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE. Efabless reserves the right to make changes without further
#  notice to the materials described herein. Neither Efabless nor any of its licensors
#  assume any liability arising out of the application or use of any product or
#  circuit described herein. Efabless's products described herein are
#  not authorized for use as components in life-support devices.
#
#  If you have a separate agreement with Efabless pertaining to the use of this software
#  then that agreement shall control.

import re
import os
import glob

ip = "EF_SRAM_1024x32"
__dir__ = os.path.dirname(os.path.abspath(__file__))

library_rx = re.compile(r"library\s+\(\s*(\w+)\s*\)")
cell_rx = re.compile(r"cell\s+\(\s*(\w+)\s*\)")

for lib_path in glob.glob(os.path.join(__dir__, f"{ip}_*.lib")):
    if "wrapper" in lib_path:
        continue
    corner = os.path.basename(lib_path)[len(ip) + 1 : -4]
    new_library = f"{ip}_wrapper_{corner}"
    with open(
        os.path.join(__dir__, f"{new_library}.lib"),
        "w",
        encoding="utf8",
    ) as outfile:
        with open(lib_path, encoding="utf8") as infile:
            for line in infile:
                if match := library_rx.search(line):
                    outfile.write(library_rx.sub(f"library ({new_library})", line))
                elif match := cell_rx.search(line):
                    outfile.write(cell_rx.sub(f"cell ({ip}_wrapper)", line))
                else:
                    outfile.write(line)
