with Ada.Text_IO; use Ada.Text_IO;
package alogger.internal.message_writers.filewriters is 
    type filewriter(Filename : String_Access) is new writer with private;
    
    overriding
    procedure Write (Self : in out filewriter; Message : in out Any_Message);

    overriding
    procedure Finalize(Self : in out filewriter);

    overriding
    procedure Init(Self : in out filewriter);
    private

    type filewriter(Filename : String_Access) is new writer with record
        File : File_Type; 
        Finame : Unbounded_String; 
    end record;

end alogger.internal.message_writers.filewriters; 

