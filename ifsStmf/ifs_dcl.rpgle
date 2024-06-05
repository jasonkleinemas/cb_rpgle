**free
/if not defined(ifs_proc_d)
/define ifs_proc_d

// Directory processing definitions
  dcl-ds ifsDirEnt qualified template;
     reserved1 char(16);
     reserved2 uns(10);
     fileno    uns(10);
     reclen    uns(10);
     reserved3 int(10);
     reserved4 char(8);
     nlsinfo   char(12);
     namelen   uns(10);
     name      char(640);
  end-ds;

// File status definitions
  dcl-ds ifsFileStatus qualified template;
    mode      uns(10);
    ino       uns(10);
    nlink     int(5);
    pad       char(2);
    uid       uns(10);
    gid       uns(10);
    size      int(10);
    atime     int(10);
    mtime     int(10);
    ctime     int(10);
    dev       uns(10);
    blksize   uns(10);
    alcsize   uns(10);
    objtype   char(12);
    codepage  uns(5);
    reserved1 char(62);
    inogenid  uns(10);
  end-ds;

  dcl-c ifs_dirMask_C_MODE x'0001F000';
  dcl-c ifs_dirVal_C_MODE  x'00004000';

/endif

