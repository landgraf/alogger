with Ada.Finalization; use Ada.Finalization;
with alogger.internal.messages; use alogger.internal.messages;
with fifos;
package alogger.internal.message_buffers is 
    type message_buffer is
        new Limited_Controlled with private;
    type any_buffer is access all message_buffer'Class; 

    not overriding
    procedure Put(Self : in out message_buffer; Item : in Any_Message); 

    not overriding
    procedure Get(Self : in out message_buffer; Item : out Any_Message);

    not overriding
    procedure Finish (Self : in out message_buffer);

    private
    Max : Natural := 2**10;
    package message_fifos is new fifos(Any_Message, Max, null);
    subtype buffer is message_fifos.fifo;
    type buffer_access is access all buffer;

    type message_buffer is
        new Limited_Controlled with record
            buf : buffer_access := new buffer;

    end record;


end alogger.internal.message_buffers; 

