class ram_sb;
  
  ram_trans t1, t2;
  mailbox #(ram_trans)mbx1,mbx2;
  
    function new(mailbox #(ram_trans) mbx1,mbx2);
    this.mbx1=mbx1;
    this.mbx2=mbx2;
  endfunction
  
  task run();
    
    forever begin
      
    fork
		mbx1.get(t1);	//from rmon
   	    mbx2.get(t2);	//from the ref model
    join
    
    
    if(t1.read_addr != t2.read_addr)
    $display("adddress miss match error");
    
    else if(t1.read_data != t2.read_data)
        $display("data mismatch error");
    else
      $display("data matched successfully  the addrs value is :%0d & the data value is :%0d ",t1.read_addr,t1.read_data);
    end
  endtask
endclass
