module toggle_value
(
	// Input Ports
	input count,
	input BitValue,
	input MaxValue,
	
	// Output Ports
	output clock_signal
);

bit output_log;

always_comb begin

if(count == MaxValue-1)
	output_log = !BitValue;

end

assign clock_signal = output_log;

endmodule
