**Free
//
// Common data structure format 0300
//
// https://www.ibm.com/docs/en/i/7.4?topic=spaces-common-data-structure-formats
//
//
// Read genericHeaderFormat0100 first. To find out where to start with this.
//
  dcl-ds genericHeaderFormat0300;
	ghf0300_apiEntryPoint char(256) inz(''); //  The name of the ILE bindable API entry point that generates the list.
	ghf0300_reserved      char(128) inz(''); //  
  end-ds;