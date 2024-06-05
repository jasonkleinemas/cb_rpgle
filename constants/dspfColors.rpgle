**Free

/if not defined(displayColors_d)
/define displayColors_d

  // Just copy to a field to chage the color.
  // cOLOR(BLU):
  dcl-c cBlue                     X'3A';
  dcl-c cBlue_ri                  X'3B'; // Reverse Image
  dcl-c cBlue_ul                  X'3E'; // Under Line
  // cOLOR(GRN):
  dcl-c cGreen                    X'20';
  dcl-c cGreen_ri                 X'21'; // Reverse Image
  dcl-c cGreen_ul                 X'24'; // Under Line
  dcl-c cGreen_ul_ri              X'24'; // Under Line Rev Img
  // cOLOR(PNK):
  dcl-c cPink                     X'38';
  dcl-c cPink_ri                  X'39'; // Reverse Image
  dcl-c cPink_ul                  X'3C'; // Under Line
  dcl-c cPink_ri_ul               X'3D'; // Under Line Rev Img
  // cOLOR(RED):
  dcl-c cRed                      X'28';
  dcl-c cRed_BLNK                 X'2A'; // Blink
  dcl-c cRed_BLNK_ri              X'2B'; // Blink Rev Img
  dcl-c cRed_BLNK_ul              X'2E'; // Blink Under Line
  dcl-c cRed_ri                   X'29'; // Rev Img
  dcl-c cRed_ul                   X'2C'; // Under Line
  dcl-c cRed_ri_ul                X'2D'; // Rev Img Inder Line
  // cOLOR(TRQ):
  dcl-c cTurquoise                X'30';
  dcl-c cTurquoise_ri             X'31'; // Reverse Image
  dcl-c cTurquoise_ul             X'34'; // Under Line
  dcl-c cTurquoise_ulri           X'34'; // Under Line Rev Img
  // cOLOR(YLW):
  dcl-c cYellow                   X'32';
  dcl-c cYellow_ri                X'33'; // Reverse Image
  dcl-c cYellow_ul                X'36'; // Under Line
  // cOLOR(WHT):
  dcl-c cWhite                    X'22';
  dcl-c cWhite_ri                 X'23'; // Reverse Image
  dcl-c cWhite_ul                 X'26'; // Under Line

/endif
