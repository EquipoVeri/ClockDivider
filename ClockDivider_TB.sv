timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module ClockDivider_TB;

parameter FREQUENCY = 100;
parameter REFERENCE_CLOCK = 50_000_000;
parameter MAXIMUM_VALUE = MaxValue(FREQUENCY, REFERENCE_CLOCK);
parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE);

 // Input Ports
bit clk_FPGA = 0;
bit reset;
bit enable;
	
  // Output Ports
bit clock_signal; 


ClockDivider
#(
	// Parameter Declarations
		.FREQUENCY(FREQUENCY),
		.REFERENCE_CLOCK(REFERENCE_CLOCK),
		.MAXIMUM_VALUE(MAXIMUM_VALUE),
		.NBITS_FOR_COUNTER(NBITS_FOR_COUNTER)
)
DUT
(
	// Input Ports
	.clk_FPGA(clk_FPGA),
	.reset(reset),
	.enable(enable),
	
	// Output Ports
	.clock_signal(clock_signal) 

);	

/*********************************************************/
initial // Clock generator
  begin
    forever #20 clk_FPGA = !clk_FPGA;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#5 reset = 1;
end

/*********************************************************/
initial begin // enable
	#0 enable = 1;
	#6 enable = 1;
end

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 
  /*Log Function*/
     function integer MaxValue;
       input integer clock;
		 input integer f;
       integer i,result;
       begin
          for(i=0; i < clock; i=i+f)
             result = i;
          MaxValue = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/

endmodule
