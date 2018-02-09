module ClockDivider
#(
	// Parameter Declarations
	parameter FREQUENCY = 100,
	parameter REFERENCE_CLOCK = 50_000_000,
	parameter MAXIMUM_VALUE = MaxValue(FREQUENCY, REFERENCE_CLOCK),
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk_FPGA,
	input reset,
	input enable,
	
	// Output Ports
	output clock_signal
);


bit MaxValue_Bit;
logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;

	always_ff@(posedge clk_FPGA or negedge reset) begin
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
		else begin
				if(enable == 1'b1)
					if(Count_logic == MAXIMUM_VALUE - 1)
						Count_logic <= 0;
					else
						Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------

always_comb
	if(Count_logic == MAXIMUM_VALUE-1)
		MaxValue_Bit = !MaxValue_Bit;
	else
		MaxValue_Bit = MaxValue_Bit;

		
//---------------------------------------------------------------------------------------------
assign clock_signal = MaxValue_Bit;
//----------------------------------------------------------------------------------------------

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
