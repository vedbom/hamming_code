library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_encoder_7_4_tb is
end hamming_encoder_7_4_tb;

architecture matrix_arch_7_4_tb of hamming_encoder_7_4_tb is
	constant T: time:= 20ns;
	signal test_clk, test_reset: std_logic;
	signal test_m, test_u: std_logic;
	signal test_temp_count: std_logic_vector(0 to 2);
	signal test_temp_m_reg: std_logic_vector(0 to 3);
	signal test_temp_p_reg: std_logic_vector(0 to 2);
begin
	-- instantiate the device under test
	--dut: entity work.hamming_encoder_7_4(matrix_arch_7_4)
	--port map(clk => test_clk, reset => test_reset, m => test_m, temp_count => test_temp_count, temp_m_reg => test_temp_m_reg, temp_p_reg => test_temp_p_reg, u => test_u);
	
	dut: entity work.hamming_encoder_7_4(cyclic_arch_7_4)
	port map(clk => test_clk, reset => test_reset, m => test_m, temp_count => test_temp_count, temp_p_reg => test_temp_p_reg, u => test_u);
	
	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin		
		-- m = 1001
		-- first message vector
		-- input message bit 4
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 3
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 2
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 1
		test_m <= '1';
		wait until falling_edge(test_clk);
	
		test_m <= '0';
		for i in 0 to 2 loop
			wait until falling_edge(test_clk);
		end loop;
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end matrix_arch_7_4_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_encoder_15_11_tb is
end hamming_encoder_15_11_tb;

architecture matrix_arch_15_11_tb of hamming_encoder_15_11_tb is
	constant T: time:= 20ns;
	signal test_clk, test_reset: std_logic;
	signal test_m, test_u: std_logic;
	signal test_temp_count: std_logic_vector(0 to 3);
	signal test_temp_m_reg: std_logic_vector(0 to 10);
	signal test_temp_p_reg: std_logic_vector(0 to 3);
begin
	-- instantiate the device under test
	--dut: entity work.hamming_encoder_15_11(matrix_arch_15_11)
	--port map(clk => test_clk, reset => test_reset, m => test_m, temp_count => test_temp_count, temp_m_reg => test_temp_m_reg, temp_p_reg => test_temp_p_reg, u => test_u);
	
	dut: entity work.hamming_encoder_15_11(cyclic_arch_15_11)
	port map(clk => test_clk, reset => test_reset, m => test_m, temp_count => test_temp_count, temp_p_reg => test_temp_p_reg, u => test_u);

	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin		
		-- m = 10110011101
		-- input message bit 11
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 10
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 9
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 8
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 7
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 6
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 5
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 4
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 3
		test_m <= '1';
		wait until falling_edge(test_clk);
		-- input message bit 2
		test_m <= '0';
		wait until falling_edge(test_clk);
		-- input message bit 1
		test_m <= '1';
		wait until falling_edge(test_clk);
		
		test_m <= '0';
		for i in 0 to 3 loop
			wait until falling_edge(test_clk);
		end loop;
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end matrix_arch_15_11_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_decoder_matrix_7_4_tb is
end hamming_decoder_matrix_7_4_tb;

architecture matrix_arch_7_4_tb of hamming_decoder_matrix_7_4_tb is
	constant T: time:= 20ns;
	constant TEST_COUNT_WIDTH: integer:= 3;
	signal test_clk, test_reset: std_logic;
	signal test_r: std_logic;
	signal test_temp_count: std_logic_vector(0 to TEST_COUNT_WIDTH-1);
	signal test_temp_e: std_logic_vector(0 to 6);
	signal test_temp_s: std_logic_vector(0 to 2);
	signal test_u: std_logic_vector(0 to 6);
begin	
	-- instantiate the device under test
	dut: entity work.hamming_decoder_7_4(matrix_arch_7_4)
	generic map(COUNT_WIDTH => TEST_COUNT_WIDTH)
	port map(clk => test_clk, reset => test_reset, r => test_r, temp_e => test_temp_e, temp_count => test_temp_count, temp_s => test_temp_s, u => test_u);
	
	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin
		-- original message: u = 0111001
		-- corrupted message: r = 0101001
		-- input received codeword bit 7
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 6
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 5
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 4
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 3
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 2
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 1
		test_r <= '0';
		wait until falling_edge(test_clk);
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end matrix_arch_7_4_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_decoder_7_4_cyclic_tb is
end hamming_decoder_7_4_cyclic_tb;

architecture cyclic_arch_7_4_tb of hamming_decoder_7_4_cyclic_tb is
	constant T: time:= 20ns;
	constant TEST_COUNT_WIDTH: integer:= 5;
	signal test_clk, test_reset: std_logic;
	signal test_r: std_logic;
	signal test_temp_count: std_logic_vector(0 to TEST_COUNT_WIDTH-1);
	signal test_temp_e: std_logic_vector(0 to 6);
	signal test_temp_s: std_logic_vector(0 to 2);
	signal test_r_out: std_logic;
	signal test_u: std_logic_vector(0 to 6);
