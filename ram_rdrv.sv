class ram_rdrv;
  
  //declarations
  ram_trans t1;
  mailbox #(ram_trans) mbx1;
  virtual ram_if.read_drv vif;		// interface name we have to write in 
  
  
  //mapping 
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.read_drv vif );
    this.mbx1=mbx1;
    this.vif=vif;
    endfunction
  
  //funcitonality
  task run();
    forever begin
      
      mbx1.get(t1);		// t1 is containing all the signal
      
      vif.r_drv_cb.read_en <= 1'b1;
      
      repeat(2)
        @(vif.r_drv_cb)
        
      vif.r_drv_cb.read_addr <= t1.read_addr;
      //vif.w_drv_cb.read_datar <= t1.write_data;    coming from the dut no neeed to declare
        
      repeat(2)
        @(vif.r_drv_cb)
        
vif.r_drv_cb.read_en <= 1'b0;        
      
    end
  endtask
  
endclass
