class ram_wdrv;
  
  //declarations
  ram_trans t1;						//handle packet
  mailbox #(ram_trans) mbx1;		// get the packet from the genrator 
  virtual ram_if.write_drv vif;		// interface name we have to write in 
  
  
  //mapping 
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_drv vif );
    this.mbx1=mbx1;
    this.vif=vif;
    endfunction
  
  //funcitonality
  task run();
    
    forever begin
      
      mbx1.get(t1);		// t1 is containing all the signal
      
      vif.w_drv_cb.write_en <= 1'b1;
      
      repeat(2)
        @(vif.w_drv_cb)
        
      vif.w_drv_cb.write_addr <= t1.write_addr;
      vif.w_drv_cb.write_data <= t1.write_data;
        
      repeat(2)
       @(vif.w_drv_cb)
        
        vif.w_drv_cb.write_en <= 1'b0;
        
      
    end
  endtask
  
endclass