begin	
	-- instantiate the device under test
	dut: entity work.hamming_decoder_7_4(cyclic_arch_7_4)
	generic map(COUNT_WIDTH => TEST_COUNT_WIDTH)
	port map(clk => test_clk, reset => test_reset, r => test_r, temp_e => test_temp_e, temp_count => test_temp_count, temp_s => test_temp_s, r_out => test_r_out, u => test_u);
	
	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin
		-- original message: u = 0111001
		-- corrupted message: r = 0101001
		-- input received codeword bit 7
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 6
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 5
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 4
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 3
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 2
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 1
		test_r <= '0';
		wait until falling_edge(test_clk);
		
		-- wait for 14 more clock cycles
		test_r <= '0';
		for i in 1 to 14 loop
			wait until falling_edge(test_clk);
		end loop;
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end cyclic_arch_7_4_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_decoder_15_11_matrix_tb is
end hamming_decoder_15_11_matrix_tb;

architecture matrix_arch_15_11_tb of hamming_decoder_15_11_matrix_tb is
	constant T: time:= 20ns;
	-- must change this constant when switching between matrix and cyclic implementations
	constant TEST_COUNT_WIDTH: integer:= 4;
	signal test_clk, test_reset: std_logic;
	signal test_r: std_logic;
	signal test_temp_count: std_logic_vector(0 to TEST_COUNT_WIDTH-1);
	signal test_temp_e: std_logic_vector(0 to 14);
	signal test_temp_s: std_logic_vector(0 to 3);
	signal test_r_out: std_logic;
	signal test_u: std_logic_vector(0 to 14);
begin	
	-- instantiate the device under test
	dut: entity work.hamming_decoder_15_11(matrix_arch_15_11) 
	generic map(COUNT_WIDTH => TEST_COUNT_WIDTH)
	port map(clk => test_clk, reset => test_reset, r => test_r, temp_e => test_temp_e, temp_count => test_temp_count, temp_s => test_temp_s, r_out => test_r_out, u => test_u);
	
	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin
		-- original message: u = 110110110011101
		-- corrupted message: r = 110110110010101
		-- input received codeword bit 15
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 14
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 13
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 12
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 11
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 10
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 9
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 8
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 7
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 6
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 5
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 4
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 3
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 2
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 1
		test_r <= '1';
		wait until falling_edge(test_clk);
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end matrix_arch_15_11_tb;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hamming_decoder_15_11_cyclic_tb is
end hamming_decoder_15_11_cyclic_tb;

architecture cyclic_arch_15_11_tb of hamming_decoder_15_11_cyclic_tb is
	constant T: time:= 20ns;
	-- must change this constant when switching between matrix and cyclic implementations
	constant TEST_COUNT_WIDTH: integer:= 6;
	signal test_clk, test_reset: std_logic;
	signal test_r: std_logic;
	signal test_temp_count: std_logic_vector(0 to TEST_COUNT_WIDTH-1);
	signal test_temp_e: std_logic_vector(0 to 14);
	signal test_temp_s: std_logic_vector(0 to 3);
	signal test_r_out: std_logic;
	signal test_u: std_logic_vector(0 to 14);
begin	
	-- instantiate the device under test
	dut: entity work.hamming_decoder_15_11(cyclic_arch_15_11) 
	generic map(COUNT_WIDTH => TEST_COUNT_WIDTH)
	port map(clk => test_clk, reset => test_reset, r => test_r, temp_e => test_temp_e, temp_count => test_temp_count, temp_s => test_temp_s, r_out => test_r_out, u => test_u);
	
	-- create a clock signal that runs forever
	process
	begin
		test_clk <= '0';
		wait for T/2;
		test_clk <= '1';
		wait for T/2;
	end process;
	
	-- toggle the reset to clear all registers of the circuit before operation
	test_reset <= '1', '0' after T/2;
	
	-- other stimuli
	process
	begin
		-- original message: u = 110110110011101
		-- corrupted message: r = 110110110010101
		-- input received codeword bit 15
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 14
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 13
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 12
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 11
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 10
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 9
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 8
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 7
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 6
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 5
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 4
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 3
		test_r <= '0';
		wait until falling_edge(test_clk);
		-- input received codeword bit 2
		test_r <= '1';
		wait until falling_edge(test_clk);
		-- input received codeword bit 1
		test_r <= '1';
		wait until falling_edge(test_clk);
		
		-- wait for 30 more clock cycles
		test_r <= '0';
		for i in 1 to 30 loop
			wait until falling_edge(test_clk);
		end loop;
		wait until rising_edge(test_clk);
		
		-- terminate the simulation
		assert false
			report "Simulation Completed"
		severity failure;
	end process;
end cyclic_arch_15_11_tb;
