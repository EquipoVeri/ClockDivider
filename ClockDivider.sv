module ClockDivider
#(
	// Parameter Declarations
	parameter FREQUENCY = 25_000_000,
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

bit MaxValue_Bit = 0;


logic [NBITS_FOR_COUNTER : 0] Count_logic;

	always_ff@(posedge clk_FPGA or negedge reset) begin
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
		else begin
				if(enable == 1'b1)
					if(Count_logic == MAXIMUM_VALUE - 1)begin
						Count_logic <= 0;
						MaxValue_Bit = !MaxValue_Bit;
						end
					else
						Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------

//toggle_value tog (.count(Count_logic), .BitValue(), .MaxValue(MAXIMUM_VALUE), .clock_signal());

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
          for(i=0; 2**i <= data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 
 /*MaxValue Function*/
     function integer MaxValue;
       input integer f;
	input integer clock;
       integer i, result;
       begin
          for(i=0,result=0; result < clock; i=i+1)
             result = result + f;
          MaxValue = i;
       end
    endfunction


/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 
endmodule
