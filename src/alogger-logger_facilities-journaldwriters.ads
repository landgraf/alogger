with Ada.Text_IO; use Ada.Text_IO;
package alogger.logger_facilities.journaldwriters is 
    type jornaldwriter is new logger_facility with private;
    type jornaldwriter_access is access all jornaldwriter;


    overriding
    procedure Write (Self : in out jornaldwriter; Message : in Any_Message);

    overriding
    procedure Finalize(Self : in out jornaldwriter);

    overriding
    procedure Init(Self : in out jornaldwriter) is null;

    package Constructors is
        function Create return jornaldwriter_access; 
    end Constructors; 

    private

    type jornaldwriter is new logger_facility with record
        Filename : Unbounded_String;
        File : File_Type; 
        Finame : Unbounded_String; 
    end record;



end alogger.logger_facilities.journaldwriters; 

