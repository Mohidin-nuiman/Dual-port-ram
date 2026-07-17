class ram_gen;
  
  //declarations
  ram_trans txn, t1,t2;
  mailbox #(ram_trans) mbx1,mbx2;
  
  //Mapping 
  function new(mailbox #(ram_trans) mbx1,mbx2);
    this.mbx1= mbx1;
    this.mbx2= mbx2;
    endfunction
  
  //Functionality
  task run();
    
    txn =new();
    repeat(5)
      begin
      assert(txn.randomize() with {write_addr == 8'd7;
    read_addr  == 8'd7;
    write_data == 32'd99;});		//packet generation 
        
        t1 =new txn;				// shallow copy
        t2 =new txn;				// shallow copy		avoid data correction in generation packet
        
        mbx1.put(t1);	//sending to write driver
        mbx2.put(t2);	//snedint to rdrv
      end
  endtask
    
endclass
