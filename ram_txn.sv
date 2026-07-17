 class ram_trans;
   
   rand bit write_en;
   rand bit read_en;
   rand logic [31:0] write_addr ;
   rand logic [31:0] read_addr ;
   rand logic [31:0] write_data ;
   rand logic [31:0] read_data ;

  constraint valid_addr{ write_addr !=read_addr; }
   constraint valid_data{ write_data inside{[1:400]};}
  constraint valid_en{ {read_en,write_en} !=2'b00; }
   
endclass


