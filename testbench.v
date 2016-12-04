module cpu_testbench();
  
 reg reset = 0;
 reg clock = 0;
 reg newinstr = 0;
 reg [31:0] instrword;
 mipscpu myCPU(reset, clock, instrword,newinstr);
 


initial begin
 clock = 0;
 myCPU.myDatapath.registerfile_instance.registerFile[0]=0;
 myCPU.myDatapath.registerfile_instance.registerFile[1]=0;
 myCPU.myDatapath.registerfile_instance.registerFile[31]=0; //guarantee a zero in reg 31
 myCPU.myDatapath.memory_instance.memoryFile[0]=10; //variable a = 10
 myCPU.myDatapath.memory_instance.memoryFile[1]=22; //variable b = 22
 myCPU.myDatapath.memory_instance.memoryFile[2]=6; //variable a = 6

 instrword = 32'b10001111111000010000000000000000;// lw $1, 0($0)
 newinstr=0;
 #1 newinstr=1;
 #1 newinstr=0;
 #100;
 instrword = 32'b10001111111000100000000000000001;// lw $2, 1($0)
 #1 newinstr=1;
 #1 newinstr=0;
 #100;
 instrword = 32'b10001111111000110000000000000010;// lw $2, 1($0)
 #1 newinstr=1;
 #1 newinstr=0;
 #100;
 $display("%s%d", "Value at register one: ", myCPU.myDatapath.registerfile_instance.registerFile[1]);
 $display("%s%d", "Value at register two: ", myCPU.myDatapath.registerfile_instance.registerFile[2]);
 $display("%s%d", "Value at register three: ", myCPU.myDatapath.registerfile_instance.registerFile[3]);
 $finish;
end


always #3 clock=~clock;
 
endmodule
