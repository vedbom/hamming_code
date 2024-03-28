library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- (7,4) hamming code

entity hamming_encoder_7_4 is
	port(
		clk, reset: in std_logic;
		m: in std_logic;
		temp_count: out std_logic_vector(0 to 2);
		temp_m_reg: out std_logic_vector(0 to 3);
		temp_p_reg: out std_logic_vector(0 to 2);
		u: out std_logic
		);
end hamming_encoder_7_4;

architecture matrix_arch_7_4 of hamming_encoder_7_4 is
	signal m_reg, m_next: std_logic_vector(0 to 3);
	signal p_reg, p_next: std_logic_vector(0 to 2);
	signal count_reg, count_next: unsigned(0 to 2);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			m_reg <= (others => '0');
			p_reg <= (others => '0');
			count_reg <= "110";
		elsif(clk'event and clk='1') then
			m_reg <= m_next;
			p_reg <= p_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 6 else count_reg + 1;
	m_next <= m & m_reg(0 to 2);
	
	process(count_reg)
	begin
		-- shift-in the message bits into the message register
		-- at the same time shift-out the incoming message bit to the channel
		if(count_reg < 4) then
			u <= m;
			p_next(0) <= m_reg(0) xor m_reg(2) xor m_reg(3);
			p_next(1) <= m_reg(0) xor m_reg(1) xor m_reg(2);
			p_next(2) <= m_reg(1) xor m_reg(2) xor m_reg(3);
		-- shift-out the parity bits into the channel
		else
			u <= p_reg(2);
			p_next <= '0' & p_reg(0 to 1);
		end if;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_m_reg <= m_reg;
	temp_p_reg <= p_reg;
end matrix_arch_7_4;

architecture cyclic_arch_7_4 of hamming_encoder_7_4 is
	signal count_reg, count_next: unsigned(0 to 2);
	signal p_reg, p_next: std_logic_vector(0 to 2);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			p_reg <= (others => '0');
			count_reg <= "110";
		elsif(clk'event and clk = '1') then
			p_reg <= p_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 6 else count_reg + 1;
	
	process(count_reg)
	begin
		-- shift the message bits onto the channel
		-- while simultaneously shifting the message bits into the LFSR
		if(count_reg < 4) then
			u <= m;
			p_next(0) <= p_reg(2) xor m;
			p_next(1) <= p_reg(0) xor p_reg(2) xor m;
			p_next(2) <= p_reg(1);
		else
			u <= p_reg(2);
			p_next <= '0' & p_reg(0 to 1);
		end if;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_p_reg <= p_reg;
end cyclic_arch_7_4;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- (15, 11) hamming encoder

entity hamming_encoder_15_11 is
	generic(
		N: integer:= 15;
		K: integer:= 11;
		P: integer:= 4
		);
	port(
		clk, reset: in std_logic;
		m: in std_logic;
		temp_count: out std_logic_vector(0 to 3);
		temp_m_reg: out std_logic_vector(0 to 10);
		temp_p_reg: out std_logic_vector(0 to 3);
		u: out std_logic
		);
end hamming_encoder_15_11;

architecture matrix_arch_15_11 of hamming_encoder_15_11 is
	signal m_reg, m_next: std_logic_vector(0 to 10);
	signal p_reg, p_next: std_logic_vector(0 to 3);
	signal count_reg, count_next: unsigned(0 to 3);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			m_reg <= (others => '0');
			p_reg <= (others => '0');
			count_reg <= "1110";
		elsif(clk'event and clk='1') then
			m_reg <= m_next;
			p_reg <= p_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 14 else count_reg + 1;
	m_next <= m & m_reg(0 to 9);
	
	process(count_reg)
	begin
		-- shift-in the message bits into the message register
		-- at the same time shift-out the incoming message bit to the channel
		if(count_reg < 11) then
			u <= m;
			p_next(0) <= m_reg(0) xor m_reg(3) xor m_reg(4) xor m_reg(6) xor m_reg(8) xor m_reg(9) xor m_reg(10);
			p_next(1) <= m_reg(0) xor m_reg(1) xor m_reg(3) xor m_reg(5) xor m_reg(6) xor m_reg(7) xor m_reg(8);
			p_next(2) <= m_reg(1) xor m_reg(2) xor m_reg(4) xor m_reg(6) xor m_reg(7) xor m_reg(8) xor m_reg(9);
			p_next(3) <= m_reg(2) xor m_reg(3) xor m_reg(5) xor m_reg(7) xor m_reg(8) xor m_reg(9) xor m_reg(10);
		-- shift-out the parity bits into the channel
		else
			u <= p_reg(3);
			p_next <= '0' & p_reg(0 to 2);
		end if;
	end process;

	temp_count <= std_logic_vector(count_reg);
	temp_m_reg <= m_reg;
	temp_p_reg <= p_reg;
end matrix_arch_15_11;

architecture cyclic_arch_15_11 of hamming_encoder_15_11 is
	signal count_reg, count_next: unsigned(0 to 3);
	signal p_reg, p_next: std_logic_vector(0 to 3);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			p_reg <= (others => '0');
			count_reg <= "1110";
		elsif(clk'event and clk = '1') then
			p_reg <= p_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 14 else count_reg + 1;
	
	process(count_reg)
	begin
		-- shift the message bits onto the channel
		-- while simultaneously shifting the message bits into the LFSR
		if(count_reg < 11) then
			u <= m;
			p_next(0) <= p_reg(3) xor m;
			p_next(1) <= p_reg(0) xor p_reg(3) xor m;
			p_next(2) <= p_reg(1);
			p_next(3) <= p_reg(2);
		else
			u <= p_reg(3);
			p_next <= '0' & p_reg(0 to 2);
		end if;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_p_reg <= p_reg;
end cyclic_arch_15_11;

-- (7, 4) hamming decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_decoder_7_4 is
	generic(
		COUNT_WIDTH: integer:= 3
		);
	port(
		clk, reset: in std_logic;
		r: in std_logic;
		temp_e: out std_logic_vector(0 to 6);
		temp_count: out std_logic_vector(0 to COUNT_WIDTH-1);
		temp_s: out std_logic_vector(0 to 2);
		r_out: out std_logic;
		u: out std_logic_vector(0 to 6)
		);
end hamming_decoder_7_4;

architecture matrix_arch_7_4 of hamming_decoder_7_4 is
	signal r_reg, r_next: std_logic_vector(0 to 6);
	signal s: std_logic_vector(0 to 2);
	signal count_reg, count_next: unsigned(0 to COUNT_WIDTH-1);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			r_reg <= (others => '0');
			count_reg <= "110";
		elsif(clk'event and clk='1') then
			r_reg <= r_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 6 else count_reg + 1;
	r_next <= r & r_reg(0 to 5);
	
	-- calculate the syndrome
	s(0) <= r_reg(0) xor r_reg(3) xor r_reg(5) xor r_reg(6);
	s(1) <= r_reg(1) xor r_reg(3) xor r_reg(4) xor r_reg(5);
	s(2) <= r_reg(2) xor r_reg(4) xor r_reg(5) xor r_reg(6);
	
	-- decode the syndrome to get the error pattern
	-- add the error pattern to the received codeword to get the correct codeword
	process(s, r_reg)
	begin
		case(s) is
			when "000" => 
				u <= r_reg xor "0000000";
				temp_e <= "0000000";
			when "001" => 
				u <= r_reg xor "0010000";
				temp_e <= "0010000";
			when "010" => 
				u <= r_reg xor "0100000";
				temp_e <= "0100000";
			when "011" => 
				u <= r_reg xor "0000010";
				temp_e <= "0000010";
			when "100" => 
				u <= r_reg xor "1000000";
				temp_e <= "1000000";
			when "101" => 
				u <= r_reg xor "0000100";
				temp_e <= "0000100";
			when "110" => 
				u <= r_reg xor "0001000";
				temp_e <= "0001000";
			-- s = 111
			when others => 
				u <= r_reg xor "0000001";
				temp_e <= "0000001";
		end case;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_s <= s;
end matrix_arch_7_4;

architecture cyclic_arch_7_4 of hamming_decoder_7_4 is
	signal count_reg, count_next: unsigned(0 to COUNT_WIDTH-1);
	signal s_reg, s_next: std_logic_vector(0 to 2);
	signal buf_reg, buf_next: std_logic_vector(0 to 6);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			count_reg <= "10100";
			s_reg <= (others => '0');
			buf_reg <= (others => '0');
		elsif(clk'event and clk = '1') then
			count_reg <= count_next;
			s_reg <= s_next;
			buf_reg <= buf_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 20 else count_reg + 1;
	
	process(count_reg)
	begin
		-- simultaneously shift the received bits into the LFSR for calculating the syndrome
		-- and into the buffer register
		if(count_reg < 7) then
			buf_next <= r & buf_reg(0 to 5);
			s_next(0) <= s_reg(2) xor r;
			s_next(1) <= s_reg(0) xor s_reg(2);
			s_next(2) <= s_reg(1);
			r_out <= '0';
		-- calculate the output of the AND gate and feed it back into the LFSR and into the buffer register
		elsif(count_reg >= 7 and count_reg < 14) then
			buf_next <= (buf_reg(6) xor (s_reg(0) and not s_reg(1) and s_reg(2))) & buf_reg(0 to 5);
			s_next(0) <= s_reg(2) xor (s_reg(0) and not s_reg(1) and s_reg(2));
			s_next(1) <= s_reg(0) xor s_reg(2);
			s_next(2) <= s_reg(1);
			r_out <= '0';
		-- shift out the corrected codeword stored in the buffer register onto the channel
		else
			buf_next <= '0' & buf_reg(0 to 5);
			s_next <= (others => '0');
			r_out <= buf_reg(6);
		end if;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_s <= s_reg;
end cyclic_arch_7_4;

-- (15, 11) hamming decoder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_decoder_15_11 is
	generic(
		COUNT_WIDTH: integer:= 4
		);
	port(
		clk, reset: in std_logic;
		r: in std_logic;
		temp_e: out std_logic_vector(0 to 14);
		temp_count: out std_logic_vector(0 to COUNT_WIDTH-1);
		temp_s: out std_logic_vector(0 to 3);
		r_out: out std_logic;
		u: out std_logic_vector(0 to 14)
	);
end hamming_decoder_15_11;

architecture matrix_arch_15_11 of hamming_decoder_15_11 is	
	signal r_reg, r_next: std_logic_vector(0 to 14);
	signal s: std_logic_vector(0 to 3);
	signal count_reg, count_next: unsigned(0 to COUNT_WIDTH-1);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			r_reg <= (others => '0');
			count_reg <= "1110";
		elsif(clk'event and clk='1') then
			r_reg <= r_next;
			count_reg <= count_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 14 else count_reg + 1;
	r_next <= r & r_reg(0 to 13);
	
	-- calculate the syndrome
	s(0) <= r_reg(0) xor r_reg(4) xor r_reg(7) xor r_reg(8) xor r_reg(10) xor r_reg(12) xor r_reg(13) xor r_reg(14);
	s(1) <= r_reg(1) xor r_reg(4) xor r_reg(5) xor r_reg(7) xor r_reg(9) xor r_reg(10) xor r_reg(11) xor r_reg(12);
	s(2) <= r_reg(2) xor r_reg(5) xor r_reg(6) xor r_reg(8) xor r_reg(10) xor r_reg(11) xor r_reg(12) xor r_reg(13);
	s(3) <= r_reg(3) xor r_reg(6) xor r_reg(7) xor r_reg(9) xor r_reg(11) xor r_reg(12) xor r_reg(13) xor r_reg(14);
	
	-- decode the syndrome to get the error pattern
	-- add the error pattern to the received codeword to get the correct codeword
	process(s, r_reg)
	begin
		case(s) is
			when "0000" => 
				u <= r_reg xor "000000000000000";
				temp_e <= "000000000000000";
			when "0001" => 
				u <= r_reg xor "000100000000000";
				temp_e <= "000100000000000";
			when "0010" => 
				u <= r_reg xor "001000000000000";
				temp_e <= "001000000000000";
			when "0011" => 
				u <= r_reg xor "000000100000000";
				temp_e <= "000000100000000";
			when "0100" => 
				u <= r_reg xor "010000000000000";
				temp_e <= "010000000000000";
			when "0101" => 
				u <= r_reg xor "000000000100000";
				temp_e <= "000000000100000";
			when "0110" => 
				u <= r_reg xor "000001000000000";
				temp_e <= "000001000000000";
			when "0111" =>
				u <= r_reg xor "000000000001000";
				temp_e <= "000000000001000";
			when "1000" =>
				u <= r_reg xor "100000000000000";
				temp_e <= "100000000000000";
			when "1001" =>
				u <= r_reg xor "000000000000001";
				temp_e <= "000000000000001";
			when "1010" =>
				u <= r_reg xor "000000001000000";
				temp_e <= "000000001000000";
			when "1011" =>
				u <= r_reg xor "000000000000010";
				temp_e <= "000000000000010";
			when "1100" =>
				u <= r_reg xor "000010000000000";
				temp_e <= "000010000000000";
			when "1101" =>
				u <= r_reg xor "000000010000000";
				temp_e <= "000000010000000";
			when "1110" =>
				u <= r_reg xor "000000000010000";
				temp_e <= "000000000010000";
			when others => 
				u <= r_reg xor "000000000000100";
				temp_e <= "000000000000100";
		end case;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_s <= s;
end matrix_arch_15_11;

architecture cyclic_arch_15_11 of hamming_decoder_15_11 is
	signal count_reg, count_next: unsigned(0 to COUNT_WIDTH-1);
	signal s_reg, s_next: std_logic_vector(0 to 3);
	signal buf_reg, buf_next: std_logic_vector(0 to 14);
begin
	-- register
	process(clk, reset)
	begin
		if(reset = '1') then
			count_reg <= "101100";
			s_reg <= (others => '0');
			buf_reg <= (others => '0');
		elsif(clk'event and clk = '1') then
			count_reg <= count_next;
			s_reg <= s_next;
			buf_reg <= buf_next;
		end if;
	end process;
	
	-- next state and output logic
	count_next <= (others => '0') when count_reg = 44 else count_reg + 1;
	
	process(count_reg)
	begin
		-- simultaneously shift the received bits into the LFSR for calculating the syndrome
		-- and into the buffer register
		if(count_reg < 15) then
			buf_next <= r & buf_reg(0 to 13);
			s_next(0) <= s_reg(3) xor r;
			s_next(1) <= s_reg(0) xor s_reg(3);
			s_next(2) <= s_reg(1);
			s_next(3) <= s_reg(2);
			r_out <= '0';
		-- calculate the output of the AND gate and feed it back into the LFSR and into the buffer register
		elsif(count_reg >= 15 and count_reg < 30) then
			buf_next <= (buf_reg(14) xor (s_reg(0) and not s_reg(1) and not s_reg(2) and s_reg(3))) & buf_reg(0 to 13);
			s_next(0) <= s_reg(3) xor (s_reg(0) and not s_reg(1) and not s_reg(2) and s_reg(3));
			s_next(1) <= s_reg(0) xor s_reg(3);
			s_next(2) <= s_reg(1);
			s_next(3) <= s_reg(2);
			r_out <= '0';
		-- shift out the corrected codeword stored in the buffer register onto the channel
		else
			buf_next <= '0' & buf_reg(0 to 13);
			s_next <= (others => '0');
			r_out <= buf_reg(14);
		end if;
	end process;
	
	temp_count <= std_logic_vector(count_reg);
	temp_s <= s_reg;
	u <= buf_reg;
end cyclic_arch_15_11;
