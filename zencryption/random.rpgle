**Free
//
// Not working returns string not number.
//
//
//
  dcl-proc randomNumber;
    dcl-pi randomNumber char(10);
      
    end-pi;

    dcl-pr QC3GENRN extpgm('QC3GENRN');
     *n options(*varsize) like(prn_data); // Prn Data - The generated pseudorandom binary stream.
     *n int(10) const; // PRN data length - The number of pseudorandom number bytes to return in the PRN data parameter. If 0 is specified, no pseudorandom numbers are returned
     *n char(1) const; // PRN type - The API can generate a real pseudorandom binary stream or a test binary stream.
      // 0 - Generate real pseudorandom numbers.
      // 1 - Generate test pseudorandom numbers.
     *n char(1) const; // PRN Parity - The API sets each byte of the pseudorandom number binary stream to the specified parity by altering the low order bit in each byte as necessary.
      // 0 - Do not set parity.
      // 1 - Set each byte to odd parity.
      // 2 - Set each byte to even parity
     *n options(*omit:*varsize) like(dsApiError0100); // ErrorDS
    end-pr;

    dcl-s prn_data char(2) inz('45');


    QC3GENRN (
      prn_data : 2 :
      '0'  : '0' :
      dsApiError0100
    );
    
    return prn_data;
    
  end-proc;