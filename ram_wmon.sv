class ram_wmon;
  
  ram_trans t1,t2;
  
  mailbox #(ram_trans) mbx1;
  virtual ram_if.write_mon vif;
  
  function new(mailbox #(ram_trans) mbx1,virtual ram_if.write_mon vif);
    this.mbx1=mbx1;
    this.vif=vif;
  endfunction
  
  
  //funcitonality
  task run();
    
    forever begin
      t1= new();
      
       repeat(2)
         @(vif.w_mon_cb)
         
         wait(vif.w_mon_cb.write_en);		//it has to wait till its high  then only will sample the balue
      
         t1.write_addr= vif.w_mon_cb.write_addr;
         t1.write_data= vif.w_mon_cb.write_data;
      
      
       repeat(2)
         @(vif.w_mon_cb)
         
         t2= new t1;		//shallow cpy
     	 mbx1.put(t2);		//putipng to the mail box
           
           
    end
    
  endtask
  
endclass
