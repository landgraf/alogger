with Ada.Text_IO; use Ada.Text_IO;
package alogger.logger_facilities.filewriters is 
    type filewriter is new logger_facility with private;
    type filewriter_access is access all filewriter;
    
    overriding
    procedure Write (Self : in out filewriter; Message : in Any_Message);

    overriding
    procedure Finalize(Self : in out filewriter);

    overriding
    procedure Init(Self : in out filewriter);

    package Constructors is
        function Create(Filename : in String) return filewriter_access;
    end Constructors; 

    private

    type filewriter is new logger_facility with record
        Filename : Unbounded_String;
        File : File_Type; 
        Finame : Unbounded_String; 
    end record;


end alogger.logger_facilities.filewriters; 

