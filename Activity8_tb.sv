module Activity8_tb();
	localparam DATA_WIDTH  = 8;

	// dut signals
	logic clk = 0, reset = 0, load = 0, display = 0;
	logic [DATA_WIDTH-1:0] value = 0;
	logic [2*DATA_WIDTH-1:0] sum;

	// tb signals
	integer error_count = 0;
	integer total_tests = 0;

	// Device under test
	Activity8 #(.DATA_WIDTH(DATA_WIDTH)) dut (
		.clk     (clk),
		.reset   (reset),
		.load    (load),
		.display (display),
		.value   (value),
		.sum     (sum)
	);

	initial begin
		$display("============== Starting simulation ==============");

		do_reset();

		// Ensure initial reset works
		verify_display(0);

		// Load and then display
		do_load(1);
		value = 5;
		do_display();
		verify_display(1);

		// Reset and check display
		do_reset();
		verify_display(0);
		do_display();
		verify_display(0);

		// Sum to seven
		do_add(1);
		verify_display(0);
		do_add(2);
		verify_display(0);
		do_add(4);
		do_display();
		verify_display(7);
		do_add(4);
// for next time, checks that output remains Sum
//		verify_display(7);

		// Ensure more than 8 bits used in display
		do_reset();
		do_add(8'hFF);
		do_add(8'hFF);
		do_add(8'hFF);
		do_add(8'hFF);
		do_display();
		verify_display(16'h03FC);

		$display("%d errors found.", error_count);
		$display("%d total tests performed.", total_tests);
		$display("============== Simulation complete ==============");
		$stop;
	end

	// Clock generator
	always begin
		#1 clk = ~clk;
	end

	task do_reset;
	begin
		// Reset for two active clock edges
		reset = 1'b1;
		repeat(2) @(posedge clk);
		reset = 1'b0;
	end
	endtask

	task do_load;
		input [DATA_WIDTH-1:0] val;
	begin
		wait(clk == 1'b0);
		value = val;
		load = 1'b1;
		@(posedge clk);
		wait(clk == 1'b0);
		load = 1'b0;
	end
	endtask

	task do_add;
		input [DATA_WIDTH-1:0] val;
	begin
		wait(clk == 1'b0);
		value = val;
		load = 1'b0;
		display = 1'b0;
		@(posedge clk);
		wait(clk == 1'b0);
	end
	endtask

	task do_display;
	begin
		wait(clk == 1'b0);
		display = 1'b1;
		@(posedge clk);
		wait(clk == 1'b0);
		display = 1'b0;
	end
	endtask

	task verify_display;
		input [2*DATA_WIDTH-1:0] val;
	begin
		if( sum !== val ) begin
			$display("%t Error in display: DUT provided %04h, but expected %04h", $time, sum, val);
			error_count = error_count + 1;
		end
		total_tests = total_tests + 1;
	end
	endtask
endmodule
