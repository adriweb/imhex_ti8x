/*
  TI-8x File Format pattern for ImHex
  Author: Adriweb
  Public Domain license / Do whatever you want.
  https://github.com/adriweb/imhex_ti8x/
*/

enum VarTypeID : u8 {
    Real = 0x00,
    RealList = 0x01,
    Matrix = 0x02,
    Equation = 0x03,
    String = 0x04,
    Program = 0x05,
    ProtectedProgram = 0x06,
    Picture = 0x07,
    GraphDataBase = 0x08,
    SmartEquation = 0x0B,
    Complex = 0x0C,
    ComplexList = 0x0D,
    WindowSettings = 0x0F,
    RecallWindow = 0x10,
    TableRange = 0x11,
    ScreenImage = 0x12,
    Backup = 0x13,
    AppVar = 0x15,
    PythonAppVar = 0x15,
    TemporaryItem = 0x16,
    GroupObject = 0x17,
    RealFraction = 0x18,
    DirectoryList = 0x19,
    Image = 0x1A,

    ExactComplexFrac = 0x1B,
    ExactRealRadical = 0x1C,
    ExactComplexRadical = 0x1D,
    ExactComplexPi = 0x1E,
    ExactComplexPiFrac = 0x1F,
    ExactRealPi = 0x20,
    ExactRealPiFrac = 0x21,

    OperatingSystem = 0x23,
    FlashApp = 0x24,
    Certificate = 0x25,
    AppIDList = 0x26,
    CertificateMemory = 0x27,
    Clock = 0x29,
    FlashLicense = 0x3E,
};

enum OwnerPID : u8 {
	pid83p  = 0x04,
	pid84p  = 0x0A,
	pid82a  = 0x0B,
	pid84c  = 0x0F,
	pidCE   = 0x13,
	pid84pt = 0x1B,
};

struct SigExtra {
	u8 unk0;
	u8 unk1;
	OwnerPID owner_pid;
};

struct VarHeader
{
    char signature[8];
    SigExtra sig_extra;
    char comment[42];
    u16 entries_len;
};
        
struct VarEntry
{
    u16 meta_length; // byte count of the next 3 or 5 fields (== 11 or 13) depending on calcFlags, see below
    u16 data_length;
    VarTypeID typeID;
    char varname[8];
    if (meta_length == 13) { // flash models
	    u8 version;
	    bool isArchived;
    }
    u16 data_length2; // same as data_length
    u8 data[data_length2];
};

struct Variable {
   VarHeader header;
   VarEntry entry[1]; // todo: support multiple var entries
   u16 checksum;
};

Variable var @ 0;
