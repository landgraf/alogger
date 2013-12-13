with alogger.internal.message_buffers;
use alogger.internal.message_buffers;
with alogger.internal.message_writers;
use alogger.internal.message_writers;
package alogger.internal.message_workers is 
    task type message_worker(buffer : any_buffer; writer : any_writer) is 
        entry Start;
        entry Stop;
    end message_worker;
    type any_worker is access all message_worker;

end alogger.internal.message_workers; 

