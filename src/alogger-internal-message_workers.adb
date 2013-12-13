with Ada.Text_IO; use Ada.Text_IO;
with Alogger.internal.messages; use alogger.internal.messages;
package body alogger.internal.message_workers is 

    task body message_worker is 
        message : any_message := null;
    begin
        accept Start; 
        loop
                buffer.get(message);
                exit when message = null;
                writer.write(message);
        end loop;
    end message_worker;


end alogger.internal.message_workers; 

