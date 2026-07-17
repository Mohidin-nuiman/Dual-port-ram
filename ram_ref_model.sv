class ref_model;
  
  
  ram_trans t1,t2,t3;
  mailbox #(ram_trans)mbx1, mbx2,mbx3;
  
    int mem[int];		//mem to store value in RM

  
  function new(mailbox #(ram_trans) mbx1, mbx2, mbx3);
    this.mbx1=mbx1;
    this.mbx2=mbx2;
    this.mbx3=mbx3;
  endfunction
  
  task run();
    
    forever begin 
      
      t1=new();
      
      fork
        //write monitr
        begin
        mbx1.get(t1);	//from the wmon
        mem[t1.write_addr]= t1.write_data;
        end
        
        //read  montr
        begin
          mbx2.get(t2);	//from the rmon
          
          if(mem.exists(t2.read_addr))		//mem.exist check whethr any data is there
          t2.read_data= mem[t2.read_addr];
          
          else
            $display("RM Data doesnt exist in this read addr");
          
          t3 =new t2;		//shallow copy
          mbx3.put(t3);		//to the SB
          
        end
        
      join
      
    end
  endtask
  endclass
