library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
USE ieee.math_real.ALL;
use ieee.std_logic_arith.all;
 
entity bloc_TB is
end bloc_TB; 


architecture behavior of bloc_TB is
	constant clk_period	: time := 10 ns;

	component Bloc is
	  port(

		--System 
		CLOCK_50   : in std_logic;
		rst_n : in std_logic;
		
		--I2C signals.
		SDA : inout std_logic;
		CL : inout std_logic;

		-- Two registers to read the sensor
		REG1 : in std_logic_vector(8 downto 0);
		REG2 : in std_logic_vector(8 downto 0);
		REG3 : in std_logic_vector(8 downto 0);
		REG_OUT : out std_logic_vector(7 downto 0)
	  );
	end component;
	
	component I2C_S_RX is
		generic(
			WR		: std_logic:= '0';
					-- device address
			DEVICE	: std_logic_vector(6 downto 0):= "0100001";		   
					-- sub address
			ADDR	: std_logic_vector(7 downto 0):= "01000001"		
		);
		port(
			RST		: in std_logic;
			CL		: in std_logic;
			SDA		: inout std_logic;
						-- Recepted over i2c data byte
			DOUT		: out std_logic_vector(7 downto 0);			   
			DATA_RDY	: out std_logic 					
		);
	end component;
		
	signal	CLOCK_50   : std_logic;
	signal 	rst_n : std_logic;
	signal SDA :  std_logic;
	signal CL :  std_logic;
	signal REG1 : std_logic_vector(7 downto 0);
	signal REG2 : std_logic_vector(7 downto 0);
	signal REG3 : std_logic_vector(7 downto 0);
	signal REG_OUT : std_logic_vector(7 downto 0);
		 
	signal i2c_s_rx_data			: std_logic_vector(7 downto 0);
	signal i2c_s_rx_data_rdy	: std_logic;								
	
	BEGIN
	
  UUT:Bloc
  port map(
		CLOCK_50       => CLOCK_50,
		rst_n   => rst_n,
		SDA       => SDA,
		CL      => CL,
		REG1        => REG1,
		REG2   => REG2,
		REG3        => REG3,
		REG_OUT   => REG_OUT
	);

	I_I2C_S_RX: I2C_S_RX
	port map (
		CL 		=> CL,
		RST 		=> rst_n,
		SDA 		=> SDA,
		DOUT 		=> i2c_s_rx_data,
		DATA_RDY	=> i2c_s_rx_data_rdy 
	); 	
	
	P_CLK: process 
	begin
		CLOCK_50 <= '1';
		wait for clk_period/2;
		CLOCK_50 <= '0';
		wait for clk_period/2;
	end process;
	
	P_RST_N: process
	begin	
		rst_n <= '0';	
		wait for clk_period*2;
		rst_n <= '1';			
		wait;
	end process;



end behavior;