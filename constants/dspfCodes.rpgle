**Free

/if not defined(dspfCodes_d)
/define dspfCodes_d

  //     Used for the DSPATR(program-to-systam) feild attribute.

  dcl-c cNoAttributes              X'00'; // no attrs
  //
  // These amy only work if you dont defa col    lor in the dds.
  //
  dcl-c cNonProtect                X'20'; // non protect
  dcl-c cNormal                    X'20'; // Normal
  dcl-c cReverseImage              X'21'; // Reverse Image
  dcl-c cHiIntensity               X'22'; // Hi Intensity
  dcl-c cHighLirevimg              X'23'; // Hi Intensity Rev Img
  dcl-c cUnderline                 X'24'; // Underline
  dcl-c cUnderLineRevImg           X'25'; // Underline Rev Img
  dcl-c cUnderLineHiIntensity      X'26'; // Underline Hi Intens
  dcl-c cNonDisplay                X'27'; // non display
  dcl-c cBlink                     X'28'; // blink
  dcl-c cBlinkRevImg               X'29'; // blink Rev Img
  dcl-c cBlinkHiIntensity          X'2A'; // blink Hi Intens
  dcl-c cBlinkRevIntensity         X'2B'; // blink Rev Img Hi In
  dcl-c cBlinkUnderline            X'2C'; // blink Underline
  dcl-c cBlinkUnderlineRevImg      X'2D'; // blink Underline Rev
  dcl-c cBlinkUnderLineHiIntensity X'2E'; // blink Underline Hi
  dcl-c cNonDisplay2               X'2F';

  // RI=Reverse Image, HI=Hi Intensity, BL=blink, UL=Underline
  // ND=Non Display
  // Protect field
  /if defined(comment)
  dcl-c cPRNORMAL                  X'A0';
  dcl-c cPRRI                      X'A1';
  dcl-c cPRHI                      X'A2';
  dcl-c cPRHIRI                    X'A3';
  dcl-c cPRUL                      X'A4';
  dcl-c cPRULRI                    X'A5';
  dcl-c cPRULHI                    X'A6';
  dcl-c cPRND                      X'A7';
  dcl-c cPRBL                      X'A8';
  dcl-c cPRBLRI                    X'A9';
  dcl-c cPRBLHI                    X'AA';
  dcl-c cPRBLHIRI                  X'AB';
  dcl-c cPRBLUL                    X'AC';
  dcl-c cPRBLULRI                  X'AD';
  dcl-c cPRBLULHI                  X'AE';
  /endif
  dcl-c ccolunmSeperator           X'30'; // column sep
  dcl-c cProtected                 X'80'; // protect

/endif
