class ram_rmon;
  
  ram_trans t1,t2,t3;
  
  mailbox #(ram_trans) mbx1,mbx2;
  virtual ram_if.read_mon vif;
  
  function new(mailbox #(ram_trans) mbx1,mbx2,virtual ram_if.read_mon vif);
    this.mbx1=mbx1;
    this.mbx2=mbx2;
    this.vif=vif;
  endfunction
  
  
  //funcitonality
  task run();
    
    forever begin
      t1= new();
      
       repeat(2)
         @(vif.r_mon_cb)
         
         wait(vif.r_mon_cb.read_en);		//it has to wait till its high 
      
         t1.read_addr= vif.r_mon_cb.read_addr;
         t1.read_data= vif.r_mon_cb.read_data;
      
      
       repeat(2)
         @(vif.r_mon_cb)
         
         t2= new t1;
     	 t3 = new t1;
      
      	 mbx1.put(t2);	//to the SB
     	 mbx2.put(t3); 	// to the referance model
    end
    
  endtask
  
endclass
