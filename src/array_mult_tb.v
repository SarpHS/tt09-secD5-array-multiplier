`timescale 1ns / 1ps

module array_mult_tb;

// Inputs
reg [3:0] m = 4'b0000;
reg [3:0] q = 4'b0000;

// Outputs
wire [7:0] p_struct;

// Reference
reg [7:0] p_ref = 8'b00000000;
integer failures = 0;

// Instantiate structural multiplier
array_mult_structural dut_struct(
	.m(m),
	.q(q),
	.p(p_struct)
);

// Stimulus
initial begin
	// Initialize Inputs (Test 0)
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 1
	m = 4'b0001;
	q = 4'b0001;
	p_ref = 8'b00000001;
	#10;

	// Test 2
	m = 4'b0010;
	q = 4'b0010;
	p_ref = 8'b00000100;
	#10;

	// Test 3
	m = 4'b1000;
	q = 4'b1000;
	p_ref = 8'b01000000;
	#10;

	// Test 4
	m = 4'b0011;
	q = 4'b0011;
	p_ref = 8'b00001001;
	#10;

	// Test 5
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 6
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 7
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 8
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 9
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// Test 10
	m = 4'b0000;
	q = 4'b0000;
	p_ref = 8'b00000000;
	#10;

	// End of test

	// Reporting
	if (failures === 0) begin
		$display("All tests passed");
	end else begin
		$display("%d tests failed", failures);
	end
	$finish;
end

// Evaluation
reg check_timer = 1'b1;

always #5 check_timer = ~check_timer;

always @(posedge check_timer) begin
	if (p_struct !== p_ref) begin
		$display("Error: p_struct = %b, p_ref = %b", p_struct, p_ref);
		failures = failures + 1;
	end
end

endmodule
